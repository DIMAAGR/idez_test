import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../shared/presentation/widgets/fade_in.dart';
import '../../../shared/presentation/widgets/task_view_body.dart';
import '../view_model/settings_view_model.dart';

class SettingsView extends StatelessWidget {
  final SettingsViewModel viewModel;
  const SettingsView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TaskViewBody(
        padding: const EdgeInsets.all(16),
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        hasScrollableChild: true,
        children: [
          const SizedBox(height: 24),
          FadeIn(
            delay: const Duration(milliseconds: 300),
            child: Observer(builder: (_) => Text('Configurações', style: AppTheme.textStyles.h5)),
          ),
        ],
      ),
    );
  }
}
