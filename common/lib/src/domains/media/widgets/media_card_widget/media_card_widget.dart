import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mime/mime.dart';

// Interface:-------------------------------------------------------------------
abstract class MediaCardWidgetInterface implements Widget {
  MediaCardProps get props;
}

// Props:-----------------------------------------------------------------------
class MediaCardProps {
  const MediaCardProps({
    required this.medium,
  });

  final FileData medium;
}

// Implementation:--------------------------------------------------------------
class MediaCard extends StatefulWidget implements MediaCardWidgetInterface {
  const MediaCard({
    super.key,
    required this.props,
  });

  @override
  final MediaCardProps props;

  @override
  State<MediaCard> createState() => _MediaCardState();
}

class _MediaCardState extends State<MediaCard> {
  // Services:------------------------------------------------------------------
  final FileDataServiceInterface _fileDataService =
      getIt<FileDataServiceInterface>();
  // Utils:---------------------------------------------------------------------
  late final LoaderUtilsInterface _loaderUtils = getIt<LoaderUtilsInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => GestureDetector(
        onTap: () async {
          _loaderUtils.startLoading(context);
          await _fileDataService.openFromFileSystemByUniqueName(
              widget.props.medium.uniqueName,
              download: true);
          if (!context.mounted) return;
          _loaderUtils.stopLoading(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: _mediaInfo(widget.props.medium),
        ),
      ),
    );
  }

  Widget _mediaInfo(FileData fileData) {
    if (fileData.mimeType != null && fileData.mimeType!.startsWith('video/')) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            CupertinoIcons.video_camera,
            color: MapleCommonColors.greyMidLight,
            size: 50,
          ),
          Text(widget.props.medium.displayName),
        ],
      );
    } else if (fileData.mimeType != null &&
        fileData.mimeType == 'application/pdf') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            CupertinoIcons.doc_text,
            color: MapleCommonColors.greyMidLight,
            size: 38,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(widget.props.medium.displayName),
        ],
      );
    } else if (fileData.mimeType != null &&
        fileData.mimeType!.startsWith('image/')) {
      return _buildPreviewAndText();
    } else {
      return _buildDocIconAndText();
    }
  }

  Widget _buildPreviewAndText() {
    if (widget.props.medium.previewFileData?.downloadUrl != null &&
        widget.props.medium.previewFileData?.downloadUrl?.trim() != '') {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.props.medium.previewFileData?.downloadUrl ?? '',
                  fit: BoxFit.fill,
                  height: double.infinity,
                )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(0.3),
              ),
              child: Center(
                child: Text(
                  widget.props.medium.displayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return _buildDocIconAndText();
    }
  }

  Widget _buildDocIconAndText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          CupertinoIcons.doc,
          color: MapleCommonColors.greyMidLight,
          size: 38,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(widget.props.medium.displayName),
      ],
    );
  }

  String? mimeType(String path) {
    return lookupMimeType(path);
  }
}
