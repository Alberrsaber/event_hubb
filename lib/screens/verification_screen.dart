import 'dart:async';
import 'package:event_booking_app_ui/controllers/auth_controller.dart';
import 'package:event_booking_app_ui/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class VerificationScreen extends StatefulWidget {
  final String email;

  const VerificationScreen({
    super.key,
    required this.email,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  int _secondsRemaining = 60;
  late Timer _timer;
  bool _isResendEnabled = false;
  var controller = Get.put(AuthController());

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
      // TODO: Implement resend code logic
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
          LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 54),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Verification',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                            'We’ve sent you a verification code to your email:'),
                        Text(
                          widget.email,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(4, (index) {
                              return SizedBox(
                                width: 50,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700),
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                    counterText: '',
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                    hintText: '_',
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 34),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 66),
                          child: InkWell(
                            onTap: () {
                              // Handle verification submission
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: MyTheme.primaryColor,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'CONTINUE',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Image.asset('assets/icons/right_arrow.png'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 26),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Re-send code in ',
                              style:
                                  TextStyle(fontSize: 18, color: MyTheme.grey),
                            ),
                            GestureDetector(
                              onTap: _isResendEnabled ? _resendCode : null,
                              child: Text(
                                _isResendEnabled
                                    ? 'Resend Code'
                                    : '$_secondsRemaining sec',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: _isResendEnabled
                                      ? MyTheme.primaryColor
                                      : MyTheme.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
