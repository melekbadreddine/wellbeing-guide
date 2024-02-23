import 'package:CareCompanion/patient/loading_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:CareCompanion/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('MyApp widget tests', () {
    test('isFirstLaunch returns true for first launch and false for subsequent launches', () async {
      // Test for first launch
      SharedPreferences.setMockInitialValues({'isFirstLaunch': true});
      var isFirstLaunch = await MyApp().isFirstLaunch();
      expect(isFirstLaunch, true);

      // Test for subsequent launches
      SharedPreferences.setMockInitialValues({'isFirstLaunch': false});
      isFirstLaunch = await MyApp().isFirstLaunch();
      expect(isFirstLaunch, false);
    });

    testWidgets('MyApp initializes Firebase successfully', (WidgetTester tester) async {
      await tester.runAsync(() async {
        // Build the widget tree
        await tester.pumpWidget(const MyApp());

        // Expect Firebase to be initialized successfully
        expect(Firebase.apps.isNotEmpty, true);
      });
    });

    testWidgets('MyApp displays LoadingScreen widget on first launch', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({'isFirstLaunch': true});

      await tester.runAsync(() async {
        // Build the widget tree
        await tester.pumpWidget(const MyApp());

        // Expect to find LoadingScreen widget
        expect(find.byType(LoadingScreen), findsOneWidget);
      });
    });
  });
}
