import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/enums/task_filter_enum.dart';

class BoardFilter extends StatelessWidget {
  final List<String> categories;
  final TaskFilter selectedFilter;
  final Function(TaskFilter) onFilterSelected;
  final String? selectedCategoryId;
  final Function(String?) onCategorySelected;
  final VoidCallback onClearFilters;
  final String? Function(String) getCategoryNameById;
  final bool hidePending;

  const BoardFilter({
    super.key,
    required this.categories,
    required this.selectedFilter,
    required this.onFilterSelected,
    this.selectedCategoryId,
    required this.onCategorySelected,
    required this.onClearFilters,
    required this.hidePending,
    required this.getCategoryNameById,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.colors;

    final labels = {
      TaskFilter.all: 'Todas',
      if (!hidePending) TaskFilter.pending: 'Pendentes',
      if (!hidePending) TaskFilter.done: 'Concluídas',
      TaskFilter.today: 'Hoje',
      TaskFilter.thisWeek: 'Semana',
    };

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colors.grey.withOpacity(.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text('Filtros', style: AppTheme.textStyles.h6),
          const SizedBox(height: 12),

          Text('Status', style: AppTheme.textStyles.body1Bold),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: TaskFilter.values
                .where((f) {
                  if (hidePending && (f == TaskFilter.pending || f == TaskFilter.done)) {
                    return false;
                  }
                  return true;
                })
                .map((f) {
                  final selected = selectedFilter == f;
                  return ChoiceChip(
                    checkmarkColor: colors.blue,
                    selectedColor: colors.lightBlue,
                    backgroundColor: Colors.white,
                    label: Text(
                      labels[f]!,
                      style: AppTheme.textStyles.body2Regular.copyWith(
                        color: selected ? colors.blue : colors.black,
                      ),
                    ),
                    selected: selected,
                    onSelected: (_) => onFilterSelected(f),
                  );
                })
                .toList(),
          ),

          const SizedBox(height: 16),
          Text('Categoria', style: AppTheme.textStyles.body1Bold),

          RadioListTile<String?>(
            value: null,
            groupValue: selectedCategoryId,
            activeColor: colors.blue,
            title: Text('Todas', style: AppTheme.textStyles.button),
            dense: true,
            onChanged: onCategorySelected,
          ),
          ...categories.map(
            (id) => RadioListTile<String?>(
              value: id,
              activeColor: colors.blue,
              groupValue: selectedCategoryId,
              title: Text(getCategoryNameById(id) ?? 'error', style: AppTheme.textStyles.button),
              dense: true,
              onChanged: onCategorySelected,
            ),
          ),

          const SizedBox(height: 8),
          Row(
            children: [
              TextButton(
                onPressed: onClearFilters,
                child: Text('Limpar', style: AppTheme.textStyles.body2Regular),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Aplicar',
                  style: AppTheme.textStyles.body2Regular.copyWith(color: colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
