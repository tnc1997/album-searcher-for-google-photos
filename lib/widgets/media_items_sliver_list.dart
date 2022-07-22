import 'package:flutter/material.dart';
import 'package:googleapis/photoslibrary/v1.dart';

import '../widgets/media_item_list_tile.dart';

class MediaItemsSliverList extends StatelessWidget {
  final List<MediaItem> mediaItems;

  const MediaItemsSliverList({
    Key? key,
    required this.mediaItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => MediaItemListTile(
          key: ValueKey(mediaItems[index]),
          mediaItem: mediaItems[index],
        ),
        childCount: mediaItems.length,
      ),
    );
  }
}
