import 'package:flutter/material.dart';
import 'package:googleapis/photoslibrary/v1.dart';

import '../widgets/album_list_tile.dart';

class AlbumsSliverList extends StatelessWidget {
  final List<Album> albums;

  const AlbumsSliverList({
    Key? key,
    required this.albums,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => AlbumListTile(
          key: ValueKey(albums[index]),
          album: albums[index],
        ),
        childCount: albums.length,
      ),
    );
  }
}
