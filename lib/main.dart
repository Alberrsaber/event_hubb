import 'package:event_booking_app_ui/controllers/notifications_controller.dart';
import 'package:event_booking_app_ui/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/splash_screen.dart';
import 'screens/Auth/signin_screen.dart';
import './screens/home_screen.dart';
import './my_theme.dart';

// 🌍 Add localization imports
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

// Define the Theme Controller with language and notification toggle
class ThemeController extends GetxController {
  var isDarkMode = false.obs;
  var selectedLanguage = 'en'.obs;
  var isNotificationsEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    _saveBool('isDarkMode', isDarkMode.value);
  }

  void setLanguage(String langCode) {
    selectedLanguage.value = langCode;
    Get.updateLocale(Locale(langCode));
    _saveString('language', langCode);
  }

  void toggleNotifications(bool value) {
    isNotificationsEnabled.value = value;
    _saveBool('notifications_enabled', value);
  }

  void _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
    isNotificationsEnabled.value = prefs.getBool('notifications_enabled') ?? true;
    selectedLanguage.value = prefs.getString('language') ?? 'en';

    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    Get.updateLocale(Locale(selectedLanguage.value));
  }

  Future<void> _saveBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> _saveString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationsController().initialize();

  final ThemeController themeController = Get.put(ThemeController());

  // ننتظر تحميل الإعدادات قبل تشغيل التطبيق
  await Future.delayed(Duration(milliseconds: 500));

  runApp(MyApp(themeController: themeController));
}

class MyApp extends StatefulWidget {
  final ThemeController themeController;

  const MyApp({super.key, required this.themeController});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        title: 'Event Booking App',
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        themeMode: widget.themeController.isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        locale: Locale(widget.themeController.selectedLanguage.value),

        // 🌍 Add localization support
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,

        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => SignInScreen(),
          '/home': (context) => HomeScreen(),
        },
      );
    });
  }
}
