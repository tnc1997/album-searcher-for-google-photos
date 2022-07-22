import 'package:flutter/widgets.dart';
import 'package:googleapis/photoslibrary/v1.dart';

import '../states/authentication_state.dart';

class AlbumServiceScope extends InheritedWidget {
  final AlbumService service;

  const AlbumServiceScope({
    Key? key,
    required this.service,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  static AlbumService of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AlbumServiceScope>()!
        .service;
  }

  @override
  bool updateShouldNotify(covariant AlbumServiceScope oldWidget) {
    return oldWidget.service != service;
  }
}

class AlbumService {
  final AuthenticationStateData _authenticationStateData;

  AlbumService({
    required AuthenticationStateData authenticationStateData,
  }) : _authenticationStateData = authenticationStateData;

  Future<Album> get(String albumId) async {
    return await PhotosLibraryApi(_authenticationStateData.client!)
        .albums
        .get(albumId);
  }
}
