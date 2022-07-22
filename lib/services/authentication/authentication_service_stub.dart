import '../../states/authentication_state.dart';
import '../../states/layout_state.dart';
import '../../states/shared_album_state.dart';
import '../../states/theme_state.dart';
import '../storage_service.dart';
import 'authentication_service.dart';

AuthenticationService createAuthenticationService(
  AuthenticationStateData authenticationStateData,
  LayoutStateData layoutStateData,
  SharedAlbumStateData sharedAlbumStateData,
  StorageService storageService,
  ThemeStateData themeStateData,
) =>
    throw UnsupportedError(
      'Cannot create an authentication service without dart:html or dart:io.',
    );
