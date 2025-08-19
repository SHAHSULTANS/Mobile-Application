import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:xylophone_flutter/main.dart';

void main() {
  testWidgets('Play Note 1 button exists and can be tapped', (
    WidgetTester tester,
  ) async {
    // Build our app
    await tester.pumpWidget(XylophoneApp());

    // Verify that the button exists
    expect(find.text('Play Note 1'), findsOneWidget);

    // Tap the button
    await tester.tap(find.text('Play Note 1'));
    await tester.pump();

    // You can add more checks if needed
  });
}
