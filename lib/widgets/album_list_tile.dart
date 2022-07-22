import 'package:flutter/material.dart';
import 'package:googleapis/photoslibrary/v1.dart';

import '../states/router_state.dart';

class AlbumListTile extends StatelessWidget {
  final Album album;

  const AlbumListTile({
    Key? key,
    required this.album,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        album.title ?? album.id!,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      onTap: () {
        RouterState.of(context).selectedAlbum = album.id;
      },
    );
  }
}
