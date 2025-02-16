import 'package:event_booking_app_ui/controllers/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'verification_screen.dart'; // Import VerificationScreen
import 'package:event_booking_app_ui/my_theme.dart'; // Import MyTheme

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  var controller = Get.put(AuthController());
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _mobileNumberController =
      TextEditingController(); // For mobile number

  String? _gender; // "Male", "Female", or "Other"
  bool _isStudent = false;
  bool _isFacultyMember = false;
  void _signUp() {
    if (_formKey.currentState!.validate() &&
        _gender != null &&
        (_isStudent || _isFacultyMember)) {
      String userType = _isStudent ? "Student" : "Faculty Member";
      controller.SignUp(_fullNameController.text,
          _emailController.text, _passwordController.text,_mobileNumberController.text,userType, context);

      // Navigate to Verification Screen
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => VerificationScreen(
      //       email: _emailController.text,
      //       userType: userType,
      //     ),
      //   ),
      // );
    } else {
      setState(() {}); // Update UI for error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Text("Sign Up",
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
                const SizedBox(height: 20),

                // Full Name
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "This field cannot be empty";
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    return controller.validateEmail(value);
                  },
                ),
                const SizedBox(height: 10),

                // Mobile Number
                TextFormField(
                  controller: _mobileNumberController,
                  decoration: const InputDecoration(
                    labelText: "Mobile Number",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType:
                      TextInputType.phone, // Set keyboard type to phone
                  validator: (value) {
                    return controller.validatePhoneNumber(value);
                  },
                ),
                const SizedBox(height: 10),

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Please enter a password";
                    if (value.length < 6)
                      return "Password must be at least 6 characters";
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Confirm Password
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Please confirm your password";
                    if (value != _passwordController.text)
                      return "Passwords do not match";
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Gender Selection (Dropdown)
                DropdownButtonFormField<String>(
                  value: _gender,
                  decoration: const InputDecoration(
                    labelText: "Gender",
                    border: OutlineInputBorder(),
                  ),
                  items: ["Male", "Female", "Other"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? "Please select a gender" : null,
                ),
                const SizedBox(height: 10),

                // User Role Selection (Checkboxes)
                const Text("Sign up as:"),
                CheckboxListTile(
                  title: const Text("Student"),
                  value: _isStudent,
                  onChanged: (bool? value) {
                    setState(() {
                      _isStudent = value!;
                      _isFacultyMember = !value;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text("Faculty Member"),
                  value: _isFacultyMember,
                  onChanged: (bool? value) {
                    setState(() {
                      _isFacultyMember = value!;
                      _isStudent = !value;
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Sign Up Button
                GestureDetector(
                  onTap: _signUp,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: MyTheme.primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(18)),
                    ),
                    child: Center(
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(color: MyTheme.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
