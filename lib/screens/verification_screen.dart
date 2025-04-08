import 'dart:async';
import 'package:event_booking_app_ui/controllers/auth_controller.dart';
import 'package:event_booking_app_ui/my_theme.dart';
import 'package:event_booking_app_ui/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  int _secondsRemaining = 60;
  late Timer _timer;
  bool _isResendEnabled = false;
  final email = FirebaseAuth.instance.currentUser!.email;
  final controller = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining = 60;
      _isResendEnabled = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _isResendEnabled = true;
        });
        _timer.cancel();
      }
    });
  }

  void _resendCode() {
    if (_isResendEnabled) {
      _startTimer();
      controller.SendEmailVerfication();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Images
          ..._buildBackgroundImages(),
          // Main Content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, size: 28),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Verification',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: MyTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "We’ve sent you a verification email. Please check this email:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    email!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: MyTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildResendButton(),
                  const SizedBox(height: 24),
                  const Center(
                    child: Text(
                      'OR',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildSignUpOption(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildBackgroundImages() {
    return [
      Align(
        alignment: Alignment.topLeft,
        child: Image.asset('assets/backgrounds/signin_top_left.png'),
      ),
      Align(
        alignment: Alignment.topRight,
        child: Image.asset('assets/backgrounds/signin_top_right.png'),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: Image.asset('assets/backgrounds/signin_center_right.png'),
      ),
      Align(
        alignment: Alignment.bottomLeft,
        child: Image.asset('assets/backgrounds/signin_bottom_left.png'),
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: Image.asset('assets/backgrounds/signin_bottom_right.png'),
      ),
    ];
  }

  Widget _buildResendButton() {
    return Center(
      child: Column(
        children: [
          Text(
            'Re-send email in:',
            style: TextStyle(fontSize: 18, color: Colors.grey[700]),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _isResendEnabled ? _resendCode : null,
            child: Text(
              _isResendEnabled ? 'Resend Code' : '$_secondsRemaining sec',
              style: TextStyle(
                fontSize: 20,
                color: _isResendEnabled ? MyTheme.primaryColor : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpOption() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Sign up with correct email",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()),
              );
            },
            child: const Text(
              "Sign up",
              style: TextStyle(
                color: MyTheme.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}