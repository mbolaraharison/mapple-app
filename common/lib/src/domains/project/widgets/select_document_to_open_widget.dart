import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';

// Interface:-------------------------------------------------------------------
abstract class SelectDocumentToOpenWidgetInterface implements Widget {
  SelectDocumentToOpenProps get props;
}

// Props:-----------------------------------------------------------------------
class SelectDocumentToOpenProps {
  const SelectDocumentToOpenProps({
    required this.customerOrderStore,
  });

  final CustomerOrderStoreInterface customerOrderStore;
}

// Implementation:--------------------------------------------------------------
class SelectDocumentToOpen extends StatefulWidget
    implements SelectDocumentToOpenWidgetInterface {
  const SelectDocumentToOpen({super.key, required this.props});

  @override
  final SelectDocumentToOpenProps props;

  @override
  State<SelectDocumentToOpen> createState() => _SelectDocumentToOpenState();
}

class _SelectDocumentToOpenState extends State<SelectDocumentToOpen> {
  // Stores:--------------------------------------------------------------------
  final FileDataServiceInterface _fileDataService =
      getIt<FileDataServiceInterface>();

  // Navigators:----------------------------------------------------------------
  late final RootNavigatorInterface _rootNavigator =
      getIt<RootNavigatorInterface>();

  // Utils:---------------------------------------------------------------------
  late final LoaderUtilsInterface _loaderUtils = getIt<LoaderUtilsInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // Lifecycle methods:----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return getIt<DialogWrapperWidgetInterface>(
      param1: DialogWrapperProps(
        width: 540,
        height: 592,
        disableContentWrapper: true,
        child: getIt<DialogContentWrapperWidgetInterface>(
          param1: DialogContentWrapperProps(
            header: _buildHeader(),
            child: Column(
              children: [
                const SizedBox(height: 39),
                _buildSelect(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          onPressed: () => _rootNavigator.key.currentState?.pop(),
          child: Wrap(
            children: [
              Icon(
                CupertinoIcons.chevron_left,
                color: DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
                size: 22,
              ),
              Text(
                'cancel'.tr(),
                style: TextStyle(
                  color: DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
        middleContent: Text(
          'project.view.documents.title'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
      ),
    );
  }

  Widget _buildSelect() {
    List<SelectChoice> choices = [];

    for (var projectDocumentType in ProjectDocumentType.values) {
      choices.add(SelectChoice(
        value: projectDocumentType,
        label: projectDocumentType.label,
      ));
    }

    return getIt<SelectWidgetInterface<ProjectDocumentType>>(
      param1: SelectProps<ProjectDocumentType>(
        onChanged: (value) => _openDocument(value!),
        choices: choices,
      ),
    );
  }

  Future<void> _openDocument(ProjectDocumentType value) async {
    if (value == ProjectDocumentType.ORDER_FORM &&
        widget.props.customerOrderStore.order.orderFormFileDataId != null) {
      _loaderUtils.startLoading(context);
      FileData? orderFormFileData =
          widget.props.customerOrderStore.order.orderFormFileData;
      if (orderFormFileData != null) {
        await _fileDataService.openFromFileSystemByUniqueName(
          orderFormFileData.uniqueName,
          withRemove: true,
        );
      }
      if (!mounted) return;
      _loaderUtils.stopLoading(context);
    } else if (value == ProjectDocumentType.TERMS_APPROVAL &&
        widget.props.customerOrderStore.order.termsDocumentFileDataId != null) {
      _loaderUtils.startLoading(context);
      FileData? termsDocumentFileData =
          widget.props.customerOrderStore.order.termsDocumentFileData;
      if (termsDocumentFileData != null) {
        await _fileDataService
            .openFromFileSystemByUniqueName(termsDocumentFileData.uniqueName);
      }
      if (!mounted) return;
      _loaderUtils.stopLoading(context);
    } else if (value == ProjectDocumentType.VAT_CERTIFICATE &&
        widget.props.customerOrderStore.order.vatCertificateFileDataId !=
            null) {
      _loaderUtils.startLoading(context);
      FileData? vatCertificateFileData =
          widget.props.customerOrderStore.order.vatCertificateFileData;
      if (vatCertificateFileData != null) {
        await _fileDataService
            .openFromFileSystemByUniqueName(vatCertificateFileData.uniqueName);
      }
      if (!mounted) return;
      _loaderUtils.stopLoading(context);
    }
  }
}
