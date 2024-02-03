// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:CareCompanion/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Login test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that there is a widget with the expected text.
    expect(find.text('Se Connecter'), findsOneWidget);

    // Enter login credentials.
    await tester.enterText(find.byType(TextFormField).first, 'mbadreddine5@gmail.com');
    await tester.enterText(find.byType(TextFormField).last, 'password');

    // Tap the login button and trigger a frame.
    await tester.tap(find.widgetWithText(MaterialButton, 'Se Connecter'));
    await tester.pump();

    // Verify that the widget with the expected text is gone (logged in state).
    expect(find.text('Se Connecter'), findsNothing);
  });
}
