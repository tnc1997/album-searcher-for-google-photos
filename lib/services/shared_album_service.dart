import 'package:flutter/widgets.dart';
import 'package:googleapis/photoslibrary/v1.dart';

import '../services/storage_service.dart';
import '../states/authentication_state.dart';
import '../states/shared_album_state.dart';

class SharedAlbumServiceScope extends InheritedWidget {
  final SharedAlbumService service;

  const SharedAlbumServiceScope({
    Key? key,
    required this.service,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  static SharedAlbumService of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SharedAlbumServiceScope>()!
        .service;
  }

  @override
  bool updateShouldNotify(covariant SharedAlbumServiceScope oldWidget) {
    return oldWidget.service != service;
  }
}

class SharedAlbumService {
  final AuthenticationStateData _authenticationStateData;
  final SharedAlbumStateData _sharedAlbumStateData;
  final StorageService _storageService;

  SharedAlbumService({
    required AuthenticationStateData authenticationStateData,
    required SharedAlbumStateData sharedAlbumStateData,
    required StorageService storageService,
  })  : _authenticationStateData = authenticationStateData,
        _sharedAlbumStateData = sharedAlbumStateData,
        _storageService = storageService;

  Future<List<Album>> list() async {
    final sharedAlbums = <Album>[];

    final api = PhotosLibraryApi(_authenticationStateData.client!);

    String? pageToken;

    do {
      final response = await api.sharedAlbums.list(
        pageSize: 50,
        pageToken: pageToken,
      );

      sharedAlbums.addAll(response.sharedAlbums ?? []);

      pageToken = response.nextPageToken;
    } while (pageToken != null);

    await _storageService.setSharedAlbums(sharedAlbums);

    return _sharedAlbumStateData.sharedAlbums = sharedAlbums;
  }
}
