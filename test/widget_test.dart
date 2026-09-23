// Stack: Flutter 3.47 | File: test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_web_on_back4app/main.dart';

void main() {
  testWidgets('counter starts at zero and increments on tap', (tester) async {
    await tester.pumpWidget(const CupCounterApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byType(FilledButton));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('the build stamp is rendered', (tester) async {
    await tester.pumpWidget(const CupCounterApp());
    expect(find.textContaining('Build:'), findsOneWidget);
  });
}
