import 'package:event_booking_app_ui/main.dart';
import 'package:event_booking_app_ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:event_booking_app_ui/main.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(themeController: Get.put(ThemeController())));

    // بناء التطبيق مع ThemeController
    await tester.pumpWidget(MyApp(themeController: Get.put(ThemeController())));

    // انتظار تنفيذ أي animations أو async operations
    await tester.pump(); 

    // تحقق من أن SplashScreen موجود في واجهة المستخدم
    expect(find.byType(SplashScreen), findsOneWidget);
  });
}
