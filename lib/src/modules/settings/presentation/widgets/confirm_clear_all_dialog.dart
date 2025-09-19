import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../view_model/settings_view_model.dart';

Future<void> confirmClearAll(BuildContext context, SettingsViewModel vm) async {
  final colors = AppTheme.of(context).colors;
  final ok = await showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Apagar todos os dados'),
      content: const Text('Esta ação não pode ser desfeita. Deseja continuar?'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text('Apagar', style: TextStyle(color: colors.red)),
        ),
      ],
    ),
  );
  if (ok == true) {
    await vm.clearAllData();
    if (context.mounted) Navigator.of(context).pop(true);
  }
}
