import 'package:flutter/material.dart';

import '../widgets/layout_dropdown_form_field.dart';
import '../widgets/sign_out_floating_action_button.dart';
import '../widgets/theme_dropdown_form_field.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: LayoutDropdownButtonFormField(),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ThemeDropdownButtonFormField(),
            ),
          ],
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: SignOutFloatingActionButton(),
        ),
      ],
    );
  }
}
