import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mime/mime.dart';

// Interface:-------------------------------------------------------------------
abstract class CustomerFileCardWidgetInterface implements Widget {
  CustomerFileCardProps get props;
}

// Props:-----------------------------------------------------------------------
class CustomerFileCardProps {
  final FileData medium;

  CustomerFileCardProps({
    required this.medium,
  });
}

// Implementation:--------------------------------------------------------------
class CustomerFileCard extends StatefulWidget
    implements CustomerFileCardWidgetInterface {
  const CustomerFileCard({
    super.key,
    required this.props,
  });

  @override
  final CustomerFileCardProps props;

  @override
  State<CustomerFileCard> createState() => _CustomerFileCardState();
}

class _CustomerFileCardState extends State<CustomerFileCard> {
  // Dependencies:--------------------------------------------------------------
  final DateTimeUtilsInterface _dateTimeUtils = getIt<DateTimeUtilsInterface>();
  final FileUtilsInterface _fileUtils = getIt<FileUtilsInterface>();
  final FileDataServiceInterface _fileDataService =
      getIt<FileDataServiceInterface>();
  final LoaderUtilsInterface _loaderUtils = getIt<LoaderUtilsInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _loaderUtils.startLoading(context);
        await _fileDataService.openFromFileSystemByUniqueName(
          widget.props.medium.uniqueName,
          download: true,
          withRemove: true,
        );
        if (!context.mounted) return;
        _loaderUtils.stopLoading(context);
      },
      child: Column(
        children: [
          Container(
            width: 150,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: CupertinoColors.inactiveGray,
                width: 1,
              ),
            ),
            child: _mediaInfo(widget.props.medium),
          ),
          const SizedBox(height: 10),
          Text(
            widget.props.medium.displayName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: CupertinoColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            _dateTimeUtils.formatWithCurrentDateDetection(
              widget.props.medium.createdAt,
            ),
            style: const TextStyle(
              fontSize: 10,
              color: CupertinoColors.inactiveGray,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            _fileUtils.formatSize(widget.props.medium.size),
            style: const TextStyle(
              fontSize: 12,
              color: CupertinoColors.inactiveGray,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _mediaInfo(FileData fileData) {
    if (fileData.mimeType != null && fileData.mimeType!.startsWith('video/')) {
      return const Icon(
        CupertinoIcons.video_camera,
        color: MapleCommonColors.greyMidLight,
        size: 50,
      );
    } else if (fileData.mimeType != null &&
        fileData.mimeType == 'application/pdf') {
      return const Icon(
        CupertinoIcons.doc_text,
        color: MapleCommonColors.greyMidLight,
        size: 38,
      );
    } else if (fileData.mimeType != null &&
        fileData.mimeType!.startsWith('image/')) {
      return _buildPreview();
    } else {
      return _buildIcon();
    }
  }

  Widget _buildPreview() {
    if (widget.props.medium.previewFileData?.downloadUrl != null &&
        widget.props.medium.previewFileData?.downloadUrl?.trim() != '') {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.props.medium.previewFileData?.downloadUrl ?? '',
                  fit: BoxFit.fill,
                  height: double.infinity,
                )),
          ],
        ),
      );
    } else {
      return _buildIcon();
    }
  }

  Widget _buildIcon() {
    return const Icon(
      CupertinoIcons.doc,
      color: MapleCommonColors.greyMidLight,
      size: 38,
    );
  }

  String? mimeType(String path) {
    return lookupMimeType(path);
  }
}
