// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TaskViewModel on _TaskViewModelBase, Store {
  late final _$stateAtom = Atom(
    name: '_TaskViewModelBase.state',
    context: context,
  );

  @override
  ViewModelState<Failure, void> get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ViewModelState<Failure, void> value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$createTaskAsyncAction = AsyncAction(
    '_TaskViewModelBase.createTask',
    context: context,
  );

  @override
  Future<void> createTask() {
    return _$createTaskAsyncAction.run(() => super.createTask());
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
