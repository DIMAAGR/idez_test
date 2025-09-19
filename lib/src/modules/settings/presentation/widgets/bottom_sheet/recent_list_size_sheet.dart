import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../view_model/settings_view_model.dart';

Future<void> showRecentListSizeSheet(BuildContext context, SettingsViewModel vm) async {
  final sizes = [5, 10, 20, 50, 100];
  await showModalBottomSheet(
    context: context,
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
            Text('Tamanho da lista de recentes', style: AppTheme.of(context).textStyles.h6),
            const SizedBox(height: 12),
            for (final s in sizes)
              RadioListTile<int>(
                value: s,
                groupValue: vm.recentListSize,
                onChanged: (v) async {
                  vm.recentListSize = v!;
                  await vm.save();
                  if (context.mounted) Navigator.pop(context);
                },
                title: Text('$s itens'),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    ),
  );
}
