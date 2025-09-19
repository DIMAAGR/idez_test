import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? iconColor;
  final bool destructive;
  final bool dense;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
    this.iconColor,
    this.destructive = false,
    this.dense = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    final titleStyle = destructive
        ? AppTheme.of(context).textStyles.subtitle1Medium.copyWith(color: colors.red)
        : AppTheme.of(context).textStyles.subtitle1Medium;

    final subStyle = destructive
        ? AppTheme.of(context).textStyles.body2Regular.copyWith(color: colors.red)
        : AppTheme.of(context).textStyles.body2Regular.copyWith(color: colors.darkGrey);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                icon,
                size: 24,
                color: destructive ? colors.red : (iconColor ?? colors.blue),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: dense ? MainAxisAlignment.center : MainAxisAlignment.start,
                children: [
                  Text(title, style: titleStyle),
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(subtitle!, style: subStyle),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            trailing ??
                Icon(Icons.arrow_forward_ios, size: 16, color: colors.black.withOpacity(0.7)),
          ],
        ),
      ),
    );
  }
}
