import 'package:CareCompanion/patient/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:CareCompanion/main.dart';

void main() {
  testWidgets('App initializes and shows loading screen', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(MyApp());

    // Verify that the loading screen is displayed
    expect(find.byType(LoadingScreen), findsOneWidget);
  });

  test('Check if isFirstLaunch returns the correct value', () async {
    // Create an instance of the MyApp class
    final myApp = MyApp();

    // Call the isFirstLaunch method and check the return value
    expect(await myApp.isFirstLaunch(), isA<bool>());
  });

  testWidgets('App displays username on the app bar', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(MyApp());

    // Get the SharedPreferences instance
    SharedPreferences.setMockInitialValues({'isFirstLaunch': false});
    final sharedPrefs = await SharedPreferences.getInstance();

    // Set a dummy username in SharedPreferences
    await sharedPrefs.setString('username', 'John Doe');

    // Rebuild the app
    await tester.pumpWidget(MyApp());

    // Verify that the username is displayed on the app bar
    expect(find.text('John Doe'), findsOneWidget);
  });

  testWidgets('App navigates to the settings screen when the notification icon is pressed', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(MyApp());

    // Verify that the notification icon is displayed
    expect(find.byIcon(Icons.notifications_none_outlined), findsOneWidget);

    // Tap the notification icon
    await tester.tap(find.byIcon(Icons.notifications_none_outlined));
    await tester.pumpAndSettle();

    // Verify that the settings screen is displayed
    expect(find.text('Settings'), findsOneWidget);
  });
  
  testWidgets('App navigates to the home page when the home icon is pressed', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(MyApp());

    // Verify that the home icon is displayed
    expect(find.byIcon(Icons.home_outlined), findsOneWidget);

    // Tap the home icon
    await tester.tap(find.byIcon(Icons.home_outlined));
    await tester.pumpAndSettle();

    // Verify that the home page is displayed
    expect(find.text('Home'), findsOneWidget);
  });
  
  // Add more tests for other features and functionalities of your app
}