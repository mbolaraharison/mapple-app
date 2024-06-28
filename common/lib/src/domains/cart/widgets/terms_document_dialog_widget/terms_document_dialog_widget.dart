import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maple_common/maple_common.dart';
import 'package:pull_down_button/pull_down_button.dart';

// Interface:-------------------------------------------------------------------
abstract class TermsDocumentDialogWidgetInterface implements Widget {
  TermsDocumentDialogProps get props;
}

// Props:-----------------------------------------------------------------------
class TermsDocumentDialogProps {
  final File? image;
  final void Function(File image) onSubmitted;

  TermsDocumentDialogProps({
    required this.image,
    required this.onSubmitted,
  });
}

// Implementation:--------------------------------------------------------------
class TermsDocumentDialog extends StatelessWidget
    implements TermsDocumentDialogWidgetInterface {
  const TermsDocumentDialog({super.key, required this.props});

  @override
  final TermsDocumentDialogProps props;

  @override
  Widget build(BuildContext context) {
    TermsDocumentDialogStoreInterface store =
        getIt<TermsDocumentDialogStoreInterface>(
      param1: TermsDocumentDialogStoreParams(image: props.image),
    );

    return getIt<DialogWrapperWidgetInterface>(
      param1: DialogWrapperProps(
        width: 600,
        height: 410,
        header: _buildHeader(context, store),
        child: _buildContent(context, store),
      ),
    );
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _buildHeader(
    BuildContext context,
    TermsDocumentDialogStoreInterface store,
  ) {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          child: Text(
            'cancel'.tr(),
            style: DialogHeaderWidgetInterface.sideDefaultTextStyle,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        middleContent: Text(
          'cart.terms_document'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
        rightContent: Observer(
          builder: (_) {
            return CupertinoButton(
              onPressed: store.isValid ? () => _onSubmit(context, store) : null,
              child: Text(
                'ok'.tr().toUpperCase(),
                style: store.isValid
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

  Widget _buildContent(
    BuildContext context,
    TermsDocumentDialogStoreInterface store,
  ) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Text(
            'cart.terms_document_instruction'.tr(),
            textAlign: TextAlign.center,
          ),
          Observer(builder: (_) {
            return SizedBox(height: store.image == null ? 70 : 20);
          }),
          PullDownButton(
            itemBuilder: (context) => [
              PullDownMenuItem(
                title: 'take_a_picture'.tr(),
                icon: CupertinoIcons.camera,
                onTap: () => _onCameraPressed(store),
              ),
              PullDownMenuItem(
                title: 'choose_from_library'.tr(),
                icon: CupertinoIcons.photo,
                onTap: () => _onGalleryPressed(store),
              ),
            ],
            buttonBuilder: (context, showMenu) {
              return CupertinoButton(
                padding: const EdgeInsets.only(bottom: 10),
                onPressed: showMenu,
                child: Observer(builder: (_) {
                  if (store.image != null) {
                    return Image.file(
                      store.image!,
                      height: 200,
                      fit: BoxFit.cover,
                    );
                  }

                  return SvgPicture.asset(MapleCommonAssets.fileAdd, width: 80);
                }),
              );
            },
          ),
        ],
      ),
    );
  }

  // General methods:-----------------------------------------------------------
  void _onGalleryPressed(TermsDocumentDialogStoreInterface store) async {
    final tempImage = await _getTempImage(ImageSource.gallery);
    if (tempImage == null) return;
    store.setImage(tempImage);
  }

  void _onCameraPressed(TermsDocumentDialogStoreInterface store) async {
    final tempImage = await _getTempImage(ImageSource.camera);
    if (tempImage == null) return;
    store.setImage(tempImage);
  }

  Future<File?> _getTempImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image == null) return null;

    return File(image.path);
  }

  void _onSubmit(
    BuildContext context,
    TermsDocumentDialogStoreInterface store,
  ) {
    props.onSubmitted(store.image!);
    Navigator.pop(context);
  }
}
