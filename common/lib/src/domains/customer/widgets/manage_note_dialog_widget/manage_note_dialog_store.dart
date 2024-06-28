import 'dart:async';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'manage_note_dialog_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class ManageNoteDialogStoreInterface {
  ManageNoteDialogStoreInterface._(this.title, this.note);

  ManageNoteDialogStoreParams get params;

  String? title;

  String note;

  bool get isValid;

  void setTitle(String value);

  Future<void> create();

  void update();

  void createOrUpdate();
}

// Params:----------------------------------------------------------------------
class ManageNoteDialogStoreParams {
  const ManageNoteDialogStoreParams({
    this.note,
    required this.customerId,
  });

  final Note? note;
  final String customerId;
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class ManageNoteDialogStore = _ManageNoteDialogStore
    with _$ManageNoteDialogStore;

abstract class _ManageNoteDialogStore
    with Store
    implements ManageNoteDialogStoreInterface {
  // Constructor:---------------------------------------------------------------
  _ManageNoteDialogStore({required this.params}) {
    noteObject = params.note;
    init();
  }

  // Params:--------------------------------------------------------------------
  @override
  final ManageNoteDialogStoreParams params;

  // Stores:--------------------------------------------------------------------
  late final NoteServiceInterface _noteService = getIt<NoteServiceInterface>();

  // Services:---------------------------------------------------------------
  final UuidUtilsInterface uuidUtils = getIt<UuidUtilsInterface>();

  // Store variables:-----------------------------------------------------------
  @observable
  Note? noteObject;

  @override
  @observable
  String? title;

  @override
  @observable
  String note = '';

  @observable
  Representative? _currentRepresentative;

  @computed
  bool get isEditing => noteObject != null;

  @override
  @computed
  bool get isValid {
    if (!isEditing) {
      return note.isNotEmpty;
    } else {
      return title != noteObject!.title || note != noteObject!.note;
    }
  }

  // Actions:-------------------------------------------------------------------
  @override
  @action
  void setTitle(String value) {
    title = value;
  }

  @override
  @action
  Future<void> create() async {
    Representative? currentRepresentative =
        await getIt<RepresentativeServiceInterface>().getCurrent();
    if (noteObject == null && currentRepresentative != null) {
      Note newNote = Note(
          id: uuidUtils.generate(),
          representativeId: currentRepresentative.id,
          customerId: params.customerId,
          agencyId: currentRepresentative.agencyId,
          title: title,
          note: note);
      _noteService.create(newNote);
    }
  }

  @override
  @action
  void update() {
    if (noteObject != null) {
      Note updatedNote = noteObject!;
      updatedNote.title = title;
      updatedNote.note = note;
      _noteService.update(updatedNote);
    }
  }

  @override
  @action
  void createOrUpdate() {
    if (noteObject == null) {
      create();
    } else {
      update();
    }
  }

  @action
  void setNote(String value) {
    note = value;
  }

  @action
  void init() {
    if (noteObject != null) {
      title = noteObject!.title;
      note = noteObject!.note;
    }
  }
}
