import 'package:flutter/material.dart';

mixin PendingDeletionMixin<T extends StatefulWidget> on State<T> {
  List<String> _pendingDeleteIds = const [];
  bool _pendingActive = false;
  bool _pendingUndone = false;
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? _snackCtrl;

  Future<void> showPendingDeletion({
    required BuildContext context,
    required Iterable<String> ids,
    required String message,
    required VoidCallback restore,
    required Future<void> Function(Iterable<String>) commit,
    Duration duration = const Duration(seconds: 4),
    String undoLabel = 'Desfazer',
  }) async {
    await commitPendingIfAny(commit);

    _pendingDeleteIds = ids.toList(growable: false);
    _pendingActive = true;
    _pendingUndone = false;

    _snackCtrl = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: undoLabel,
          onPressed: () {
            _pendingUndone = true;
            _pendingActive = false;
            restore();
          },
        ),
        duration: duration,
      ),
    );

    _snackCtrl!.closed.then((_) async {
      if (_pendingActive && !_pendingUndone) {
        await commit(_pendingDeleteIds);
      }
      _resetPending();
    });
  }

  Future<void> commitPendingIfAny(Future<void> Function(Iterable<String>) commit) async {
    if (_pendingActive && !_pendingUndone) {
      _snackCtrl?.close();
      await commit(_pendingDeleteIds);
      _resetPending();
    } else {
      _resetPending();
    }
  }

  void cancelPending() {
    _snackCtrl?.close();
    _resetPending();
  }

  void _resetPending() {
    _pendingActive = false;
    _pendingUndone = false;
    _pendingDeleteIds = const [];
    _snackCtrl = null;
  }
}
