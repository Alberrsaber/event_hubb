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
                  'Sign Up Successful, We have sent an email verification to this email ${userEmail}, please check your email.')
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('The account already exists for that email.'),
          backgroundColor: Colors.red,
        ),
      );
      }else{
              print(e.code);
      }

      
    }
  }

// Sign In Method
  Future SignIn(email, password, context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => VerificationScreen(
                    email: email,
                    userType: '',
                  )),
        );
      }
    } on FirebaseAuthException catch (e) {
      if(e.code == 'invalid-credential'){
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
      }else{
        print(e.code);
      }
      
      
    }
  }

// Sign out Method
  Future SignOut(BuildContext context) async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => SignInScreen());
    } catch (e) {
      print("SignOut Error: $e");
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
                  'We have sent an email to reset your password. Please check your email and login.')
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
      await store.set({
        'userName': userName,
        'userEmail': userEmail,
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
    Get.to(() => HomeScreen());
  }

//validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
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
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter.';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }
    final phoneRegExp = RegExp(r'^\d{11}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (11 digits required).';
    }
    return null;
  }
}
