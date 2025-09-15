import 'package:flutter/material.dart';
import 'package:idez_test/src/core/theme/app_theme.dart';

class CategoryTile extends StatelessWidget {
  final String id;
  final String title;
  final bool selected;
  final bool isSelectionEnabled;

  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onLongPress;
  final VoidCallback? onTap;

  const CategoryTile({
    super.key,
    required this.id,
    required this.title,
    required this.selected,
    required this.isSelectionEnabled,
    this.onEdit,
    this.onDelete,
    this.onLongPress,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      selectedTileColor: AppTheme.colors.lightBlue,
      tileColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0,
      onTap: isSelectionEnabled ? onTap : null,
      onLongPress: onLongPress,
      title: Text(title, style: AppTheme.textStyles.body2Regular, overflow: TextOverflow.clip),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'edit') {
            onEdit?.call();
          } else if (value == 'delete') {
            onDelete?.call();
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'edit',
            child: Row(children: [Icon(Icons.edit, size: 18), SizedBox(width: 8), Text('Editar')]),
          ),
          PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete, size: 18, color: AppTheme.colors.red),
                SizedBox(width: 8),
                Text(
                  'Deletar',
                  style: AppTheme.textStyles.body2Regular.copyWith(color: AppTheme.colors.red),
                ),
              ],
            ),
          ),
        ],
        icon: Icon(Icons.more_vert, color: Colors.grey[600]),
      ),
    );
  }
}
