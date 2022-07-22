import 'dart:io';

import '../../states/authentication_state.dart';
import '../../states/layout_state.dart';
import '../../states/shared_album_state.dart';
import '../../states/theme_state.dart';
import '../storage_service.dart';
import 'authentication_service.dart';
import 'base_authentication_service.dart';
import 'desktop_authentication_service.dart';
import 'mobile_authentication_service.dart';

AuthenticationService createAuthenticationService(
  AuthenticationStateData authenticationStateData,
  LayoutStateData layoutStateData,
  SharedAlbumStateData sharedAlbumStateData,
  StorageService storageService,
  ThemeStateData themeStateData,
) =>
    Platform.isLinux || Platform.isMacOS || Platform.isWindows
        ? DesktopAuthenticationService(
            authenticationStateData: authenticationStateData,
            layoutStateData: layoutStateData,
            sharedAlbumStateData: sharedAlbumStateData,
            storageService: storageService,
            themeStateData: themeStateData,
          )
        : MobileAuthenticationService(
            authenticationStateData: authenticationStateData,
            layoutStateData: layoutStateData,
            sharedAlbumStateData: sharedAlbumStateData,
            storageService: storageService,
            themeStateData: themeStateData,
          );

abstract class IoAuthenticationService extends BaseAuthenticationService {
  IoAuthenticationService({
    required String assetBundleKey,
    required AuthenticationStateData authenticationStateData,
    required LayoutStateData layoutStateData,
    required SharedAlbumStateData sharedAlbumStateData,
    required StorageService storageService,
    required ThemeStateData themeStateData,
  }) : super(
          assetBundleKey: assetBundleKey,
          authenticationStateData: authenticationStateData,
          layoutStateData: layoutStateData,
          sharedAlbumStateData: sharedAlbumStateData,
          storageService: storageService,
          themeStateData: themeStateData,
        );
}
