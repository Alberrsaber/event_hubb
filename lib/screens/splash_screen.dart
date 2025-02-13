import 'package:event_booking_app_ui/screens/signin_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

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

    // Initialize animation controller for fade effect
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    // Start fade-in animation
    _animationController.forward();

    // Listen for animation completion
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Navigate to SignInScreen after animation completes
        if (mounted) {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Image(image: AssetImage('assets/images/top_right_shade.png')),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage('assets/images/logo.png')),
                  SizedBox(width: 8),
                  Image(image: AssetImage('assets/images/vent_hub_label.png')),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Image(image: AssetImage('assets/images/bottom_left_shade.png')),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Image(image: AssetImage('assets/images/bottom_right_shade.png')),
            ),
          ],
        ),
      ),
    );
  }
}