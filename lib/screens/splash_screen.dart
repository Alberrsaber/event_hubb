import 'package:event_booking_app_ui/controllers/auth_controller.dart';
import 'package:event_booking_app_ui/screens/home_screen.dart';
import 'package:event_booking_app_ui/screens/Auth/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;


  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.forward();

    _animationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        bool isRemembered = await AuthController().isRemembered();
        bool isLoggedIn = await AuthController().isLoggedIn();

        Widget nextScreen =
            (isRemembered && isLoggedIn) ? HomeScreen() : const SignInScreen();

        if (mounted) {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  nextScreen,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _animation,
        child: const Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child:
                  Image(image: AssetImage('assets/images/top_right_shade.png')),
            ),
            Center(
              child: Directionality(
                    textDirection: TextDirection.ltr, // <-- Force LTR layout
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('assets/images/logo.png')),
                    SizedBox(width: 8),
                    Image(image: AssetImage('assets/images/vent_hub_label.png')),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Image(
                  image: AssetImage('assets/images/bottom_left_shade.png')),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Image(
                  image: AssetImage('assets/images/bottom_right_shade.png')),
            ),
          ],
        ),
      ),
    );
  }
}
