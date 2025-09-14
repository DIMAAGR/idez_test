import 'package:flutter/material.dart';

class TaskViewBody extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final EdgeInsets? padding;
  const TaskViewBody({
    super.key,
    required this.children,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: padding ?? EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
                    mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceAround,
                    children: children,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
