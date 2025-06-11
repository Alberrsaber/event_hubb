import 'package:event_booking_app_ui/controllers/auth_controller.dart';
import 'package:event_booking_app_ui/my_theme.dart';
import 'package:event_booking_app_ui/screens/Auth/resset_password_screen.dart';
import 'package:event_booking_app_ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:event_booking_app_ui/screens/Auth/signup_screen.dart';
import 'package:get/get.dart';
import 'package:event_booking_app_ui/generated/l10n.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _checkRememberedUser();
  }

  Future<void> _checkRememberedUser() async {
    bool remembered = await AuthController().isRemembered();
    if (remembered && await AuthController().isLoggedIn()) {
      Get.offAll(() => const HomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background Images
          const Align(
            alignment: Alignment.topLeft,
            child: Image(
              image: AssetImage('assets/backgrounds/signin_top_left.png'),
            ),
          ),
          const Align(
            alignment: Alignment.topRight,
            child: Image(
              image: AssetImage('assets/backgrounds/signin_top_right.png'),
            ),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: Image(
              image: AssetImage('assets/backgrounds/signin_center_right.png'),
            ),
          ),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Image(
              image: AssetImage('assets/backgrounds/signin_bottom_left.png'),
            ),
          ),
          const Align(
            alignment: Alignment.bottomRight,
            child: Image(
              image: AssetImage('assets/backgrounds/signin_bottom_right.png'),
            ),
          ),

          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 54),
                          const Center(
                            child: Image(
                              image: AssetImage('assets/images/logo.png'),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: Text(
                              l10n.app_name,
                              style: const TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            l10n.sign_in,
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 12),

                          // Email Field
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(12),
                                child: Image(
                                  image: AssetImage('assets/icons/mail.png'),
                                ),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              hintText: l10n.email_hint,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return l10n.email_required;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),

                          // Password Field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(12),
                                child: Image(
                                  image: AssetImage('assets/icons/locked.png'),
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              hintText: l10n.password_hint,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return l10n.password_required;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),

                          // Remember Me & Forgot Password
                          Row(
                            children: [
                              Switch(
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value;
                                  });
                                },
                              ),
                              Text(l10n.remember_me),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ResetPasswordScreen(),
                                    ),
                                  );
                                },
                                child: Text(l10n.forgot_password),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Sign In Button
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                AuthController().SignIn(
                                  _emailController.text,
                                  _passwordController.text,
                                  _rememberMe,
                                  context,
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: MyTheme.primaryColor,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Center(
                                child: Text(
                                  l10n.sign_in.toUpperCase(),
                                  style: TextStyle(
                                      color: MyTheme.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 26),

                          // OR Divider
                          Center(
                            child: Text(
                              l10n.or,
                              style: TextStyle(fontSize: 18, color: MyTheme.grey),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Social Login Buttons
                          Center(
                            child: Column(
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    AuthController().signInWithGoogle(context);
                                  },
                                  icon: Image.asset(
                                    'assets/icons/google.png',
                                    width: 24,
                                  ),
                                  label: Text(l10n.login_with_google),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Sign Up Prompt
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  l10n.no_account,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SignUpScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    l10n.sign_up,
                                    style: TextStyle(
                                        color: MyTheme.primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
