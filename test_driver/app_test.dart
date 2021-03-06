// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Counter App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final counterTextFinder = find.byValueKey('counter');
    final buttonFinder = find.byValueKey('increment');
    final staticText = find.byValueKey('static_text');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('starts at 0', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      expect(await driver.getText(counterTextFinder), "0");
      expect(await driver.getText(staticText), 'You have pushed the button this many times:');

    });

    test('increments the counter', () async {
      // First, tap the button.
      await driver.tap(buttonFinder);

      // Then, verify the counter text is incremented by 1.
      expect(await driver.getText(counterTextFinder), "1");
      expect(await driver.getText(staticText), 'You have pushed the button this many times:');

    });

    test('Answer to all is 42', () async {
      for (var i = 1; i <= 41; i++) {
        await driver.tap(buttonFinder);
      }

      expect(await driver.getText(counterTextFinder), '42');
      expect(await driver.getText(staticText), 'You have pushed the button this many times:');

    });

    test('Static text', () async {
      expect(await driver.getText(staticText), 'You have pushed the button this many times:');

    });

  });
}