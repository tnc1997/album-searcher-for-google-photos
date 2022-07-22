import 'package:flutter/material.dart';
import 'package:googleapis/photoslibrary/v1.dart';

import '../comparators/media_item_comparator.dart';
import '../enums/layout_mode.dart';
import '../services/album_service.dart';
import '../services/media_item_service.dart';
import '../states/layout_state.dart';
import '../widgets/album_sliver_app_bar.dart';
import '../widgets/media_items_sliver_grid.dart';
import '../widgets/media_items_sliver_list.dart';

class AlbumPage extends StatefulWidget {
  final String id;

  const AlbumPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  late Future<Album> _albumFuture;
  late Future<List<MediaItem>> _mediaItemsFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Album>(
          future: _albumFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final albumSliverAppBar = AlbumSliverAppBar(
                album: snapshot.data!,
              );

              return FutureBuilder<List<MediaItem>>(
                future: _mediaItemsFuture,
                builder: (context, snapshot) {
                  Widget mediaItemsSliver;
                  if (snapshot.hasData) {
                    switch (LayoutState.of(context).layoutMode) {
                      case LayoutMode.grid:
                        mediaItemsSliver = SliverPadding(
                          padding: const EdgeInsets.all(8),
                          sliver: MediaItemsSliverGrid(
                            mediaItems: snapshot.data!.toList()
                              ..sort(mediaItemComparator),
                          ),
                        );
                        break;
                      case LayoutMode.list:
                        mediaItemsSliver = MediaItemsSliverList(
                          mediaItems: snapshot.data!.toList()
                            ..sort(mediaItemComparator),
                        );
                        break;
                    }
                  } else {
                    mediaItemsSliver = SliverToBoxAdapter(
                      child: LinearProgressIndicator(),
                    );
                  }

                  return CustomScrollView(
                    slivers: [
                      albumSliverAppBar,
                      mediaItemsSliver,
                    ],
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _albumFuture = AlbumServiceScope.of(context).get(widget.id);
    _mediaItemsFuture = MediaItemServiceScope.of(context).search(widget.id);
  }
}
