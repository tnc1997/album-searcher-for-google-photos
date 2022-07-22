import 'package:flutter/material.dart';

import '../enums/layout_mode.dart';
import '../services/storage_service.dart';
import '../states/layout_state.dart';

class LayoutDropdownButtonFormField extends StatelessWidget {
  const LayoutDropdownButtonFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<LayoutMode>(
      items: [
        DropdownMenuItem(
          value: LayoutMode.grid,
          child: Text('Grid'),
        ),
        DropdownMenuItem(
          value: LayoutMode.list,
          child: Text('List'),
        ),
      ],
      value: LayoutState.of(context).layoutMode,
      onChanged: (value) async {
        if (value != null) {
          await StorageServiceScope.of(context).setLayoutMode(value);
        }

        LayoutState.of(context).layoutMode = value;
      },
      decoration: InputDecoration(
        labelText: 'Layout',
        border: OutlineInputBorder(),
      ),
    );
  }
}
