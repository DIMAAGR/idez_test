import 'package:flutter/material.dart';
import 'package:idez_test/src/core/theme/app_theme.dart';

class HomeTitle extends StatelessWidget {
  final VoidCallback onSettingsPressed;
  const HomeTitle({super.key, required this.onSettingsPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bem Vindo', style: AppTheme.of(context).textStyles.h5),
            Text(
              'Visualize as suas tarefas de hoje',
              style: AppTheme.of(context).textStyles.body1Regular,
            ),
          ],
        ),
        IconButton(
          onPressed: onSettingsPressed,
          icon: Icon(Icons.settings_outlined, color: AppTheme.of(context).colors.black),
        ),
      ],
    );
  }
}
