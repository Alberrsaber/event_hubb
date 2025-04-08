import 'package:event_booking_app_ui/controllers/auth_controller.dart';
import 'package:event_booking_app_ui/my_theme.dart';
import 'package:event_booking_app_ui/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:event_booking_app_ui/screens/signup_screen.dart';
import 'package:event_booking_app_ui/screens/resset_password_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  var controller = Get.put(AuthController());
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  bool _isPasswordVisible = false;
    @override
  void initState() {
    super.initState();
    _checkRememberedUser();
  }
  Future<void> _checkRememberedUser() async {
    bool remembered = await  controller.isRemembered();
    if (remembered && await  controller.isLoggedIn()) {
      // Navigate to home screen if user is remembered and logged in
      Get.offAll(() => HomeScreen());
    }
  } // Toggles password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Images
          const Align(
            alignment: Alignment.topLeft,
            child: Image(
                image: AssetImage('assets/backgrounds/signin_top_left.png')),
          ),
          const Align(
            alignment: Alignment.topRight,
            child: Image(
                image: AssetImage('assets/backgrounds/signin_top_right.png')),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: Image(
                image:
                    AssetImage('assets/backgrounds/signin_center_right.png')),
          ),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Image(
                image: AssetImage('assets/backgrounds/signin_bottom_left.png')),
          ),
          const Align(
            alignment: Alignment.bottomRight,
            child: Image(
                image:
                    AssetImage('assets/backgrounds/signin_bottom_right.png')),
          ),

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
                          const Center(
                              child: Image(
                                  image: AssetImage('assets/images/logo.png'))),
                          const SizedBox(height: 12),
                          const Center(
                            child: Text(
                              'EventHub',
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Sign In',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 12),

                          // Email Field
                          TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Image(
                                      image:
                                          AssetImage('assets/icons/mail.png')),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                hintText: 'abc@gmail.com',
                              ),
                              validator: (value) {
                                if (_emailController.text.isEmpty) {
                                  return "Email is required ";
                                } else {
                                  return null;
                                }
                              }),
                          const SizedBox(height: 10),

                          // Password Field with Toggle Visibility
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(12),
                                child: Image(
                                    image:
                                        AssetImage('assets/icons/locked.png')),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              hintText: 'Your Password',
                            ),
                            validator: (value) {
                              if (_passwordController.text.isEmpty) {
                                return "Password is required";
                              } else {
                                return null;
                              }
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
                              const Text('Remember Me'),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ResetPasswordScreen()),
                                  );
                                },
                                child: const Text('Forgot Password?'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Sign In Button
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                  controller.SignIn(
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(18)),
                              ),
                              child: Center(
                                child: Text(
                                  'SIGN IN',
                                  style: TextStyle(
                                      color: MyTheme.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 26),

                          // OR Divider
                          Center(
                              child: Text('OR',
                                  style: TextStyle(
                                      fontSize: 18, color: MyTheme.grey))),
                          const SizedBox(height: 8),

                          // Social Login Buttons
                          Center(
                            child: Column(
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    controller.signInWithGoogle(context);
                                  },
                                  icon: Image.asset('assets/icons/google.png',
                                      width: 24),
                                  label: const Text('Login with Google'),
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
                                const Text("Don't have an account?",
                                    style: TextStyle(fontSize: 16)),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpScreen()),
                                    );
                                  },
                                  child: Text(
                                    "Sign up",
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
