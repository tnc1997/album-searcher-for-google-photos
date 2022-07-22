import 'package:flutter/material.dart';
import 'package:googleapis/photoslibrary/v1.dart';

import '../widgets/album_card.dart';

class AlbumsSliverGrid extends StatelessWidget {
  final List<Album> albums;

  const AlbumsSliverGrid({
    Key? key,
    required this.albums,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.all(8),
          child: AlbumCard(
            key: ValueKey(albums[index]),
            album: albums[index],
          ),
        ),
        childCount: albums.length,
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500,
      ),
    );
  }
}
