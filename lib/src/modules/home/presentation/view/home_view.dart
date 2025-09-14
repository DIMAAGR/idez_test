import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:idez_test/src/core/theme/app_theme.dart';
import 'package:idez_test/src/modules/home/presentation/view/tabs/home_tab.dart';
import 'package:idez_test/src/modules/home/presentation/widgets/fab_menu.dart';

import '../models/pill_tab_enum.dart';
import '../view_model/home_view_model.dart';
import '../widgets/bottom_pill_nav.dart';
import 'tabs/done_tab.dart';

class HomeView extends StatelessWidget {
  final HomeViewModel viewModel;
  const HomeView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: Observer(
          builder: (context) {
            return viewModel.isSelectionMode
                ? AppBar(
                    leading: IconButton(
                      icon: Icon(Icons.close, color: AppTheme.colors.black),
                      onPressed: () => viewModel.clearSelection(),
                    ),
                    titleSpacing: 0,
                    title: Text(
                      '${viewModel.selectedCount} selecionada(s)',
                      style: AppTheme.textStyles.body1Regular,
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.delete, color: AppTheme.colors.red),
                        onPressed: () => viewModel.deleteSelectedTasks(),
                      ),
                    ],
                  )
                : SizedBox(height: 40);
          },
        ),
      ),
      body: Observer(
        builder: (context) {
          return viewModel.currentTab == PillTab.home
              ? HomeTab(viewModel: viewModel)
              : DoneTab(viewModel: viewModel);
        },
      ),
      floatingActionButton: FabMenu(onNewTask: () {}, onNewCategory: () {}),
      bottomNavigationBar: Observer(
        builder: (context) {
          return BottomPillNav(
            current: viewModel.currentTab,
            onChanged: (tab) {
              viewModel.currentTab = tab;
            },
          );
        },
      ),
    );
  }
}
