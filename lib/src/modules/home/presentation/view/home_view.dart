import 'package:flutter/material.dart';
import 'package:idez_test/src/modules/home/presentation/view_model/home_view_model.dart';

class HomeView extends StatelessWidget {
  final HomeViewModel viewModel;
  const HomeView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(child: Text('Welcome to the Home View!')),
    );
  }
}
