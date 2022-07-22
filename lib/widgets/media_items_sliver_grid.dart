import 'package:flutter/material.dart';
import 'package:googleapis/photoslibrary/v1.dart';

import '../widgets/media_item_card.dart';

class MediaItemsSliverGrid extends StatelessWidget {
  final List<MediaItem> mediaItems;

  const MediaItemsSliverGrid({
    Key? key,
    required this.mediaItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.all(8),
          child: MediaItemCard(
            key: ValueKey(mediaItems[index]),
            mediaItem: mediaItems[index],
          ),
        ),
        childCount: mediaItems.length,
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500,
      ),
    );
  }
}
