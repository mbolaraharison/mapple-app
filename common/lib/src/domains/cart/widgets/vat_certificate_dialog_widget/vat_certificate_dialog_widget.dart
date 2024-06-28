import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maple_common/maple_common.dart';
import 'package:pull_down_button/pull_down_button.dart';

// Interface:-------------------------------------------------------------------
abstract class VatCertificateDialogWidgetInterface implements Widget {
  VatCertificateDialogProps get props;
}

// Props:-----------------------------------------------------------------------
class VatCertificateDialogProps {
  final FileData? fileData;
  final void Function(File image) onSubmitted;

  VatCertificateDialogProps({
    this.fileData,
    required this.onSubmitted,
  });
}

// Implementation:--------------------------------------------------------------
class VatCertificateDialog extends StatelessWidget
    implements VatCertificateDialogWidgetInterface {
  VatCertificateDialog({super.key, required this.props});

  // Props:---------------------------------------------------------------------
  @override
  final VatCertificateDialogProps props;

  // Themes:--------------------------------------------------------------------
  late final AppThemeDataInterface _appThemeData =
      getIt<AppThemeDataInterface>();

  // Stores:--------------------------------------------------------------------
  late final VatCertificateDialogStoreInterface _store =
      getIt<VatCertificateDialogStoreInterface>(
    param1: VatCertificateDialogStoreParams(
      fileData: props.fileData,
    ),
  );

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return getIt<DialogWrapperWidgetInterface>(
      param1: DialogWrapperProps(
        width: 600,
        height: 380,
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
            'cancel'.tr(),
            style: DialogHeaderWidgetInterface.sideDefaultTextStyle,
          ),
          onPressed: () {
            _store.dispose();
            Navigator.pop(context);
          },
        ),
        middleContent: Text(
          'cart.vat_certificate.title'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
        rightContent: Observer(
          builder: (_) {
            return CupertinoButton(
              onPressed: _store.hasBeenSubmitted == false && _store.isValid
                  ? () => _onSubmit(context)
                  : null,
              child: Text(
                'ok'.tr().toUpperCase(),
                style: _store.isValid
                    ? DialogHeaderWidgetInterface.sideDefaultTextStyle
                        .copyWith(fontWeight: FontWeight.w600)
                    : const TextStyle(color: CupertinoColors.inactiveGray),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Text(
            'cart.vat_certificate.description'.tr(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Observer(
                builder: (_) {
                  if (_store.image == null && _store.fileData == null) {
                    return const SizedBox();
                  }

                  return Expanded(
                    flex: 2,
                    child: Observer(
                      builder: (_) {
                        if (_store.isLoading) {
                          return const SizedBox(
                            width: 200,
                            height: 200,
                            child: CupertinoActivityIndicator(),
                          );
                        }

                        if (_store.image == null) {
                          return Container();
                        }

                        FileImage fileImage = FileImage(_store.image!);
                        fileImage.evict();

                        return Image.file(
                          _store.image!,
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        );
                      },
                    ),
                  );
                },
              ),
              Expanded(
                child: SizedBox(
                  height: 200,
                  child: PullDownButton(
                    itemBuilder: (context) => [
                      PullDownMenuItem(
                        title: 'take_a_picture'.tr(),
                        icon: CupertinoIcons.camera,
                        onTap: _onCameraPressed,
                      ),
                      PullDownMenuItem(
                        title: 'choose_from_library'.tr(),
                        icon: CupertinoIcons.photo,
                        onTap: _onGalleryPressed,
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
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  // General methods:-----------------------------------------------------------
  void _onGalleryPressed() async {
    final tempImage = await _getTempImage(ImageSource.gallery);
    if (tempImage == null) return;
    _store.setImage(tempImage);
  }

  void _onCameraPressed() async {
    final tempImage = await _getTempImage(ImageSource.camera);
    if (tempImage == null) return;
    _store.setImage(tempImage);
  }

  Future<File?> _getTempImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: source);
      if (image == null) return null;

      return File(image.path);
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'image_picker.errors.cannot_load_image'.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: CupertinoColors.destructiveRed,
        textColor: CupertinoColors.white,
        fontSize: 16.0,
      );
      return null;
    }
  }

  void _onSubmit(BuildContext context) {
    _store.setHasBeenSubmitted(true);
    Navigator.pop(context);
    props.onSubmitted(_store.image!);
  }
}
