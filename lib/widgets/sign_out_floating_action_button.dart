import 'package:flutter/material.dart';

import '../services/authentication/authentication_service.dart';

class SignOutFloatingActionButton extends StatelessWidget {
  const SignOutFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.logout),
      tooltip: 'Sign out',
      onPressed: () async {
        try {
          await AuthenticationServiceScope.of(context).signOut();
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
    );
  }
}
