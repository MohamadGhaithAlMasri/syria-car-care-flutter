import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syria_car_care2/features/services/presentation/pages/washing_report_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('WashingReportScreen should render correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: WashingReportScreen()));

    expect(find.byIcon(Icons.check_circle), findsOneWidget);

    expect(find.byType(SingleChildScrollView), findsOneWidget);

    expect(find.byType(ElevatedButton), findsOneWidget);

    expect(find.byIcon(Icons.close), findsOneWidget);
  });
}
