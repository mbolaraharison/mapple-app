import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pull_down_button/pull_down_button.dart';

// Interface:-------------------------------------------------------------------
abstract class CustomerViewScreenInterface implements Widget {
  CustomerViewScreenArguments get arguments;
}

// Implementation:--------------------------------------------------------------
class CustomerViewScreen extends StatefulWidget
    implements CustomerViewScreenInterface {
  // Constructor:---------------------------------------------------------------
  const CustomerViewScreen({
    super.key,
    required this.arguments,
  });

  @override
  final CustomerViewScreenArguments arguments;

  @override
  State<CustomerViewScreen> createState() => _CustomerViewScreenState();
}

class _CustomerViewScreenState extends State<CustomerViewScreen> {
  int? selectedTab = 0;
  // Services:------------------------------------------------------------------
  final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();
  final NoteServiceInterface _noteService = getIt<NoteServiceInterface>();
  final FileUtilsInterface _fileUtils = getIt<FileUtilsInterface>();
  final DateTimeUtilsInterface _dateTimeUtils = getIt<DateTimeUtilsInterface>();
  final FileDataServiceInterface _fileDataService =
      getIt<FileDataServiceInterface>();
  late final LoaderUtilsInterface _loaderUtils = getIt<LoaderUtilsInterface>();

  // ScrollControllers:----------------------------------------------------------
  final ScrollController _quoteFilesScrollController = ScrollController();

  // Stores:--------------------------------------------------------------------
  late final CustomerViewStoreInterface _customerViewStore =
      getIt<CustomerViewStoreInterface>(
    param1: CustomerViewStoreParams(
      customer: widget.arguments.customer,
    ),
  );

