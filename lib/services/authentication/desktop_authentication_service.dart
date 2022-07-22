import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:googleapis/photoslibrary/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../states/authentication_state.dart';
import '../../states/layout_state.dart';
import '../../states/shared_album_state.dart';
import '../../states/theme_state.dart';
import '../authentication/io_authentication_service.dart';
import '../storage_service.dart';
import 'authentication_service.dart';

AuthenticationService createAuthenticationService(
  AuthenticationStateData authenticationStateData,
  LayoutStateData layoutStateData,
  SharedAlbumStateData sharedAlbumStateData,
  StorageService storageService,
  ThemeStateData themeStateData,
) =>
    DesktopAuthenticationService(
      authenticationStateData: authenticationStateData,
      layoutStateData: layoutStateData,
      sharedAlbumStateData: sharedAlbumStateData,
      storageService: storageService,
      themeStateData: themeStateData,
    );

class DesktopAuthenticationService extends IoAuthenticationService {
  DesktopAuthenticationService({
    required AuthenticationStateData authenticationStateData,
    required LayoutStateData layoutStateData,
    required SharedAlbumStateData sharedAlbumStateData,
    required StorageService storageService,
    required ThemeStateData themeStateData,
  }) : super(
          assetBundleKey: 'files/desktop_client_secret.json',
          authenticationStateData: authenticationStateData,
          layoutStateData: layoutStateData,
          sharedAlbumStateData: sharedAlbumStateData,
          storageService: storageService,
          themeStateData: themeStateData,
        );

  @override
  Future<void> signInInteractive() async {
    final config = json.decode(await rootBundle.loadString(assetBundleKey));

    authenticationStateData.client = await clientViaUserConsent(
      ClientId(
        config['installed']['client_id'],
        config['installed']['client_secret'],
      ),
      ['openid', PhotosLibraryApi.photoslibraryReadonlyScope],
      (uri) async => await launchUrlString(uri),
    );
  }
}
