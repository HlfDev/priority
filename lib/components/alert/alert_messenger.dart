import 'package:flutter/material.dart';

import 'alert.dart';

class AlertMessenger extends StatefulWidget {
  const AlertMessenger({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<AlertMessenger> createState() => AlertMessengerState();

  static AlertMessengerController of(BuildContext context) {
    try {
      final controller = _AlertMessengerScope.of(context).controller;
      return controller;
    } catch (error) {
      throw FlutterError.fromParts(
        [
          ErrorSummary(
            'No AlertMessenger was found in the Element tree',
          ),
          ErrorDescription(
            'AlertMessenger is required in order to show and hide alerts.',
          ),
          ...context.describeMissingAncestor(
              expectedAncestorType: AlertMessenger),
        ],
      );
    }
  }
}

class AlertMessengerState extends State<AlertMessenger>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;
  late final AlertMessengerController controller;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    controller = AlertMessengerController(
      animationController: animationController,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final alertHeight = MediaQuery.paddingOf(context).top + kAlertHeight;

    animation = Tween<double>(begin: -alertHeight, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.paddingOf(context).top;

    return ValueListenableBuilder<List<Alert>>(
        valueListenable: controller,
        builder: (context, alerts, __) {
          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              final position = animation.value + kAlertHeight;
              return Stack(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                children: [
                  Positioned.fill(
                    top: position <= statusBarHeight
                        ? 0
                        : position - statusBarHeight,
                    child: _AlertMessengerScope(
                      controller: controller,
                      child: widget.child,
                    ),
                  ),
                  Positioned(
                    top: animation.value,
                    left: 0,
                    right: 0,
                    child: alerts.isNotEmpty
                        ? alerts.first
                        : const SizedBox.shrink(),
                  ),
                ],
              );
            },
          );
        });
  }
}

class _AlertMessengerScope extends InheritedWidget {
  const _AlertMessengerScope({
    required this.controller,
    required super.child,
  });

  final AlertMessengerController controller;

  @override
  bool updateShouldNotify(_AlertMessengerScope oldWidget) => true;

  static _AlertMessengerScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_AlertMessengerScope>();
  }

  static _AlertMessengerScope of(BuildContext context) {
    final scope = maybeOf(context);
    assert(scope != null, 'No _AlertMessengerScope found in context');
    return scope!;
  }
}
