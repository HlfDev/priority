import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:priority/components/alert/alert.dart';

void main() {
  testWidgets('Test if {Alert} has all required elements', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Alert(
            backgroundColor: Colors.amber,
            leading: Icon(Icons.warning),
            priority: AlertPriority.warning,
            child: Text(
              'Atenção! Você foi avisado.',
            ),
          ),
        ),
      ),
    );

    expect(find.text('Atenção! Você foi avisado.'), findsOneWidget);
    expect(find.byType(Alert), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
    expect(find.byIcon(Icons.warning), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
  });
}
