import 'package:flutter/material.dart';
import 'package:idez_test/src/core/theme/app_theme.dart';

class FabMenu extends StatefulWidget {
  final VoidCallback onNewTask;
  final VoidCallback onNewCategory;

  const FabMenu({super.key, required this.onNewTask, required this.onNewCategory});

  @override
  State<FabMenu> createState() => _FabMenuState();
}

class _FabMenuState extends State<FabMenu> with SingleTickerProviderStateMixin {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: !_open
              ? const SizedBox.shrink()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  key: const ValueKey('options'),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _MiniAction(
                      icon: Icons.check_box,
                      label: 'Nova tarefa',
                      onTap: () {
                        setState(() => _open = false);
                        widget.onNewTask();
                      },
                    ),
                    const SizedBox(height: 8),
                    _MiniAction(
                      icon: Icons.folder,
                      label: 'Nova categoria',
                      onTap: () {
                        setState(() => _open = false);
                        widget.onNewCategory();
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
        ),
        FloatingActionButton(
          backgroundColor: AppTheme.of(context).colors.blue,
          shape: CircleBorder(),
          heroTag: 'fab-main',
          elevation: 0,
          onPressed: () => setState(() => _open = !_open),
          child: Icon(_open ? Icons.close : Icons.add),
        ),
      ],
    );
  }
}

class _MiniAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MiniAction({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppTheme.of(context).colors.grey, width: 2),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Icon(icon, size: 18), const SizedBox(width: 8), Text(label)],
          ),
        ),
      ),
    );
  }
}
