import 'package:flutter/cupertino.dart';

import 'alert.dart';

class AlertMessengerController extends ValueNotifier<List<Alert>> {
  final AnimationController _animationController;

  AlertMessengerController({
    required AnimationController animationController,
  })  : _animationController = animationController,
        super([]);

  void showAlert({
    required Alert alert,
  }) {
    if (value.isEmpty) {
      value = [alert];
      _animationController.forward();
      return;
    }

    if (value.contains(alert)) return;

    if (value.first.priority.value > alert.priority.value) {
      _addAlert(alert);
    } else {
      _animationController.reverse().whenComplete(() {
        _addAlert(alert);
        _animationController.forward();
      });
    }
  }

  void _addAlert(Alert alert) {
    value.add(alert);
    value.sort((a, b) => b.priority.value.compareTo(
          a.priority.value,
        ));

    notifyListeners();
  }

  void hideAlert() {
    if (value.isEmpty) return;

    _animationController.reverse().whenComplete(() {
      value.removeAt(0);
      notifyListeners();

      if (value.isNotEmpty) {
        _animationController.forward();
      }
    });
  }

  String getTextFromDisplayedAlert() {
    if (value.isEmpty) return "";

    if (value.first.child is Text) {
      return (value.first.child as Text).data ?? "";
    }

    return "";
  }
}
