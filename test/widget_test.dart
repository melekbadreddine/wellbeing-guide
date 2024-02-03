import 'package:CareCompanion/screens/loading_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:CareCompanion/main.dart';

void main() {
  setUpAll(() async {
    // Initialize Firebase and SharedPreferences once for all tests
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await SharedPreferences.getInstance();
  });

  group('Main App Tests', () {
    testWidgets('Firebase initializes correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      expect(await Firebase.initializeApp(), isA<FirebaseApp>());
    });

    testWidgets('App initializes loading screen', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.byType(LoadingScreen), findsOneWidget);
    });

    testWidgets('First launch check works correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Verify that the isFirstLaunch method returns a boolean.
      bool? isFirstLaunch = await tester.runAsync(() async {
        return MyApp().isFirstLaunch();
      });

      expect(isFirstLaunch, isA<bool>());
    });
  });
}
