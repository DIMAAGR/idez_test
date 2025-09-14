import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../models/pill_tab_enum.dart';

class BottomPillNav extends StatelessWidget {
  final PillTab current;
  final ValueChanged<PillTab> onChanged;

  const BottomPillNav({super.key, required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(color: Colors.white),
      child: _PillTrack(current: current, onChanged: onChanged),
    );
  }
}

class _PillTrack extends StatelessWidget {
  final PillTab current;
  final ValueChanged<PillTab> onChanged;

  const _PillTrack({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    const tabs = [PillTab.home, PillTab.done];

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final itemW = (w) / tabs.length;

        return SizedBox(
          height: 72,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutCubic,
                left: current == PillTab.home ? 0 : itemW,
                width: itemW,
                top: 0,
                bottom: 0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 260),
                  curve: Curves.easeOutCubic,
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: (AppTheme.colors.blue).withAlpha((255 * .12).round()),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Row(
                children: [
                  _PillItem(
                    width: itemW,
                    icon: Icons.home_outlined,
                    active: current == PillTab.home,
                    onTap: () => onChanged(PillTab.home),
                  ),
                  _PillItem(
                    width: itemW,
                    icon: Icons.check_circle_outline,
                    active: current == PillTab.done,
                    onTap: () => onChanged(PillTab.done),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PillItem extends StatelessWidget {
  final double width;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  const _PillItem({
    required this.width,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = AppTheme.colors.darkGrey;
    final accent = AppTheme.colors.blue;

    return SizedBox(
      width: width,
      height: 72,
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Center(
          child: Icon(
            icon,
            size: 26,
            color: active ? accent : baseColor.withAlpha((255 * .84).round()),
          ),
        ),
      ),
    );
  }
}
