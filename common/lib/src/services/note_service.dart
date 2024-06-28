import 'dart:async';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class NoteServiceInterface {
  Future<void> create(Note item, {bool applyToFirestore = true});

  Future<void> update(Note item, {bool applyToFirestore = true});

  Future<void> delete(Note item, {bool applyToFirestore = true});

  Future<List<Note>> getByCustomerId(String customerId,
      {bool eager = false, List<Type> flow = const []});

  Stream<List<Note>> getByCustomerIdAsStream(String customerId,
      {bool eager = false, List<Type> flow = const []});

  Future<void> startSyncByAgencyId({String? agencyId, int batchSize = 100});

  Future<void> stopSync();

  Future<void> deleteAll({bool applyToFirestore = true});
}

// Implementation:--------------------------------------------------------------
class NoteService
    extends AbstractModelService<Note, $NotesTable, AgencyDatabase>
    implements NoteServiceInterface {
  NoteService() : super(getIt<NoteDriftDao>(), getIt<NoteFirestoreDao>());

  // Methods:-------------------------------------------------------------------
  @override
  Stream<List<Note>> getByCustomerIdAsStream(String customerId,
      {bool eager = false, List<Type> flow = const []}) {
    Stream<List<Note>> notesStream = (localDao as NoteDriftDao)
        .findByCustomerIdAsStream(customerId)
        .transform(
            streamTransformerUtils.getListResultDriftStreamOptimizer<Note>());

    if (eager) {
      notesStream = notesStream.asyncMap((notes) async {
        for (int i = 0; i < notes.length; i++) {
          await notes[i].loadData(eager: eager, flow: flow);
        }
        return notes;
      });
    }

    return notesStream;
  }

  @override
  Future<List<Note>> getByCustomerId(String customerId,
      {bool eager = false, List<Type> flow = const []}) async {
    List<Note> notes =
        await (localDao as NoteDriftDao).findByCustomerId(customerId);

    if (eager) {
      for (int i = 0; i < notes.length; i++) {
        await notes[i].loadData(eager: eager, flow: flow);
      }
    }

    return notes;
  }
}
