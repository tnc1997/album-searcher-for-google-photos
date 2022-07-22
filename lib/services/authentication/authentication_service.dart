import 'package:flutter/widgets.dart';

import '../../states/authentication_state.dart';
import '../../states/layout_state.dart';
import '../../states/shared_album_state.dart';
import '../../states/theme_state.dart';
import '../storage_service.dart';
import 'authentication_service_stub.dart'
    if (dart.library.html) 'browser_authentication_service.dart'
    if (dart.library.io) 'io_authentication_service.dart';

class AuthenticationServiceScope extends InheritedWidget {
  final AuthenticationService service;

  const AuthenticationServiceScope({
    Key? key,
    required this.service,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  static AuthenticationService of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AuthenticationServiceScope>()!
        .service;
  }

  @override
  bool updateShouldNotify(covariant AuthenticationServiceScope oldWidget) {
    return oldWidget.service != service;
  }
}

abstract class AuthenticationService {
  factory AuthenticationService({
    required AuthenticationStateData authenticationStateData,
    required LayoutStateData layoutStateData,
    required SharedAlbumStateData sharedAlbumStateData,
    required StorageService storageService,
    required ThemeStateData themeStateData,
  }) =>
      createAuthenticationService(
        authenticationStateData,
        layoutStateData,
        sharedAlbumStateData,
        storageService,
        themeStateData,
      );

  Future<void> signInInteractive();

  Future<void> signInSilent();

  Future<void> signOut();
}
