import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health_insurance_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Welcome to Health Insurance App'), findsOneWidget);
    expect(find.byIcon(Icons.medical_services), findsOneWidget);
  });
}
