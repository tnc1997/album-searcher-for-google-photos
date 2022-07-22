import 'package:flutter/material.dart';

import '../services/authentication/authentication_service.dart';

class SignInElevatedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          await AuthenticationServiceScope.of(context).signInInteractive();
        } catch (e) {
          await showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text(e.toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      },
      child: Text('SIGN IN'),
    );
  }
}
