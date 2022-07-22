import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:oauth2/oauth2.dart';

import '../../states/authentication_state.dart';
import '../../states/layout_state.dart';
import '../../states/shared_album_state.dart';
import '../../states/theme_state.dart';
import '../storage_service.dart';
import 'authentication_service.dart';

abstract class BaseAuthenticationService implements AuthenticationService {
  @protected
  final String assetBundleKey;
  @protected
  final AuthenticationStateData authenticationStateData;
  @protected
  final LayoutStateData layoutStateData;
  @protected
  final SharedAlbumStateData sharedAlbumStateData;
  @protected
  final StorageService storageService;
  @protected
  final ThemeStateData themeStateData;

  BaseAuthenticationService({
    required this.assetBundleKey,
    required this.authenticationStateData,
    required this.layoutStateData,
    required this.sharedAlbumStateData,
    required this.storageService,
    required this.themeStateData,
  });

  @override
  Future<void> signInSilent() async {
    final config = json.decode(await rootBundle.loadString(assetBundleKey));

    final credentials = await storageService.getCredentials();

    if (credentials != null) {
      // final client = Client(
      //   credentials,
      //   identifier: (config['installed'] ?? config['web'])['client_id'],
      //   secret: (config['installed'] ?? config['web'])['client_secret'],
      //   onCredentialsRefreshed: onCredentialsRefreshed,
      // );
      //
      // await client.refreshCredentials();
      //
      // authenticationStateData.client = client;
    }
  }

  @override
  Future<void> signOut() async {
    await storageService.clear();

    authenticationStateData.client = null;
    layoutStateData.layoutMode = null;
    sharedAlbumStateData.sharedAlbums = null;
    themeStateData.themeMode = null;
  }

  @protected
  Future<void> onCredentialsRefreshed(Credentials credentials) async {
    await storageService.setCredentials(credentials);
  }
}