  // Themes:--------------------------------------------------------------------
  late final AppThemeDataInterface _appThemeData =
      getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      Customer customer = _customerViewStore.customer;
      return getIt<MainLayoutWidgetInterface>(
        param1: MainLayoutProps(
          backgroundColor: CupertinoColors.extraLightBackgroundGray,
          headerTitle: 'customer_view_title'.tr(),
          headerWithBackButton: true,
          headerRightChild: _headerRightChild(customer),
          child: Expanded(child: _buildContent(customer)),
          onBackButtonTap: widget.arguments.onBackButtonTap,
        ),
      );
    });
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _headerRightChild(Customer customer) {
    switch (selectedTab) {
      case 0:
        return CupertinoButton(
          onPressed: () => _onAddContactPressed(customer),
          child: SvgPicture.asset(
            MapleCommonAssets.userAdd,
            colorFilter: ColorFilter.mode(
              _appThemeData.topBarButtonColor,
              BlendMode.srcIn,
            ),
          ),
        );
      case 1:
        return CupertinoButton(
          onPressed: () => _showProjectAddDialog(),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SvgPicture.asset(
            MapleCommonAssets.projectAdd,
            colorFilter: ColorFilter.mode(
              _appThemeData.topBarButtonColor,
              BlendMode.srcIn,
            ),
          ),
        );
      case 2:
        return CupertinoButton(
          onPressed: () => _showManageNoteDialog(),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SvgPicture.asset(
            MapleCommonAssets.noteAdd,
            colorFilter: ColorFilter.mode(
              _appThemeData.topBarButtonColor,
              BlendMode.srcIn,
            ),
          ),
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildContent(Customer customer) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 19),
        _buildTabs(),
        Expanded(child: _buildTabContent(customer)),
      ],
    );
  }

  Widget _buildTabs() {
    return Row(
      children: [
        Expanded(
          child: CupertinoSlidingSegmentedControl(
            groupValue: selectedTab,
            onValueChanged: (value) {
              setState(() {
                selectedTab = value as int;
              });
            },
            children: <int, Widget>{
              0: const Text('customer_label').tr(),
              1: const Text('customer_view_section_projects').tr(),
              2: const Text('customer_view_section_notes').tr(),
              3: const Text('customer_view_section_documents').tr(),
              4: const Text('customer_view_maps_street_view').tr(),
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTabContent(Customer customer) {
    switch (selectedTab) {
      case 0:
        return _buildCustomerTab(customer);
      case 1:
        return _buildProjectsTab();
      case 2:
        return _buildNotesTab();
      case 3:
        return _buildDocumentsTab();
      case 4:
        return _buildGoogleStreetViewTab(customer);
      default:
        return _buildCustomerTab(customer);
    }
  }

  Widget _buildCustomerTab(Customer customer) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: CupertinoScrollbar(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            const SizedBox(height: 47),
            _buildCustomerTabHeader(customer),
            const SizedBox(height: 38),
            _buildCustomerTabInfos(customer),
            const SizedBox(height: 30),
            _buildCustomerTabContacts(customer),
          ],
        ),
      )),
    );
  }

  Widget _buildProjectsTab() {
    return Observer(
      builder: (context) {
        if (_customerViewStore.isLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        return ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          itemCount: _customerViewStore.orders.length,
          itemBuilder: (context, index) {
            return _buildProjectsTabItem(_customerViewStore.orders[index]);
          },
        );
      },
    );
  }

  Widget _buildNotesTab() {
    return Observer(
      builder: (context) {
        if (_customerViewStore.isLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        return ListView.builder(
          padding: const EdgeInsets.only(top: 20),
          itemCount: _customerViewStore.notes.length,
          itemBuilder: (context, index) {
            return _buildRow(_customerViewStore.notes[index]);
          },
        );
      },
    );
  }

  Widget _buildRow(Note note) {
    return Container(
      margin: const EdgeInsets.only(left: 130, right: 130, bottom: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: StreamBuilder<Representative?>(
        stream: _representativeService.getCurrentAsStream(),
        builder: (context, AsyncSnapshot<Representative?> snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Container();
          }
          Representative representative = snapshot.data!;
          return Stack(
            children: [
              representative.id == note.representativeId
                  ? Align(
                      alignment: Alignment.topRight,
                      child: PullDownButton(
                        itemBuilder: (context) => [
                          PullDownMenuItem(
                            title: 'customer.notes.edit.submit-button'.tr(),
                            icon: CupertinoIcons.pencil_circle,
                            onTap: () => _showManageNoteDialog(note: note),
                          ),
                          PullDownMenuItem(
                            title: 'customer.notes.delete.submit-button'.tr(),
                            icon: CupertinoIcons.trash,
                            isDestructive: true,
                            onTap: () => _showDeleteNoteDialog(note),
                          ),
                        ],
                        buttonBuilder: (context, showMenu) => CupertinoButton(
                          onPressed: showMenu,
                          padding: EdgeInsets.zero,
                          child: Icon(
                            CupertinoIcons.ellipsis_circle,
                            color: _appThemeData.buttonColor,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 10, right: 10, bottom: 40),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        note.title != null && note.title!.trim() != ''
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Text(
                                      note.title!,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: CupertinoColors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        Text(
                          note.note,
                          style: const TextStyle(
                            height: 1.3,
                            fontSize: 16,
                            color: CupertinoColors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                  child: Text(
                    note.representative != null
                        ? "${note.representative!.shortFullName}, ${note.humanReadableCreatedAt}"
                        : '',
                    style: const TextStyle(
                      fontSize: 14,
                      color: MapleCommonColors.greyLighter,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDocumentsTab() {
    return Observer(
      builder: (_) => Column(children: [
        const SizedBox(height: 22),
        CupertinoSearchTextField(onChanged: _customerViewStore.setSearch),
        const SizedBox(height: 34),
        Expanded(
          child: Row(
            children: [
              _buildQuoteFilesSection(),
              const VerticalDivider(
                color: CupertinoColors.inactiveGray,
                thickness: 1,
                indent: 10,
                endIndent: 10,
                width: 1,
              ),
              _buildNormalFilesSection(),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildQuoteFilesSection() {
    return Padding(
      padding: const EdgeInsets.only(right: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'customer.documents.quote_history'.tr(),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildQuoteFiles(),
        ],
      ),
    );
  }

  Widget _buildQuoteFiles() {
    return StreamBuilder(
      stream: _customerViewStore.filteredQuoteFileDataStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: CupertinoActivityIndicator());
        }
        List<FileData> quoteFiles = snapshot.data as List<FileData>;
        return SizedBox(
          width: 400,
          height: MediaQuery.of(context).size.height - 290,
          child: Scrollbar(
            controller: _quoteFilesScrollController,
            thumbVisibility: true,
            child: ListView.builder(
              controller: _quoteFilesScrollController,
              shrinkWrap: true,
              itemCount: quoteFiles.length,
              itemBuilder: (context, index) {
                return _buildQuoteFilesItem(quoteFiles[index]);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuoteFilesItem(FileData fileData) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        _loaderUtils.startLoading(context);
        await _fileDataService.openFromFileSystemByUniqueName(
          fileData.uniqueName,
          download: true,
          withRemove: true,
        );
        if (!mounted) return;
        _loaderUtils.stopLoading(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  MapleCommonAssets.documentPdfFile,
                  width: 35,
                ),
                const SizedBox(width: 11),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fileData.displayName,
                      style: const TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _fileUtils.formatSize(fileData.size),
                      style: const TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.inactiveGray,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _dateTimeUtils.format(fileData.createdAt, 'dd MMM. yyyy'),
                      style: const TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _dateTimeUtils.format(fileData.createdAt, 'HH:mm'),
                      style: const TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.inactiveGray,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              color: CupertinoColors.inactiveGray.withOpacity(.36),
              thickness: 1,
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNormalFilesSection() {
    return Observer(
      builder: (context) {
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Text(
                  'customer.documents.label'.tr(),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              _buildNormalFiles(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNormalFiles() {
    return StreamBuilder(
      stream: _customerViewStore.filteredNormalFileDataStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: CupertinoActivityIndicator());
        }
        List<FileData> normalFiles = snapshot.data as List<FileData>;
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          height: MediaQuery.of(context).size.height - 290,
          child: GridView.builder(
            padding: const EdgeInsets.only(top: 10),
            itemCount: normalFiles.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 14,
              mainAxisSpacing: 10,
              mainAxisExtent: 164,
            ),
            itemBuilder: (context, index) {
              return getIt<CustomerFileCardWidgetInterface>(
                param1: CustomerFileCardProps(medium: normalFiles[index]),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildGoogleStreetViewTab(Customer customer) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      clipBehavior: Clip.hardEdge,
      child: getIt<StreetViewWidgetInterface>(
        param1: StreetViewProps(
          address: customer.formattedAddress,
        ),
      ),
    );
  }

  Widget _buildCustomerTabHeader(Customer customer) {
    final String firstLetter =
        customer.initials.isNotEmpty ? customer.initials.substring(0, 1) : '';
    String secondLetter = '';
    if (customer.initials.length >= 2) {
      secondLetter = customer.initials.substring(1, 2);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getIt<AvatarWidgetInterface>(
          param1: AvatarProps(
            firstLetter: firstLetter,
            secondLetter: secondLetter,
          ),
        ),
        const SizedBox(width: 17),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              customer.formattedName,
              style: const TextStyle(fontSize: 28),
            ),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: customer.typeColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  customer.typeKey.tr(),
                  style: TextStyle(
                    color: customer.typeColor,
                    fontSize: 17,
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget _buildCustomerTabInfos(Customer customer) {
    return SizedBox(
      width: 695,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'customer_infos'.tr().toUpperCase(),
                  style: const TextStyle(
                    color: CupertinoColors.inactiveGray,
                    fontSize: 13,
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  minSize: null,
                  onPressed: () => _showCustomerEditDialog(customer),
                  child: const Text(
                    'edit',
                    style: TextStyle(
                      color: CupertinoColors.systemBlue,
                    ),
                  ).tr(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 9),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCustomerTabInfosItem(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                title: 'customer_address'.tr(),
                content: customer.formattedAddress,
                footer: Row(children: [
                  SvgPicture.asset(
                    MapleCommonAssets.location,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'customer_location_distance'.tr(namedArgs: {
                      'distance':
                          _customerViewStore.formattedDistanceToCustomerAddress,
                    }),
                    style: const TextStyle(
                      color: CupertinoColors.inactiveGray,
                      fontSize: 14,
                    ),
                  )
                ]),
              ),
              const Separator(),
              _buildCustomerTabInfosItem(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                title: 'customer_how_did_you_know_us'.tr(),
                content: customer.originWithDetails,
              ),
            ],
          ),
          // Stack(
          //   children: [
          //     Positioned(
          //       top: -4,
          //       right: 0,
          //       child: CupertinoButton(
          //         onPressed: () => _showCustomerEditDialog(customer),
          //         child: SvgPicture.asset(
          //           MapleCommonAssets.edit,
          //           width: 28,
          //           colorFilter: ColorFilter.mode(
          //             _appThemeData.buttonColor,
          //             BlendMode.srcIn,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _buildCustomerTabInfosItem({
    required BorderRadius borderRadius,
    required String title,
    required String content,
    Widget? footer,
  }) {
    return _buildRowButton(
      borderRadius: borderRadius,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: _appThemeData.defaultTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 17,
              color: _appThemeData.defaultTextColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          footer != null
              ? Row(
                  children: [
                    const SizedBox(height: 40),
                    footer,
                  ],
                )
              : Container(),
        ],
      ),
      footer: footer,
    );
  }

  Widget _buildCustomerTabContacts(Customer customer) {
    List<Widget> children = [];
    children.addAll(_customerViewStore.contacts.map(
      (e) => _buildCustomerTabContactsItem(e, customer),
    ));
    return Column(
      children: [
        SizedBox(
          width: 695,
          child: Text(
            'contacts'.tr(),
            textAlign: TextAlign.left,
            style: TextStyle(
              color: _appThemeData.defaultTextColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 17),
        SizedBox(
          width: 695,
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerTabContactsItem(Contact contact, Customer customer) {
    return GestureDetector(
      onTap: () => _onContactTap(contact, customer),
      child: Column(
        children: [
          getIt<AvatarWidgetInterface>(
            param1: AvatarProps(
              firstLetter: contact.initials.substring(0, 1),
              secondLetter: contact.initials.length >= 2
                  ? contact.initials.substring(1, 2)
                  : null,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            contact.fullName,
            style: const TextStyle(fontSize: 17),
          ),
        ],
      ),
    );
  }

  Widget _buildRowButton({
    required Widget child,
    required BorderRadius borderRadius,
    Widget? footer,
  }) {
    return getIt<RowButtonWidgetInterface>(
      param1: RowButtonProps(
        disableRightChild: true,
        height: footer != null ? 112 : 88,
        borderRadius: borderRadius,
        child: child,
      ),
    );
  }

  Widget _buildProjectsTabItem(Order order) {
    return getIt<CustomersProjectCardWidgetInterface>(
      param1: CustomersProjectCardProps(order: order),
    );
  }

  // General methods:-----------------------------------------------------------
  void _showDeleteNoteDialog(Note note) {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('customer.notes.delete.title'.tr()),
        content: Text('customer.notes.delete.dialog-content'
            .tr(namedArgs: {'title': note.title ?? ''})),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              _noteService.delete(note);
              Navigator.pop(context);
              Fluttertoast.showToast(
                  msg: 'customer.notes.delete.confirm-delete'.tr(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
            child: SizedBox(
              width: 177,
              child: Text('customer.notes.delete.submit-button'.tr()),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('cancel'.tr()),
          )
        ],
      ),
    );
  }

  void _showManageNoteDialog({Note? note}) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => getIt<ManageNoteDialogWidgetInterface>(
        param1: ManageNoteDialogProps(
          note: note,
          customerId: widget.arguments.customer.id,
        ),
      ),
    );
  }

  void _showProjectAddDialog() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => getIt<AddEditProjectDialogWidgetInterface>(
        param1: AddEditProjectDialogProps(
          customerId: widget.arguments.customer.id,
          customerViewStore: _customerViewStore,
        ),
      ),
    );
  }

  void _onContactTap(Contact contact, Customer customer) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => getIt<AddEditContactDialogWidgetInterface>(
        param1: AddEditContactDialogProps(
          contact: contact,
          customer: customer,
        ),
      ),
    );
  }

  void _onAddContactPressed(Customer customer) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => getIt<AddEditContactDialogWidgetInterface>(
        param1: AddEditContactDialogProps(
          customer: customer,
        ),
      ),
    );
  }

  void _showCustomerEditDialog(Customer customer) {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (context) => getIt<EditCustomerDialogWidgetInterface>(
        param1: EditCustomerDialogProps(customer: customer),
      ),
    );
  }

  // Dispose methods:----------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
    _customerViewStore.dispose();
  }
}
