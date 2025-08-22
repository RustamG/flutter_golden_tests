import 'package:flutter_test/flutter_test.dart';
import 'package:golden_tests/main.dart';
import 'package:integration_test/integration_test.dart';

const kGoldensFolder = 'goldens';

void main() {
  testWidgets('Counter smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.pumpAndSettle(const Duration(seconds: 10));

    await compareScreenshot(kGoldensFolder, 'failing_counter');
  });
}

Future<void> compareScreenshot(String goldensFolder, String key) async {
  List<int> screenshotBytes =
      await IntegrationTestWidgetsFlutterBinding.ensureInitialized()
          .takeScreenshot(key);

  await expectLater(
    screenshotBytes,
    matchesGoldenFile('$goldensFolder/$key.png'),
  );
}
