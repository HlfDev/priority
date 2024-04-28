import 'package:flutter_test/flutter_test.dart';
import 'package:priority/components/alert/alert.dart';

void main() {
  group("When {AlertPriority} is created", () {
    test("should {AlertPriority.error.value} return {2}", () {
      const alert = AlertPriority.error;
      expect(alert.value, 2);
    });

    test("should {AlertPriority.warning.value} return {1}", () {
      const alert = AlertPriority.warning;
      expect(alert.value, 1);
    });

    test("should {AlertPriority.info.value} return {0}", () {
      const alert = AlertPriority.info;
      expect(alert.value, 0);
    });
  });

  group(
    "When {AlertPriority} is used in a {List}",
    () {
      test(
          "The lowest priority (Last Index) after a sort within a {List<AlertPriority>} should be {AlertPriority.info}",
          () {
        List<AlertPriority> alerts = [
          AlertPriority.warning,
          AlertPriority.info,
          AlertPriority.error,
        ];

        alerts.sort((a, b) => b.value.compareTo(
              a.value,
            ));

        expect(alerts.last, AlertPriority.info);
        expect(alerts.last.value, 0);
      });

      test(
          "the highest priority (First Index) after a sort within a {List<AlertPriority>} should be {AlertPriority.error}",
          () {
        List<AlertPriority> alerts = [
          AlertPriority.error,
          AlertPriority.info,
          AlertPriority.warning,
        ];

        alerts.sort((a, b) => b.value.compareTo(
              a.value,
            ));

        expect(alerts.first, AlertPriority.error);
        expect(alerts.first.value, 2);
      });
    },
  );
}
