import 'package:drift/remote.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maple_common/maple_common.dart' hide EmailValidator;
import 'package:mobx/mobx.dart';
import 'package:email_validator/email_validator.dart';

part 'contact_form_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class ContactFormStoreInterface {
  ContactFormStoreInterface._(
    this.civility,
    this.lastName,
    this.firstName,
    this.phone,
    this.mobilePhone,
    this.email,
    this.isDefault,
    this.errorStore,
  );

  // Params
  ContactFormStoreParams get params;

  // Variables
  String? id;
  Civility civility;
  String lastName;
  String firstName;
  String phone;
  String mobilePhone;
  String email;
  bool isDefault;
  FormErrorStoreInterface errorStore;

  // Computed
  bool get isCreating;
  bool get isValid;
  bool get isPhoneInvalid;
  bool get isMobilePhoneInvalid;
  bool get isEmailInvalid;

  // Methods
  void setCivility(Civility value);
  void setLastName(String value);
  void setFirstName(String value);
  void setPhone(String value);
  void setMobilePhone(String value);
  void setEmail(String value);
  void setIsDefault(bool value);
  Contact toContact({required String customerId, required String agencyId});
  void fromContact(Contact contact);
  void reset();
  void addContact();
  Future<void> deleteContact();
  Future<void> updateContact();
  void submit();
  void validateForm();
}

// Params:----------------------------------------------------------------------
class ContactFormStoreParams {
  const ContactFormStoreParams({this.contact, this.customer});

