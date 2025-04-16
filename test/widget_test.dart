import 'package:event_booking_app_ui/main.dart';
import 'package:event_booking_app_ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  testWidgets('SplashScreen is displayed first', (WidgetTester tester) async {
    // Setup ThemeController
    final themeController = ThemeController();

    // بناء التطبيق مع ThemeController
    await tester.pumpWidget(MyApp(themeController: themeController));

    // انتظار تنفيذ أي animations أو async operations
    await tester.pump(); 

    // تحقق من أن SplashScreen موجود في واجهة المستخدم
    expect(find.byType(SplashScreen), findsOneWidget);
  });
}
