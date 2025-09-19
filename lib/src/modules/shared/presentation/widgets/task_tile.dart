import 'package:flutter/material.dart';
import 'package:idez_test/src/core/extensions/date_time_extension.dart';
import 'package:idez_test/src/core/theme/app_theme.dart';

class TaskTile extends StatelessWidget {
  final String id;
  final String title;
  final DateTime? date;
  final bool isCompleted;
  final String category;
  final bool selected;
  final bool isSelectionEnabled;
  final ValueChanged<bool>? onChanged;

  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onLongPress;
  final VoidCallback? onTap;

  const TaskTile({
    super.key,
    required this.id,
    required this.title,
    this.date,
    required this.isCompleted,
    required this.category,
    required this.selected,
    required this.isSelectionEnabled,
    this.onChanged,
    this.onEdit,
    this.onDelete,
    this.onLongPress,
    this.onTap,
  });

  Color _dateColor(BuildContext context) {
    if (isCompleted) return AppTheme.of(context).colors.green;
    if (date == null) return AppTheme.of(context).colors.darkGrey;
    if (date!.isOlderThanNow) return AppTheme.of(context).colors.red;
    if (date!.isToday) return AppTheme.of(context).colors.orange;
    if (date!.isTomorrow) return AppTheme.of(context).colors.blue;
    return AppTheme.of(context).colors.darkGrey;
  }

  @override
  Widget build(BuildContext context) {
    final dateColor = _dateColor(context);

    return ListTile(
      selected: selected,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      selectedTileColor: AppTheme.of(context).colors.lightBlue,
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0,
      onTap: isSelectionEnabled ? onTap : () => onChanged?.call(!isCompleted),
      onLongPress: onLongPress,
      leading: Container(
        padding: const EdgeInsets.only(left: 8.0),
        width: 40,
        child: Align(
          alignment: Alignment.topLeft,

          child: Checkbox(
            value: isCompleted,
            shape: const CircleBorder(),
            activeColor: AppTheme.of(context).colors.green,
            onChanged: (v) => onChanged?.call(v ?? false),
          ),
        ),
      ),

      title: Text(
        title,
        style: AppTheme.of(context).textStyles.body2Regular,
        overflow: TextOverflow.clip,
      ),

      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.calendar_today_outlined, size: 12, color: dateColor),
              const SizedBox(width: 4),
              Text(
                date != null ? date!.formatRelative() : 'Nenhuma data definida',
                style: AppTheme.of(context).textStyles.caption.copyWith(color: dateColor),
              ),
            ],
          ),
          RichText(
            text: TextSpan(
              style: AppTheme.of(context).textStyles.caption,
              children: [
                TextSpan(text: category),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Text(' #', style: AppTheme.of(context).textStyles.body2Bold),
                ),
              ],
            ),
          ),
        ],
      ),

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
                Icon(Icons.delete, size: 18, color: AppTheme.of(context).colors.red),
                SizedBox(width: 8),
                Text(
                  'Deletar',
                  style: AppTheme.of(
                    context,
                  ).textStyles.body2Regular.copyWith(color: AppTheme.of(context).colors.red),
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
