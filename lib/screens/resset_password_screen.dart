import 'package:event_booking_app_ui/controllers/auth_controller.dart';
import 'package:event_booking_app_ui/my_theme.dart';
import 'package:event_booking_app_ui/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'verification_screen.dart'; // Import the VerificationScreen

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _validateEmail(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email);
  }

  void _sendResetLink() {
    if (_formKey.currentState!.validate()) {
      AuthController().resetPassword(_emailController.text,context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignInScreen()
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Images
          Align(
              alignment: Alignment.topLeft,
              child: Image.asset('assets/backgrounds/signin_top_left.png')),
          Align(
              alignment: Alignment.topRight,
              child: Image.asset('assets/backgrounds/signin_top_right.png')),
          Align(
              alignment: Alignment.centerRight,
              child: Image.asset('assets/backgrounds/signin_center_right.png')),
          Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset('assets/backgrounds/signin_bottom_left.png')),
          Align(
              alignment: Alignment.bottomRight,
              child: Image.asset('assets/backgrounds/signin_bottom_right.png')),

          LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: viewportConstraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 54),

                          // Back Button
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context),
                          ),

                          const SizedBox(height: 16),

                          // Title
                          const Text(
                            'Reset Password',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w500),
                          ),

                          const SizedBox(height: 16),

                          // Instruction Text
                          const Text(
                            'Please enter your email address to request a password reset.',
                            style: TextStyle(fontSize: 16),
                          ),

                          const SizedBox(height: 24),

                          // Email Input
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              hintText: 'abc@email.com',
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Image.asset('assets/icons/mail.png'),
                              ),
                            ),
                            validator: (value) {
                              return AuthController().validateEmail(value);
                            },
                          ),

                          const SizedBox(height: 34),

                          // Send Button
                          Center(
                            child: GestureDetector(
                              onTap: _sendResetLink,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: MyTheme.primaryColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(18)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'SEND',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: MyTheme.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Image.asset('assets/icons/right_arrow.png'),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 26),
                        ],
                      ),
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
