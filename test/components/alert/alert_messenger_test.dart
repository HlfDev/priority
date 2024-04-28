import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:priority/components/alert/alert.dart';

const alertWarning = Alert(
  backgroundColor: Colors.amber,
  leading: Icon(Icons.warning),
  priority: AlertPriority.warning,
  child: Text(
    'Atenção! Você foi avisado.',
  ),
);

const alertError = Alert(
  backgroundColor: Colors.red,
  leading: Icon(Icons.error),
  priority: AlertPriority.error,
  child: Text(
    'Oops, ocorreu um erro. Pedimos desculpas.',
  ),
);

const alertInfo = Alert(
  backgroundColor: Colors.green,
  leading: Icon(Icons.info),
  priority: AlertPriority.info,
  child: Text(
    'Este é um aplicativo escrito em Flutter.',
  ),
);

void main() {
  testWidgets('Test if {AlertMessenger} has all interactions', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AlertMessenger(
          child: Container(),
        ),
      ),
    );

    final Finder findContextByWidget = find.byType(Container);
    final BuildContext context = tester.element(findContextByWidget);

    AlertMessengerController controller = AlertMessenger.of(
      context,
    );

    controller.showAlert(alert: alertWarning);
    await tester.pumpAndSettle();
    controller.showAlert(alert: alertWarning);
    await tester.pumpAndSettle();

    expect(
      find.text('Atenção! Você foi avisado.').hitTestable(),
      findsOneWidget,
    );

    controller.showAlert(
      alert: alertError,
    );

    await tester.pumpAndSettle();

    expect(
      find.text('Oops, ocorreu um erro. Pedimos desculpas.').hitTestable(),
      findsOneWidget,
    );
    expect(
      find.text('Atenção! Você foi avisado.').hitTestable(),
      findsNothing,
    );

    controller.showAlert(
      alert: alertInfo,
    );

    await tester.pumpAndSettle();

    expect(
      find.text('Oops, ocorreu um erro. Pedimos desculpas.').hitTestable(),
      findsOneWidget,
    );
    expect(
      find.text('Atenção! Você foi avisado.').hitTestable(),
      findsNothing,
    );
    expect(
      find.text('Este é um aplicativo escrito em Flutter.').hitTestable(),
      findsNothing,
    );

    controller.hideAlert();
    await tester.pumpAndSettle();

    expect(
      find.text('Atenção! Você foi avisado.').hitTestable(),
      findsOneWidget,
    );
    expect(
      find.text('Este é um aplicativo escrito em Flutter.').hitTestable(),
      findsNothing,
    );
  });
}
