import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:priority/components/alert/alert.dart';

class _MockTickerProvider extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}

void main() {
  late AlertMessengerController controller;
  late AnimationController animationController;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    animationController = AnimationController(
      vsync: _MockTickerProvider(),
      duration: const Duration(milliseconds: 300),
    );

    controller = AlertMessengerController(
      animationController: animationController,
    );
  });

  tearDown(() {
    controller.dispose();
    animationController.dispose();
  });

  group('When {AlertMessengerController} is called', () {
    test(
      'Should update {List<Alert>} with new {Alert} after {showAlert} function is called',
      () {
        const alert = Alert(
          backgroundColor: Colors.red,
          leading: Icon(Icons.error),
          priority: AlertPriority.error,
          child: SizedBox.shrink(),
        );

        controller.showAlert(alert: alert);

        expect(controller.value.length, 1);
        expect(controller.value.first, alert);
      },
    );

    test(
      'Should not add {Alert} if it has the same {Alert} in the {List<Alert>}',
      () {
        const alert = Alert(
          backgroundColor: Colors.red,
          leading: Icon(Icons.error),
          priority: AlertPriority.error,
          child: SizedBox.shrink(),
        );

        controller.showAlert(alert: alert);
        controller.showAlert(alert: alert);

        expect(controller.value.length, 1);
        expect(controller.value.first, alert);
      },
    );

    testWidgets(
      'Should update {List<Alert>} with new two {Alert} after {showAlert} function is called',
      (
        WidgetTester tester,
      ) async {
        const alertOne = Alert(
          backgroundColor: Colors.red,
          leading: Icon(Icons.error),
          priority: AlertPriority.error,
          child: SizedBox.shrink(),
        );

        const alertTwo = Alert(
          backgroundColor: Colors.amber,
          leading: Icon(Icons.warning),
          priority: AlertPriority.warning,
          child: SizedBox.shrink(),
        );

        controller.showAlert(alert: alertOne);
        await tester.pump(const Duration(milliseconds: 500));
        controller.showAlert(alert: alertTwo);
        await tester.pump(const Duration(milliseconds: 500));

        expect(controller.value.length, 2);
        expect(controller.value.first, alertOne);
        expect(controller.value.last, alertTwo);
      },
    );

    testWidgets(
      'Should remove {Alert} from {List<Alert>} after {hideAlert} function is called',
      (
        WidgetTester tester,
      ) async {
        const alert = Alert(
          backgroundColor: Colors.red,
          leading: Icon(Icons.error),
          priority: AlertPriority.error,
          child: SizedBox.shrink(),
        );

        controller.showAlert(alert: alert);

        expect(controller.value.length, 1);
        expect(controller.value.first, alert);

        controller.hideAlert();
        await tester.pump(const Duration(milliseconds: 500));

        expect(controller.value.length, 0);
        expect(controller.value.isEmpty, true);
      },
    );

    test(
      'Should get {Text} From Displayed {Alert}',
      () {
        const String textValue = 'Test';

        const alert = Alert(
          backgroundColor: Colors.red,
          leading: Icon(Icons.error),
          priority: AlertPriority.error,
          child: Text(textValue),
        );

        controller.showAlert(alert: alert);

        expect(controller.getTextFromDisplayedAlert(), 'Test');
      },
    );
  });
}
