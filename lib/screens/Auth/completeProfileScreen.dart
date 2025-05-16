import 'package:event_booking_app_ui/controllers/auth_controller.dart';
import 'package:event_booking_app_ui/my_theme.dart';
import 'package:event_booking_app_ui/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CompleteProfileScreen extends StatefulWidget {
  final User user;
  final GoogleSignInAccount googleUser;
  const CompleteProfileScreen(
      {super.key, required this.user, required this.googleUser});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  String? userSpecialty;
  String? _userType; // "Student" or "Faculty Member"
  bool _isLoading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _mobileNumberController.dispose();
    userSpecialty = null;
    _userType = null;
    _isLoading = false;
    super.dispose();
  }

  void _saveUserData() async {
    if (_formKey.currentState!.validate() &&
        userSpecialty != null &&
        _userType != null) {
      setState(() {
        _isLoading = true;
      });
      await AuthController().saveUserData(_fullNameController.text, _mobileNumberController.text ,_userType!,userSpecialty!,).then((value){ Get.offAll(() => HomeScreen());
});


      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {});
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
                const Text("Complete Profile",
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "This field cannot be empty"
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _mobileNumberController,
                  decoration: const InputDecoration(
                    labelText: "Mobile Number",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      AuthController().validatePhoneNumber(value),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: userSpecialty,
                  decoration: const InputDecoration(
                    labelText: "Faculty of",
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    "Pharmacy",
                    "Medicine",
                    "Engineering",
                    "Sciences",
                    "Computers and Information",
                    "Education",
                    "Commerce",
                    "Nursing",
                    "Arts",
                    "Law"
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      userSpecialty = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? "Please select a Faculty" : null,
                ),
                const SizedBox(height: 10),
                const Text("Sign up as:"),
                RadioListTile<String>(
                  title: const Text("Student"),
                  value: "Student",
                  groupValue: _userType,
                  onChanged: (value) {
                    setState(() {
                      _userType = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text("Faculty Member"),
                  value: "Faculty Member",
                  groupValue: _userType,
                  onChanged: (value) {
                    setState(() {
                      _userType = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : GestureDetector(
                        onTap: _saveUserData,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: MyTheme.primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(18)),
                          ),
                          child: Center(
                            child: Text(
                              'SAVE',
                              style:
                                  TextStyle(color: MyTheme.white, fontSize: 16),
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
