// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ContactFormStore on _ContactFormStore, Store {
  Computed<bool>? _$isCreatingComputed;

  @override
  bool get isCreating =>
      (_$isCreatingComputed ??= Computed<bool>(() => super.isCreating,
              name: '_ContactFormStore.isCreating'))
          .value;
  Computed<bool>? _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??= Computed<bool>(() => super.isValid,
          name: '_ContactFormStore.isValid'))
      .value;
  Computed<bool>? _$isPhoneInvalidComputed;

  @override
  bool get isPhoneInvalid =>
      (_$isPhoneInvalidComputed ??= Computed<bool>(() => super.isPhoneInvalid,
              name: '_ContactFormStore.isPhoneInvalid'))
          .value;
  Computed<bool>? _$isMobilePhoneInvalidComputed;

  @override
  bool get isMobilePhoneInvalid => (_$isMobilePhoneInvalidComputed ??=
          Computed<bool>(() => super.isMobilePhoneInvalid,
              name: '_ContactFormStore.isMobilePhoneInvalid'))
      .value;
  Computed<bool>? _$isEmailInvalidComputed;

  @override
  bool get isEmailInvalid =>
      (_$isEmailInvalidComputed ??= Computed<bool>(() => super.isEmailInvalid,
              name: '_ContactFormStore.isEmailInvalid'))
          .value;

  late final _$idAtom = Atom(name: '_ContactFormStore.id', context: context);

  @override
  String? get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(String? value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  late final _$civilityAtom =
      Atom(name: '_ContactFormStore.civility', context: context);

  @override
  Civility get civility {
    _$civilityAtom.reportRead();
    return super.civility;
  }

  @override
  set civility(Civility value) {
    _$civilityAtom.reportWrite(value, super.civility, () {
      super.civility = value;
    });
  }

  late final _$lastNameAtom =
      Atom(name: '_ContactFormStore.lastName', context: context);

  @override
  String get lastName {
    _$lastNameAtom.reportRead();
    return super.lastName;
  }

  @override
  set lastName(String value) {
    _$lastNameAtom.reportWrite(value, super.lastName, () {
      super.lastName = value;
    });
  }

  late final _$firstNameAtom =
      Atom(name: '_ContactFormStore.firstName', context: context);

  @override
  String get firstName {
    _$firstNameAtom.reportRead();
    return super.firstName;
  }

  @override
  set firstName(String value) {
    _$firstNameAtom.reportWrite(value, super.firstName, () {
      super.firstName = value;
    });
  }

  late final _$phoneAtom =
      Atom(name: '_ContactFormStore.phone', context: context);

  @override
  String get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  late final _$mobilePhoneAtom =
      Atom(name: '_ContactFormStore.mobilePhone', context: context);

  @override
  String get mobilePhone {
    _$mobilePhoneAtom.reportRead();
    return super.mobilePhone;
  }

  @override
  set mobilePhone(String value) {
    _$mobilePhoneAtom.reportWrite(value, super.mobilePhone, () {
      super.mobilePhone = value;
    });
  }

  late final _$emailAtom =
      Atom(name: '_ContactFormStore.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$isDefaultAtom =
      Atom(name: '_ContactFormStore.isDefault', context: context);

  @override
  bool get isDefault {
    _$isDefaultAtom.reportRead();
    return super.isDefault;
  }

  @override
  set isDefault(bool value) {
    _$isDefaultAtom.reportWrite(value, super.isDefault, () {
      super.isDefault = value;
    });
  }

  late final _$deleteContactAsyncAction =
      AsyncAction('_ContactFormStore.deleteContact', context: context);

  @override
  Future<void> deleteContact() {
    return _$deleteContactAsyncAction.run(() => super.deleteContact());
  }

  late final _$updateContactAsyncAction =
      AsyncAction('_ContactFormStore.updateContact', context: context);

  @override
  Future<void> updateContact() {
    return _$updateContactAsyncAction.run(() => super.updateContact());
  }

  late final _$_ContactFormStoreActionController =
      ActionController(name: '_ContactFormStore', context: context);

  @override
  void setCivility(Civility value) {
    final _$actionInfo = _$_ContactFormStoreActionController.startAction(
        name: '_ContactFormStore.setCivility');
    try {
      return super.setCivility(value);
    } finally {
      _$_ContactFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLastName(String value) {
    final _$actionInfo = _$_ContactFormStoreActionController.startAction(
        name: '_ContactFormStore.setLastName');
    try {
      return super.setLastName(value);
    } finally {
      _$_ContactFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFirstName(String value) {
    final _$actionInfo = _$_ContactFormStoreActionController.startAction(
        name: '_ContactFormStore.setFirstName');
    try {
      return super.setFirstName(value);
    } finally {
      _$_ContactFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhone(String value) {
    final _$actionInfo = _$_ContactFormStoreActionController.startAction(
        name: '_ContactFormStore.setPhone');
    try {
      return super.setPhone(value);
    } finally {
      _$_ContactFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMobilePhone(String value) {
    final _$actionInfo = _$_ContactFormStoreActionController.startAction(
        name: '_ContactFormStore.setMobilePhone');
    try {
      return super.setMobilePhone(value);
    } finally {
      _$_ContactFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_ContactFormStoreActionController.startAction(
        name: '_ContactFormStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_ContactFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsDefault(bool value) {
    final _$actionInfo = _$_ContactFormStoreActionController.startAction(
        name: '_ContactFormStore.setIsDefault');
    try {
      return super.setIsDefault(value);
    } finally {
      _$_ContactFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void fromContact(Contact contact) {
    final _$actionInfo = _$_ContactFormStoreActionController.startAction(
        name: '_ContactFormStore.fromContact');
    try {
      return super.fromContact(contact);
    } finally {
      _$_ContactFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_ContactFormStoreActionController.startAction(
        name: '_ContactFormStore.reset');
    try {
      return super.reset();
    } finally {
      _$_ContactFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addContact() {
    final _$actionInfo = _$_ContactFormStoreActionController.startAction(
        name: '_ContactFormStore.addContact');
    try {
      return super.addContact();
    } finally {
      _$_ContactFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void submit() {
    final _$actionInfo = _$_ContactFormStoreActionController.startAction(
        name: '_ContactFormStore.submit');
    try {
      return super.submit();
    } finally {
      _$_ContactFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateForm() {
    final _$actionInfo = _$_ContactFormStoreActionController.startAction(
        name: '_ContactFormStore.validateForm');
    try {
      return super.validateForm();
    } finally {
      _$_ContactFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
id: ${id},
civility: ${civility},
lastName: ${lastName},
firstName: ${firstName},
phone: ${phone},
mobilePhone: ${mobilePhone},
email: ${email},
isDefault: ${isDefault},
isCreating: ${isCreating},
isValid: ${isValid},
isPhoneInvalid: ${isPhoneInvalid},
isMobilePhoneInvalid: ${isMobilePhoneInvalid},
isEmailInvalid: ${isEmailInvalid}
    ''';
  }
}
