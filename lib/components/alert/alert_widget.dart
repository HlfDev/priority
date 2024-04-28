import 'package:flutter/material.dart';

import 'alert.dart';

const kAlertHeight = 80.0;

class Alert extends StatelessWidget {
  const Alert({
    super.key,
    required this.backgroundColor,
    required this.child,
    required this.leading,
    required this.priority,
  });

  final Color backgroundColor;
  final Widget child;
  final Widget leading;
  final AlertPriority priority;

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Material(
      child: Ink(
        color: backgroundColor,
        height: kAlertHeight + statusBarHeight,
        child: Column(
          children: [
            SizedBox(
              height: statusBarHeight,
            ),
            Expanded(
              child: Row(
                children: [
                  const SizedBox(
                    width: 28.0,
                  ),
                  IconTheme(
                    data: const IconThemeData(
                      color: Colors.white,
                      size: 36,
                    ),
                    child: leading,
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 28.0,
            ),
          ],
        ),
      ),
    );
  }
}
