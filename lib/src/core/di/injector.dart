import 'package:get_it/get_it.dart';

import '../../modules/home/presentation/view_model/home_view_model.dart';

void setupInjector() {
  final GetIt getIt = GetIt.instance;

  ///
  /// Home View Model
  ///
  getIt.registerFactory<HomeViewModel>(() => HomeViewModel());
}
