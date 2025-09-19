import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class ActionsButtons extends StatelessWidget {
  final VoidCallback? onActiveFiltersPressed;
  final bool hasActiveFilters;
  final bool isActivated;
  final VoidCallback? onAddTaskPressed;
  const ActionsButtons({
    super.key,
    this.onActiveFiltersPressed,
    required this.hasActiveFilters,
    required this.isActivated,
    this.onAddTaskPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isActivated,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isActivated ? 0 : 1,
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                tooltip: 'Filtrar',
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(Icons.filter_alt_rounded, color: AppTheme.of(context).colors.darkGrey),
                    if (hasActiveFilters)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppTheme.of(context).colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: onActiveFiltersPressed,
              ),
              IconButton(
                tooltip: 'Adicionar tarefa',
                icon: Icon(Icons.add_rounded, color: AppTheme.of(context).colors.darkGrey),
                onPressed: onAddTaskPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
