import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:idez_test/src/modules/settings/presentation/widgets/bottom_sheet/theme_bottom_sheet.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../shared/presentation/widgets/fade_in.dart';
import '../../../shared/presentation/widgets/task_view_body.dart';
import '../view_model/settings_view_model.dart';
import '../widgets/settings_section_header.dart';
import '../widgets/settings_tile.dart';

class SettingsView extends StatelessWidget {
  final SettingsViewModel viewModel;
  const SettingsView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;

    return PopScope(
      onPopInvokedWithResult: (_, __) async {
        await viewModel.save();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Configurações', style: AppTheme.of(context).textStyles.body1Regular),
        ),
        body: TaskViewBody(
          padding: const EdgeInsets.all(16),
          hasScrollableChild: true,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeIn(
              delay: const Duration(milliseconds: 200),
              child: Text(
                'Altere as configurações do aplicativo.',
                style: AppTheme.of(context).textStyles.h6medium,
              ),
            ),

            const SizedBox(height: 8),
            FadeIn(
              delay: const Duration(milliseconds: 260),
              child: const SettingsSectionHeader('Geral'),
            ),

            FadeIn(
              delay: const Duration(milliseconds: 320),
              child: Observer(
                builder: (_) {
                  return SettingsTile(
                    icon: Icons.notifications_outlined,
                    title: 'Notificações',
                    subtitle: 'Gerencie suas notificações',
                    iconColor: colors.orange,
                    trailing: Switch(
                      value: viewModel.isNotificationEnabled,
                      onChanged: (_) => viewModel.toggleNotification(),
                    ),
                    onTap: () => viewModel.toggleNotification(),
                  );
                },
              ),
            ),

            FadeIn(
              delay: const Duration(milliseconds: 360),
              child: SettingsTile(
                icon: Icons.color_lens_outlined,
                title: 'Tema',
                subtitle: 'Altere o tema do aplicativo',
                iconColor: colors.purple,
                onTap: () => showThemeBottomSheet(context, viewModel),
              ),
            ),

            FadeIn(
              delay: const Duration(milliseconds: 400),
              child: Observer(
                builder: (_) {
                  // if (!viewModel.flagPasswordEnabled) return const SizedBox.shrink();
                  return SettingsTile(
                    icon: Icons.lock_outline,
                    title: 'Senha do App',
                    subtitle: 'Proteja as suas tarefas',
                    iconColor: colors.red,
                    trailing: Switch(
                      value: viewModel.isPasswordEnabled,
                      onChanged: (_) => viewModel.togglePassword(),
                    ),
                    onTap: () => viewModel.togglePassword(),
                  );
                },
              ),
            ),

            FadeIn(
              delay: const Duration(milliseconds: 440),
              child: SettingsTile(
                icon: Icons.list,
                title: 'Lista de Recentes',
                subtitle: 'Altere o tamanho da lista',
                iconColor: colors.blue,
                onTap: () {},
              ),
            ),

            const SizedBox(height: 8),
            FadeIn(
              delay: const Duration(milliseconds: 480),
              child: const SettingsSectionHeader('Configurações Avançadas'),
            ),

            FadeIn(
              delay: const Duration(milliseconds: 520),
              child: SettingsTile(
                icon: Icons.delete_outlined,
                title: 'Apagar Dados',
                subtitle: 'Apague todos os dados do app',
                destructive: true,
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: colors.red.withOpacity(0.9),
                ),
                onTap: () {},
              ),
            ),

            const SizedBox(height: 32),
            Center(child: Text('Versão 1.0.0', style: AppTheme.of(context).textStyles.caption)),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
