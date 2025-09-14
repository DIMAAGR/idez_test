import 'package:flutter/material.dart';
import 'package:idez_test/src/core/theme/app_theme.dart';

class TaskOptionCard extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;
  final String title;
  final int count;
  final Color iconColor;
  final Color backgroundColor;
  const TaskOptionCard({
    super.key,
    this.onTap,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        backgroundColor: backgroundColor,
        overlayColor: AppTheme.colors.darkGrey,
        alignment: Alignment.topLeft,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        elevation: 0,
      ),
      onPressed: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: iconColor, size: 24),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$count ',
                  style: AppTheme.textStyles.body2Bold.copyWith(color: AppTheme.colors.black),
                ),
                TextSpan(
                  text: title,
                  style: AppTheme.textStyles.body2Regular.copyWith(color: AppTheme.colors.darkGrey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
