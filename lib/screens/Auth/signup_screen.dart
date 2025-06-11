import 'package:event_booking_app_ui/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:event_booking_app_ui/my_theme.dart';
import 'package:event_booking_app_ui/generated/l10n.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  String? userSpecialty;
  String? _userType; // "Student" or "Faculty Member"
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final l10n = S.of(Get.context!);

  void _signUp() async {
    if (_formKey.currentState!.validate() &&
        userSpecialty != null &&
        _userType != null) {
      setState(() {
        _isLoading = true;
      });

      await AuthController().SignUp(
        _fullNameController.text,
        _emailController.text,
        _passwordController.text,
        _mobileNumberController.text,
        _userType!,
        userSpecialty,
        context,
      );

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
                Text(l10n.sign_up,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.w500)),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    labelText: l10n.full_name,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? l10n.field_required
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: l10n.email,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) => AuthController().validateEmail(value),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _mobileNumberController,
                  decoration: InputDecoration(
                    labelText: l10n.mobile_number,
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      AuthController().validatePhoneNumber(value),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: l10n.password,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return l10n.enter_password;
                    if (value.length < 6) return l10n.password_min_length;
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: l10n.confirm_password,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return l10n.confirm_password_required;
                    if (value != _passwordController.text)
                      return l10n.passwords_not_match;
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: userSpecialty,
                  decoration: InputDecoration(
                    labelText: l10n.faculty_of,
                    border: const OutlineInputBorder(),
                  ),
                  items: [
                    l10n.pharmacy,
                    l10n.medicine,
                    l10n.engineering,
                    l10n.sciences,
                    l10n.computers_and_info,
                    l10n.education,
                    l10n.commerce,
                    l10n.nursing,
                    l10n.arts,
                    l10n.law
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
                      value == null ? l10n.select_faculty : null,
                ),
                const SizedBox(height: 10),
                Text(l10n.sign_up_as),
                RadioListTile<String>(
                  title: Text(l10n.student),
                  value: l10n.student,
                  groupValue: _userType,
                  onChanged: (value) {
                    setState(() {
                      _userType = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text(l10n.faculty_member),
                  value: l10n.faculty_member,
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
                        onTap: _signUp,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: MyTheme.primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(18)),
                          ),
                          child: Center(
                            child: Text(
                              l10n.sign_up.toUpperCase(),
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
