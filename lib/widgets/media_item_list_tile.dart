import 'package:flutter/material.dart';
import 'package:googleapis/photoslibrary/v1.dart';

class MediaItemListTile extends StatelessWidget {
  final MediaItem mediaItem;

  const MediaItemListTile({
    Key? key,
    required this.mediaItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        mediaItem.filename ?? mediaItem.id!,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
