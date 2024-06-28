// Interface:-------------------------------------------------------------------
import 'dart:async';
import 'package:maple_common/maple_common.dart';

abstract class StreamTransformerUtilsInterface {
  StreamTransformer<T?, T?>
      getSingleResultDriftStreamOptimizer<T extends AbstractBaseModel>();

  StreamTransformer<List<T>, List<T>>
      getListResultDriftStreamOptimizer<T extends AbstractBaseModel>();
}

// Implementation:--------------------------------------------------------------
class StreamTransformerUtils implements StreamTransformerUtilsInterface {
  @override
  StreamTransformer<T?, T?>
      getSingleResultDriftStreamOptimizer<T extends AbstractBaseModel>() {
    T? lastItem;
    return StreamTransformer.fromHandlers(
      handleData: (data, sink) {
        // Return early if both items are null
        if (lastItem == null && data == null) {
          return;
        }

        // If one of the items is null while the other is set we trigger the stream
        // If both are set we check the entity hashcode, if they are different we trigger the stream
        if ((lastItem == null && data != null) ||
            (lastItem != null && data == null) ||
            !lastItem!.identicalTo(data!)) {
          sink.add(data);
          lastItem = data;
        }
      },
    );
  }

  @override
  StreamTransformer<List<T>, List<T>>
      getListResultDriftStreamOptimizer<T extends AbstractBaseModel>() {
    List<T>? lastList;
    return StreamTransformer.fromHandlers(
      handleData: (data, sink) {
        // We first check the length, if they are different we trigger the stream
        // then we check each item in the last list, if the item is not found in the new list or the entity hashcode is different we trigger the stream
        if (lastList == null ||
            lastList!.length != data.length ||
            lastList!.any((currentItem) {
              T? incomingItem = data
                  .firstWhereOrNull((newItem) => newItem.id == currentItem.id);
              if (incomingItem == null ||
                  !incomingItem.identicalTo(currentItem)) {
                return true;
              } else {
                return false;
              }
            })) {
          sink.add(data);
          lastList = data;
        }
      },
    );
  }
}
