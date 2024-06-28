import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:pull_down_button/pull_down_button.dart';

// Interface:-------------------------------------------------------------------
abstract class TermsSelectSignatureMethodWidgetInterface implements Widget {
  TermsSelectSignatureMethodArguments get arguments;
}

// Implementation:--------------------------------------------------------------
class TermsSelectSignatureMethod extends StatefulWidget
    implements TermsSelectSignatureMethodWidgetInterface {
  const TermsSelectSignatureMethod({super.key, required this.arguments});

  @override
  final TermsSelectSignatureMethodArguments arguments;

  @override
  State<TermsSelectSignatureMethod> createState() =>
      _TermsSelectSignatureMethodState();
}

class _TermsSelectSignatureMethodState
    extends State<TermsSelectSignatureMethod> {
  // Stores:--------------------------------------------------------------------
  late CustomerOrderStoreInterface _customerOrderStore;

  // Navigators:----------------------------------------------------------------
  late final RootNavigatorInterface _rootNavigator =
      getIt<RootNavigatorInterface>();
  late final CartTermsNavigatorInterface _cartTermsNavigator =
      getIt<CartTermsNavigatorInterface>();

  // Utils:----------------------------------------------------------------------
  late final LoaderUtilsInterface _loaderUtils = getIt<LoaderUtilsInterface>();

  // Themes:--------------------------------------------------------------------
  late final AppThemeDataInterface _appThemeData =
      getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _customerOrderStore = context.read<CustomerOrderStoreInterface>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return getIt<DialogContentWrapperWidgetInterface>(
      param1: DialogContentWrapperProps(
        header: _buildHeader(context),
        child: _buildContent(context),
      ),
    );
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _buildHeader(BuildContext context) {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          child: Text(
            'back'.tr(),
            style: DialogHeaderWidgetInterface.sideDefaultTextStyle,
          ),
          onPressed: () => _cartTermsNavigator.key.currentState!.pop(),
        ),
        middleContent: Text(
          'cart.terms_document'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
        rightContent: Observer(
          builder: (_) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (widget.arguments.store.image != null)
                  Row(
                    children: [
                      CupertinoButton(
                        child: Text(
                          'clear'.tr(),
                          style:
                              DialogHeaderWidgetInterface.sideDefaultTextStyle,
                        ),
                        onPressed: () {
                          widget.arguments.store.setHasSignature(false);
                          widget.arguments.store.setImage(null);
                        },
                      ),
                    ],
                  ),
                CupertinoButton(
                  onPressed: widget.arguments.store.hasBeenSubmitted == false &&
                          widget.arguments.store.image != null
                      ? () => _onSubmit(context, widget.arguments.store)
                      : null,
                  child: Text(
                    'cart.accept'.tr(),
                    style: widget.arguments.store.isValid
                        ? DialogHeaderWidgetInterface.sideDefaultTextStyle
                            .copyWith(fontWeight: FontWeight.w600)
                        : const TextStyle(color: CupertinoColors.inactiveGray),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Observer(
      builder: (_) => Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Text(
              'cart.terms_document_instruction'.tr(),
              textAlign: TextAlign.center,
            ),
            Observer(builder: (_) {
              return SizedBox(
                  height: widget.arguments.store.image == null ? 70 : 20);
            }),
            widget.arguments.store.image == null
                ? IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _signaturePadSign(),
                        const VerticalDivider(
                          thickness: 1,
                          width: 80,
                        ),
                        _signatureTakeOrUploadPicture(),
                      ],
                    ),
                  )
                : _signatureImage(),
          ],
        ),
      ),
    );
  }

  // General methods:-----------------------------------------------------------
  void _onGalleryPressed(TermsDialogStoreInterface store) async {
    final tempImage = await _getTempImage(ImageSource.gallery);
    if (tempImage == null) return;
    store.setImage(tempImage);
  }

  void _onCameraPressed(TermsDialogStoreInterface store) async {
    final tempImage = await _getTempImage(ImageSource.camera);
    if (tempImage == null) return;
    store.setImage(tempImage);
  }

  Widget _signatureImage() {
    return Image.file(
      widget.arguments.store.image!,
      height: 400,
      fit: BoxFit.cover,
    );
  }

  Widget _signaturePadSign() {
    return CupertinoButton(
      padding: const EdgeInsets.only(bottom: 10),
      onPressed: _showPadForSignature,
      child: Icon(CupertinoIcons.signature,
          size: 80, color: getIt<AppThemeDataInterface>().buttonColor),
    );
  }

  Widget _signatureTakeOrUploadPicture() {
    return PullDownButton(
      itemBuilder: (context) => [
        PullDownMenuItem(
          title: 'take_a_picture'.tr(),
          icon: CupertinoIcons.camera,
          onTap: () => _onCameraPressed(widget.arguments.store),
        ),
        PullDownMenuItem(
          title: 'choose_from_library'.tr(),
          icon: CupertinoIcons.photo,
          onTap: () => _onGalleryPressed(widget.arguments.store),
        ),
      ],
      buttonBuilder: (context, showMenu) {
        return CupertinoButton(
          padding: const EdgeInsets.only(bottom: 10),
          onPressed: showMenu,
          child: SvgPicture.asset(
            MapleCommonAssets.fileAdd,
            width: 80,
            colorFilter: ColorFilter.mode(
              _appThemeData.buttonColor,
              BlendMode.srcIn,
            ),
          ),
        );
      },
    );
  }

  Future<File?> _getTempImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image == null) return null;

    return File(image.path);
  }

  Future<void> _onSubmit(
    BuildContext context,
    TermsDialogStoreInterface store,
  ) async {
    _loaderUtils.startLoading(context);
    store.setHasBeenSubmitted(true);
    await _customerOrderStore.signatureStepStore.setTermsDocument(store.image!);
    if (!context.mounted) return;
    await _loaderUtils.stopLoading(context);
    // first pop removes loader
    _rootNavigator.key.currentState?.pop();
  }

  void _showPadForSignature() {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (context) => getIt<TermsDocumentPadSignWidgetInterface>(
          param1: TermsDocumentPadSignProps(
        termsDialogStore: widget.arguments.store,
        customerOrderStore: _customerOrderStore,
      )),
    );
  }
}
