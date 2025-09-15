import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class DeleteButton extends StatelessWidget {
  final bool isActivated;
  final VoidCallback? onDelete;
  const DeleteButton({super.key, required this.isActivated, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isActivated,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 220),
        opacity: isActivated ? 1 : 0,
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            tooltip: 'Excluir selecionadas',
            icon: Icon(Icons.delete, color: AppTheme.colors.red),
            onPressed: onDelete,
          ),
        ),
      ),
    );
  }
}
