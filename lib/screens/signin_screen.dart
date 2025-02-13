import 'package:event_booking_app_ui/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:event_booking_app_ui/screens/home_screen.dart';
import 'package:event_booking_app_ui/screens/signup_screen.dart';
import 'package:event_booking_app_ui/screens/resset_password_screen.dart'; 

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
  bool _isPasswordVisible = false; // Toggles password visibility

  bool _validateEmail(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(email);
  }

  bool _validatePassword(String password) {
    return password.length >= 6;
  }

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      if (_validateEmail(email) && _validatePassword(password)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid email or password. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
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
            child: Image(image: AssetImage('assets/backgrounds/signin_top_left.png')),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Image(image: AssetImage('assets/backgrounds/signin_top_right.png')),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Image(image: AssetImage('assets/backgrounds/signin_center_right.png')),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image(image: AssetImage('assets/backgrounds/signin_bottom_left.png')),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image(image: AssetImage('assets/backgrounds/signin_bottom_right.png')),
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
                          SizedBox(height: 54),
                          Center(child: Image(image: AssetImage('assets/images/logo.png'))),
                          SizedBox(height: 12),
                          Center(
                            child: Text(
                              'EventHub',
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Sign In',
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 12),

                          // Email Field
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(12),
                                child: Image(image: AssetImage('assets/icons/mail.png')),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              hintText: 'abc@gmail.com',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!_validateEmail(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),

                          // Password Field with Toggle Visibility
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(12),
                                child: Image(image: AssetImage('assets/icons/locked.png')),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              hintText: 'Your Password',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (!_validatePassword(value)) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 8),

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
                              Text('Remember Me'),
                              Spacer(),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                                  );
                                },
                                child: Text('Forgot Password?'),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),

                          // Sign In Button
                          GestureDetector(
                            onTap: _signIn,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: MyTheme.primaryColor,
                                borderRadius: BorderRadius.all(Radius.circular(18)),
                              ),
                              child: Center(
                                child: Text(
                                  'SIGN IN',
                                  style: TextStyle(color: MyTheme.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 26),

                          // OR Divider
                          Center(child: Text('OR', style: TextStyle(fontSize: 18, color: MyTheme.grey))),
                          SizedBox(height: 8),

                          // Social Login Buttons
                          Center(
                            child: Column(
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: Image.asset('assets/icons/google.png', width: 24),
                                  label: Text('Login with Google'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: Image.asset('assets/icons/facebook.png', width: 24),
                                  label: Text('Login with Facebook'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12),

                          // Sign Up Prompt
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account?", style: TextStyle(fontSize: 16)),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                                    );
                                  },
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(color: MyTheme.primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
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
