// Interface:-------------------------------------------------------------------
import 'dart:async';

import 'package:maple_common/maple_common.dart';

abstract class StreamUtilsInterface {
  StreamController<R> combine<T, R>(
    Iterable<Stream<T>> streams,
    R Function(List<T?> values) combiner,
  );
}

// Implementation:--------------------------------------------------------------
class StreamUtils implements StreamUtilsInterface {
  @override
  StreamController<R> combine<T, R>(
    Iterable<Stream<T>> streams,
    R Function(List<T?> values) combiner,
  ) {
    int completed = 0;

    late List<StreamSubscription<T>> subscriptions;
    // set the initial values to null
    List<T?> returnedValues = List<T?>.filled(streams.length, null);

    final controller = StreamController<R>(sync: true);

    // this is run when the controller is listened to
    controller.onListen = () {
      void onDone() {
        if (++completed == streams.length) {
          controller.close();
        }
      }

      // here we listen to each stream individually
      subscriptions = streams.mapIndexed((index, stream) {
        return stream.listen((T event) {
          late R combined;

          returnedValues[index] = event;

          try {
            // we try to combine the values of all streams
            combined = combiner(List<T?>.unmodifiable(returnedValues));
          } catch (e, s) {
            // if an error is thrown, we add it to the controller and return
            controller.addError(e, s);
            return;
          }

          // we add the combined value to the controller
          controller.add(combined);
        }, onError: controller.addError, onDone: onDone);
      }).toList(growable: false);

      // if there are no streams, we close the controller right away
      if (subscriptions.isEmpty) {
        controller.close();
      }
    };

    controller.onPause = () => subscriptions.map((e) => e.pause());
    controller.onResume = () => subscriptions.map((e) => e.resume());
    controller.onCancel = () {
      returnedValues = List<T?>.filled(streams.length, null);
      return subscriptions.map((e) => e.cancel());
    } as FutureOr<void> Function()?;

    return controller;
  }
}
