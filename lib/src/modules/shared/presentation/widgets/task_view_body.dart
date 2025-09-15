import 'package:flutter/material.dart';

class TaskViewBody extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final EdgeInsets? padding;
  final bool hasScrollableChild;

  const TaskViewBody({
    super.key,
    required this.children,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.padding,
    this.hasScrollableChild = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (hasScrollableChild) {
            return Padding(
              padding: padding ?? EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
                mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
                children: children,
              ),
            );
          }

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: padding ?? EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
                  mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceAround,
                  children: children,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
