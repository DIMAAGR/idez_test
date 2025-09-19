import 'package:flutter/material.dart';

class SettingsSectionHeader extends StatelessWidget {
  final String text;
  const SettingsSectionHeader(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(top: 24.0, bottom: 8.0), child: Text(text));
  }
}
