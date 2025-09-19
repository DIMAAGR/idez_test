import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../shared/domain/enums/selected_theme_enum.dart';
import '../../view_model/settings_view_model.dart';

Future<void> _onSelectTheme(SettingsViewModel vm, SelectedTheme theme, BuildContext context) async {
  vm.setSelectedTheme(theme);
  if (context.mounted) Navigator.pop(context);

  await Future.delayed(const Duration(milliseconds: 500));
  await vm.save();
}

void showThemeBottomSheet(BuildContext context, SettingsViewModel vm) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    transitionAnimationController: AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 500),
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Observer(
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: AppTheme.of(context).colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 12),
            Text('Tema', style: AppTheme.of(context).textStyles.h6),
            const SizedBox(height: 8),
            RadioListTile<SelectedTheme>(
              value: SelectedTheme.light,
              groupValue: vm.selectedTheme,
              onChanged: (v) => _onSelectTheme(vm, v!, context),
              title: const Text('Claro'),
            ),
            RadioListTile<SelectedTheme>(
              value: SelectedTheme.dark,
              groupValue: vm.selectedTheme,
              onChanged: (v) => _onSelectTheme(vm, v!, context),
              title: const Text('Escuro'),
            ),
            RadioListTile<SelectedTheme>(
              value: SelectedTheme.system,
              groupValue: vm.selectedTheme,
              onChanged: (v) => _onSelectTheme(vm, v!, context),
              title: const Text('Seguir sistema'),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    ),
  );
}
