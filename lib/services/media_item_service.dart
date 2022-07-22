import 'package:flutter/widgets.dart';
import 'package:googleapis/photoslibrary/v1.dart';

import '../states/authentication_state.dart';

class MediaItemServiceScope extends InheritedWidget {
  final MediaItemService service;

  const MediaItemServiceScope({
    Key? key,
    required this.service,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  static MediaItemService of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MediaItemServiceScope>()!
        .service;
  }

  @override
  bool updateShouldNotify(covariant MediaItemServiceScope oldWidget) {
    return oldWidget.service != service;
  }
}

class MediaItemService {
  final AuthenticationStateData _authenticationStateData;

  MediaItemService({
    required AuthenticationStateData authenticationStateData,
  }) : _authenticationStateData = authenticationStateData;

  Future<MediaItem> get(String mediaItemId) async {
    return await PhotosLibraryApi(_authenticationStateData.client!)
        .mediaItems
        .get(mediaItemId);
  }

  Future<List<MediaItem>> search(String albumId) async {
    final mediaItems = <MediaItem>[];

    final api = PhotosLibraryApi(_authenticationStateData.client!);

    String? pageToken;

    do {
      final response = await api.mediaItems.search(
        SearchMediaItemsRequest(
          albumId: albumId,
          pageSize: 100,
          pageToken: pageToken,
        ),
      );

      mediaItems.addAll(response.mediaItems ?? []);

      pageToken = response.nextPageToken;
    } while (pageToken != null);

    return mediaItems;
  }
}
