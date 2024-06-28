// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_note_dialog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ManageNoteDialogStore on _ManageNoteDialogStore, Store {
  Computed<bool>? _$isEditingComputed;

  @override
  bool get isEditing =>
      (_$isEditingComputed ??= Computed<bool>(() => super.isEditing,
              name: '_ManageNoteDialogStore.isEditing'))
          .value;
  Computed<bool>? _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??= Computed<bool>(() => super.isValid,
          name: '_ManageNoteDialogStore.isValid'))
      .value;

  late final _$noteObjectAtom =
      Atom(name: '_ManageNoteDialogStore.noteObject', context: context);

  @override
  Note? get noteObject {
    _$noteObjectAtom.reportRead();
    return super.noteObject;
  }

  @override
  set noteObject(Note? value) {
    _$noteObjectAtom.reportWrite(value, super.noteObject, () {
      super.noteObject = value;
    });
  }

  late final _$titleAtom =
      Atom(name: '_ManageNoteDialogStore.title', context: context);

  @override
  String? get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String? value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$noteAtom =
      Atom(name: '_ManageNoteDialogStore.note', context: context);

  @override
  String get note {
    _$noteAtom.reportRead();
    return super.note;
  }

  @override
  set note(String value) {
    _$noteAtom.reportWrite(value, super.note, () {
      super.note = value;
    });
  }

  late final _$_currentRepresentativeAtom = Atom(
      name: '_ManageNoteDialogStore._currentRepresentative', context: context);

  @override
  Representative? get _currentRepresentative {
    _$_currentRepresentativeAtom.reportRead();
    return super._currentRepresentative;
  }

  @override
  set _currentRepresentative(Representative? value) {
    _$_currentRepresentativeAtom
        .reportWrite(value, super._currentRepresentative, () {
      super._currentRepresentative = value;
    });
  }

  late final _$createAsyncAction =
      AsyncAction('_ManageNoteDialogStore.create', context: context);

  @override
  Future<void> create() {
    return _$createAsyncAction.run(() => super.create());
  }

  late final _$_ManageNoteDialogStoreActionController =
      ActionController(name: '_ManageNoteDialogStore', context: context);

  @override
  void setTitle(String value) {
    final _$actionInfo = _$_ManageNoteDialogStoreActionController.startAction(
        name: '_ManageNoteDialogStore.setTitle');
    try {
      return super.setTitle(value);
    } finally {
      _$_ManageNoteDialogStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void update() {
    final _$actionInfo = _$_ManageNoteDialogStoreActionController.startAction(
        name: '_ManageNoteDialogStore.update');
    try {
      return super.update();
    } finally {
      _$_ManageNoteDialogStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void createOrUpdate() {
    final _$actionInfo = _$_ManageNoteDialogStoreActionController.startAction(
        name: '_ManageNoteDialogStore.createOrUpdate');
    try {
      return super.createOrUpdate();
    } finally {
      _$_ManageNoteDialogStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNote(String value) {
    final _$actionInfo = _$_ManageNoteDialogStoreActionController.startAction(
        name: '_ManageNoteDialogStore.setNote');
    try {
      return super.setNote(value);
    } finally {
      _$_ManageNoteDialogStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void init() {
    final _$actionInfo = _$_ManageNoteDialogStoreActionController.startAction(
        name: '_ManageNoteDialogStore.init');
    try {
      return super.init();
    } finally {
      _$_ManageNoteDialogStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
noteObject: ${noteObject},
title: ${title},
note: ${note},
isEditing: ${isEditing},
isValid: ${isValid}
    ''';
  }
}
