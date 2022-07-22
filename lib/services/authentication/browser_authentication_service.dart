import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:googleapis/photoslibrary/v1.dart';
import 'package:googleapis_auth/auth_browser.dart';

import '../../states/authentication_state.dart';
import '../../states/layout_state.dart';
import '../../states/shared_album_state.dart';
import '../../states/theme_state.dart';
import '../authentication/base_authentication_service.dart';
import '../storage_service.dart';
import 'authentication_service.dart';

AuthenticationService createAuthenticationService(
  AuthenticationStateData authenticationStateData,
  LayoutStateData layoutStateData,
  SharedAlbumStateData sharedAlbumStateData,
  StorageService storageService,
  ThemeStateData themeStateData,
) =>
    BrowserAuthenticationService(
      authenticationStateData: authenticationStateData,
      layoutStateData: layoutStateData,
      sharedAlbumStateData: sharedAlbumStateData,
      storageService: storageService,
      themeStateData: themeStateData,
    );

class BrowserAuthenticationService extends BaseAuthenticationService {
  BrowserAuthenticationService({
    required AuthenticationStateData authenticationStateData,
    required LayoutStateData layoutStateData,
    required SharedAlbumStateData sharedAlbumStateData,
    required StorageService storageService,
    required ThemeStateData themeStateData,
  }) : super(
          assetBundleKey: 'files/browser_client_secret.json',
          authenticationStateData: authenticationStateData,
          layoutStateData: layoutStateData,
          sharedAlbumStateData: sharedAlbumStateData,
          storageService: storageService,
          themeStateData: themeStateData,
        );

  @override
  Future<void> signInInteractive() async {
    final config = json.decode(await rootBundle.loadString(assetBundleKey));

    final flow = await createImplicitBrowserFlow(
      ClientId(config['web']['client_id']),
      ['openid', PhotosLibraryApi.photoslibraryReadonlyScope],
    );

    try {
      authenticationStateData.client = await flow.clientViaUserConsent();
    } finally {
      flow.close();
    }
  }
}
