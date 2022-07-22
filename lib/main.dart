import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../route_information_parsers/app_route_information_parser.dart';
import '../route_paths/route_path.dart';
import '../router_delegates/app_router_delegate.dart';
import '../services/album_service.dart';
import '../services/authentication/authentication_service.dart';
import '../services/media_item_service.dart';
import '../services/shared_album_service.dart';
import '../services/storage_service.dart';
import '../states/authentication_state.dart';
import '../states/layout_state.dart';
import '../states/router_state.dart';
import '../states/shared_album_state.dart';
import '../states/theme_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp();
  }

  final storageService = StorageService();

  final authenticationStateData = AuthenticationStateData();
  final layoutStateData = LayoutStateData(
    layoutMode: await storageService.getLayoutMode(),
  );
  final routerStateData = RouterStateData();
  final sharedAlbumStateData = SharedAlbumStateData(
    sharedAlbums: await storageService.getSharedAlbums(),
  );
  final themeStateData = ThemeStateData(
    themeMode: await storageService.getThemeMode(),
  );

  final albumService = AlbumService(
    authenticationStateData: authenticationStateData,
  );
  final authenticationService = AuthenticationService(
    authenticationStateData: authenticationStateData,
    layoutStateData: layoutStateData,
    sharedAlbumStateData: sharedAlbumStateData,
    storageService: storageService,
    themeStateData: themeStateData,
  );
  final mediaItemService = MediaItemService(
    authenticationStateData: authenticationStateData,
  );
  final sharedAlbumService = SharedAlbumService(
    authenticationStateData: authenticationStateData,
    sharedAlbumStateData: sharedAlbumStateData,
    storageService: storageService,
  );

  try {
    await authenticationService.signInSilent();
  } catch (e) {
    await authenticationService.signOut();
  }

  runApp(
    App(
      albumService: albumService,
      authenticationService: authenticationService,
      authenticationStateData: authenticationStateData,
      layoutStateData: layoutStateData,
      mediaItemService: mediaItemService,
      routeInformationParser: AppRouteInformationParser(),
      routerDelegate: AppRouterDelegate(
        authenticationStateData: authenticationStateData,
        routerStateData: routerStateData,
      ),
      routerStateData: routerStateData,
      sharedAlbumService: sharedAlbumService,
      sharedAlbumStateData: sharedAlbumStateData,
      storageService: storageService,
      themeStateData: themeStateData,
    ),
  );
}

class App extends StatefulWidget {
  final AlbumService albumService;
  final AuthenticationService authenticationService;
  final AuthenticationStateData authenticationStateData;
  final LayoutStateData layoutStateData;
  final MediaItemService mediaItemService;
  final RouteInformationParser<RoutePath> routeInformationParser;
  final AppRouterDelegate routerDelegate;
  final RouterStateData routerStateData;
  final SharedAlbumService sharedAlbumService;
  final SharedAlbumStateData sharedAlbumStateData;
  final StorageService storageService;
  final ThemeStateData themeStateData;

  const App({
    super.key,
    required this.albumService,
    required this.authenticationService,
    required this.authenticationStateData,
    required this.layoutStateData,
    required this.mediaItemService,
    required this.routeInformationParser,
    required this.routerDelegate,
    required this.routerStateData,
    required this.sharedAlbumService,
    required this.sharedAlbumStateData,
    required this.storageService,
    required this.themeStateData,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return AlbumServiceScope(
      service: widget.albumService,
      child: AuthenticationServiceScope(
        service: widget.authenticationService,
        child: AuthenticationState(
          notifier: widget.authenticationStateData,
          child: LayoutState(
            notifier: widget.layoutStateData,
            child: MediaItemServiceScope(
              service: widget.mediaItemService,
              child: RouterState(
                notifier: widget.routerStateData,
                child: SharedAlbumServiceScope(
                  service: widget.sharedAlbumService,
                  child: SharedAlbumState(
                    notifier: widget.sharedAlbumStateData,
                    child: StorageServiceScope(
                      service: widget.storageService,
                      child: ThemeState(
                        notifier: widget.themeStateData,
                        child: Builder(
                          builder: (context) => MaterialApp.router(
                            routeInformationParser:
                                widget.routeInformationParser,
                            routerDelegate: widget.routerDelegate,
                            title: 'Album Searcher for Google Photos',
                            theme: ThemeData.from(
                              colorScheme: const ColorScheme.light(
                                primary: Colors.red,
                                secondary: Colors.red,
                                onPrimary: Colors.white,
                                onSecondary: Colors.white,
                              ),
                            ),
                            darkTheme: ThemeData.from(
                              colorScheme: const ColorScheme.dark(
                                primary: Colors.red,
                                secondary: Colors.red,
                                onPrimary: Colors.white,
                                onSecondary: Colors.white,
                              ),
                            ),
                            themeMode: ThemeState.of(context).themeMode,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.authenticationStateData.dispose();
    widget.layoutStateData.dispose();
    widget.routerDelegate.dispose();
    widget.routerStateData.dispose();
    widget.sharedAlbumStateData.dispose();
    widget.themeStateData.dispose();
    super.dispose();
  }
}