  final Contact? contact;
  final Customer? customer;
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class ContactFormStore = _ContactFormStore with _$ContactFormStore;

abstract class _ContactFormStore
    with Store
    implements ContactFormStoreInterface {
  // Constructor:---------------------------------------------------------------
  _ContactFormStore({ContactFormStoreParams? params})
      : params = params ?? const ContactFormStoreParams() {
    init();
  }
  // Params:--------------------------------------------------------------------
  @override
  ContactFormStoreParams params;

  // Services:------------------------------------------------------------------
  late final UuidUtilsInterface _uuidUtils = getIt<UuidUtilsInterface>();
  late final OrderServiceInterface _orderService =
      getIt<OrderServiceInterface>();
  late final ContactFirestoreDao _contactFirestoreDao =
      getIt<ContactFirestoreDao>();
  late final ContactServiceInterface _contactService =
      getIt<ContactServiceInterface>();
  late final PhoneValidatorInterface _phoneValidator =
      getIt<PhoneValidatorInterface>();

  // Services:------------------------------------------------------------------
  @override
  FormErrorStoreInterface errorStore =
      getIt<FormErrorStoreInterface>(param1: ['phone', 'email']);

  // Store variables:-----------------------------------------------------------
  @override
  @observable
  String? id;

  @override
  @observable
  Civility civility = Civility.mister;

  @override
  @observable
  String lastName = '';

  @override
  @observable
  String firstName = '';

  @override
  @observable
  String phone = '';

  @override
  @observable
  String mobilePhone = '';

  @override
  @observable
  String email = '';

  @override
  @observable
  bool isDefault = false;

  // Computed:------------------------------------------------------------------
  @override
  @computed
  bool get isCreating => id == null;

  @override
  @computed
  bool get isValid =>
      lastName.isNotEmpty &&
      (firstName.isNotEmpty || (civility == Civility.society)) &&
      mobilePhone.isNotEmpty &&
      email.isNotEmpty;

  @override
  @computed
  bool get isPhoneInvalid => errorStore.errors['phone'] != null;

  @override
  @computed
  bool get isMobilePhoneInvalid => errorStore.errors['mobilePhone'] != null;

  @override
  @computed
  bool get isEmailInvalid => errorStore.errors['email'] != null;

  // Actions:-------------------------------------------------------------------
  @override
  @action
  void setCivility(Civility value) {
    civility = value;
  }

  @override
  @action
  void setLastName(String value) {
    lastName = value;
  }

  @override
  @action
  void setFirstName(String value) {
    firstName = value;
  }

  @override
  @action
  void setPhone(String value) {
    phone = value;
  }

  @override
  @action
  void setMobilePhone(String value) {
    mobilePhone = value;
  }

  @override
  @action
  void setEmail(String value) {
    email = value;
  }

  @override
  @action
  void setIsDefault(bool value) {
    isDefault = value;
  }

  @override
  Contact toContact({required String customerId, required String agencyId}) {
    // generate 15-character random string
    String sageId = 'C${DateTime.now().millisecondsSinceEpoch}';
    if (sageId.length > 15) {
      sageId = sageId.substring(0, 15);
    }
    return Contact(
      id: id ?? _uuidUtils.generate(),
      customerId: customerId,
      agencyId: agencyId,
      civility: civility,
      email: email,
      firstName: firstName.toCapitalizedWords(),
      lastName: lastName.toCapitalizedWords(),
      phone: phone,
      mobilePhone: mobilePhone,
      isDefault: isDefault,
      sageId: sageId,
    );
  }

  void init() {
    if (params.contact == null) {
      return;
    }
    civility = params.contact!.civility;
    lastName = params.contact!.lastName;
    firstName = params.contact!.firstName;
    phone = params.contact!.phone;
    mobilePhone = params.contact!.mobilePhone;
    email = params.contact!.email;
    isDefault = params.contact!.isDefault;
  }

  @override
  @action
  void fromContact(Contact contact) {
    id = contact.id;
    civility = contact.civility;
    lastName = contact.lastName;
    firstName = contact.firstName;
    phone = contact.phone;
    mobilePhone = contact.mobilePhone;
    email = contact.email;
    isDefault = contact.isDefault;
  }

  @override
  @action
  void reset() {
    id = null;
    civility = Civility.mister;
    lastName = '';
    firstName = '';
    phone = '';
    mobilePhone = '';
    email = '';
    isDefault = false;
    errorStore.resetErrors();
  }

  @override
  @action
  void addContact() {
    final contactToCreate = toContact(
      customerId: params.customer!.id,
      agencyId: params.customer!.agencyId,
    );
    _contactFirestoreDao.create(contactToCreate);
  }

  @override
  @action
  Future<void> deleteContact() async {
    try {
      await _contactService.delete(params.contact!, applyToFirestore: true);
    } on DriftRemoteException {
      Fluttertoast.showToast(
        msg: 'contact_remove_errors'.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: CupertinoColors.destructiveRed,
        textColor: CupertinoColors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  @action
  Future<void> updateContact() async {
    params.contact!.civility = civility;
    params.contact!.lastName = lastName.toCapitalizedWords();
    params.contact!.firstName = firstName.toCapitalizedWords();
    params.contact!.phone = phone;
    params.contact!.mobilePhone = mobilePhone;
    params.contact!.email = email;
    params.contact!.isDefault = isDefault;
    _contactFirestoreDao.update(params.contact!);
    await _contactFirestoreDao.update(params.contact!);
    // Search all non-sent orders of the customer and set should recreate envelope to true
    List<Order> orders = await _orderService.getByCustomerId(
      params.contact!.customerId,
      eager: true,
    );
    for (Order order in orders) {
      order.setShouldRecreateEnvelope(true);
      await _orderService.update(order);
    }
  }

  @override
  @action
  void submit() {
    if (params.contact == null) {
      addContact();
    } else {
      updateContact();
    }
  }

  // Validators:----------------------------------------------------------------
  @override
  @action
  void validateForm() {
    errorStore.resetErrors();
    if (phone.isNotEmpty && _phoneValidator.validate(phone) == false) {
      errorStore.setError('phone', 'contact_phone_is_invalid'.tr());
    }
    if (mobilePhone.isNotEmpty &&
        _phoneValidator.validate(mobilePhone, mobile: true) == false) {
      errorStore.setError(
          'mobilePhone', 'contact_mobile_phone_is_invalid'.tr());
    }
    if (EmailValidator.validate(email) == false) {
      errorStore.setError('email', 'contact_email_is_invalid'.tr());
    }
  }
}
