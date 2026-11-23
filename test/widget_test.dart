import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finpilot_money_manager/main.dart';

void main() {
  testWidgets('Smoke test: Starter App renders starter gallery', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const FinPilotStarterApp());
    await tester.pumpAndSettle();

    expect(find.text('FinPilot Starter (5 Screens)'), findsOneWidget);
    expect(find.text('Welcome & Trust Auth'), findsOneWidget);
  });
}
