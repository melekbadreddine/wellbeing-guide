// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:CareCompanion/main.dart';

void main() {
  testWidgets('Your Widget Test', (WidgetTester tester) async {
    // Build your app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify the initial state of your widget.
    expect(find.text('Initial Text'), findsOneWidget);
    expect(find.text('Updated Text'), findsNothing);

    // Trigger an interaction, such as tapping a button, and trigger a frame.
    await tester.tap(find.byKey(const Key('your_button_key')));
    await tester.pump();

    // Verify the updated state of your widget.
    expect(find.text('Initial Text'), findsNothing);
    expect(find.text('Updated Text'), findsOneWidget);
  });
}
