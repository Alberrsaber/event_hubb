import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_booking_app_ui/screens/home_screen.dart';
import 'package:event_booking_app_ui/screens/signin_screen.dart';
import 'package:event_booking_app_ui/screens/verification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  // Sign up Method
  Future SignUp(userName, userEmail, userPassword, userPhone, userQualification,
      context) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      SendEmailVerfication();
      AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              desc:
                  'ًSign Up Successful , We have sent email verfication to this email ${userEmail}, please check your email   ')
          .show()
          .then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
        );
      });
      adduser(
        userName,
        userEmail,
        userPassword,
        userPhone,
        userQualification,
      );
      SignOut();
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('The account already exists for that email.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

// Sign In Mehtod

  Future SignIn(
    email,
    password,
    context,
  ) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => VerificationScreen(
                    email: email,
                  )),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

// Sign out Method
  Future SignOut() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => SignInScreen());
    } catch (e) {
      print(e);
    }
  }

  // email verification
  Future SendEmailVerfication() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  // reset password
  Future resetPassword(email, context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              desc:
                  'ً We have sent email to reset your password , please check your email and login   ')
          .show()
          .then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
        );
      });
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  adduser(
    String userName,
    String userEmail,
    String userPassword,
    String userPhone,
    String userQualification,
  ) async {
    try {
      DocumentReference store = FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid);
      print(userName);
      await store.set({
        'userName': userName, // John Doe
        'userEmail': userEmail, // Stokes and Sons
        'userPassword': userPassword,
        'userPhone': userPhone,
        'userQualification': userQualification,
        'userImage': "",
        'userSpecialty': "",
        'userId': FirebaseAuth.instance.currentUser!.uid,
      });
    } catch (e) {
      print(e);
    }
  }

// sign in with google
  Future signInWithGoogle(context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }
    final GoogleSignInAuthentication? googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    Get.to(() => const HomeScreen());
  }

//validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(
        r'^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    // Check for minimum password length
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }
    // Check for lowercase letters
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter.';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }

    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'^\d{11}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (10 digits required).';
    }

    return null;
  }
}
