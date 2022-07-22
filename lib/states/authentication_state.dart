import 'package:flutter/material.dart';
import 'package:googleapis_auth/googleapis_auth.dart';

class AuthenticationState extends InheritedNotifier<AuthenticationStateData> {
  const AuthenticationState({
    Key? key,
    required AuthenticationStateData notifier,
    required Widget child,
  }) : super(
          key: key,
          notifier: notifier,
          child: child,
        );

  static AuthenticationStateData of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AuthenticationState>()!
        .notifier!;
  }
}

class AuthenticationStateData extends ChangeNotifier {
  AuthClient? _client;

  AuthenticationStateData({
    AuthClient? client,
  }) : _client = client;

  AuthClient? get client => _client;

  set client(AuthClient? client) {
    if (client != _client) {
      _client = client;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _client?.close();
    super.dispose();
  }
}
