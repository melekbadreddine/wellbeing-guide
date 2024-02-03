import 'package:CareCompanion/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:CareCompanion/main.dart';

void main() {
  testWidgets('App initializes correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the initial loading screen is displayed.
    expect(find.byType(LoadingScreen), findsOneWidget);

    // You can add more assertions based on your app's behavior
    // For example, you can check if Firebase is initialized successfully.

    // Verify that the app initializes Firebase.
    expect(await Firebase.initializeApp(), isA<FirebaseApp>());

    // Verify that shared preferences are working.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    expect(prefs, isNotNull);
  });

  testWidgets('First launch check works correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the isFirstLaunch method returns a boolean.
    bool? isFirstLaunch = await tester.runAsync(() async {
      return MyApp().isFirstLaunch();
    });
    
    expect(isFirstLaunch, isA<bool>());
  });
}
