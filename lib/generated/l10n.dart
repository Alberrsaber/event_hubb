// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `                                               sIGN IN PAGE                                         `
  String get _comment1 {
    return Intl.message(
      '                                               sIGN IN PAGE                                         ',
      name: '_comment1',
      desc: '',
      args: [],
    );
  }

  /// `EventHub`
  String get app_name {
    return Intl.message('EventHub', name: 'app_name', desc: '', args: []);
  }

  /// `Sign In`
  String get sign_in {
    return Intl.message('Sign In', name: 'sign_in', desc: '', args: []);
  }

  /// `abc@gmail.com`
  String get email_hint {
    return Intl.message(
      'abc@gmail.com',
      name: 'email_hint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get email_required {
    return Intl.message(
      'Please enter your email',
      name: 'email_required',
      desc: '',
      args: [],
    );
  }

  /// `Your Password`
  String get password_hint {
    return Intl.message(
      'Your Password',
      name: 'password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get password_required {
    return Intl.message(
      'Password is required',
      name: 'password_required',
      desc: '',
      args: [],
    );
  }

  /// `Remember Me`
  String get remember_me {
    return Intl.message('Remember Me', name: 'remember_me', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `OR`
  String get or {
    return Intl.message('OR', name: 'or', desc: '', args: []);
  }

  /// `Login with Google`
  String get login_with_google {
    return Intl.message(
      'Login with Google',
      name: 'login_with_google',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get no_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'no_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message('Sign Up', name: 'sign_up', desc: '', args: []);
  }

  /// `Full Name`
  String get full_name {
    return Intl.message('Full Name', name: 'full_name', desc: '', args: []);
  }

  /// `This field cannot be empty`
  String get field_required {
    return Intl.message(
      'This field cannot be empty',
      name: 'field_required',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Mobile Number`
  String get mobile_number {
    return Intl.message(
      'Mobile Number',
      name: 'mobile_number',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Please enter a password`
  String get enter_password {
    return Intl.message(
      'Please enter a password',
      name: 'enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get password_min_length {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'password_min_length',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get confirm_password {
    return Intl.message(
      'Please confirm your password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get confirm_password_required {
    return Intl.message(
      'Please confirm your password',
      name: 'confirm_password_required',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwords_not_match {
    return Intl.message(
      'Passwords do not match',
      name: 'passwords_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Faculty of`
  String get faculty_of {
    return Intl.message('Faculty of', name: 'faculty_of', desc: '', args: []);
  }

  /// `Pharmacy`
  String get pharmacy {
    return Intl.message('Pharmacy', name: 'pharmacy', desc: '', args: []);
  }

  /// `Medicine`
  String get medicine {
    return Intl.message('Medicine', name: 'medicine', desc: '', args: []);
  }

  /// `Engineering`
  String get engineering {
    return Intl.message('Engineering', name: 'engineering', desc: '', args: []);
  }

  /// `Sciences`
  String get sciences {
    return Intl.message('Sciences', name: 'sciences', desc: '', args: []);
  }

  /// `Computers and Information`
  String get computers_and_info {
    return Intl.message(
      'Computers and Information',
      name: 'computers_and_info',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get education {
    return Intl.message('Education', name: 'education', desc: '', args: []);
  }

  /// `Commerce`
  String get commerce {
    return Intl.message('Commerce', name: 'commerce', desc: '', args: []);
  }

  /// `Nursing`
  String get nursing {
    return Intl.message('Nursing', name: 'nursing', desc: '', args: []);
  }

  /// `Arts`
  String get arts {
    return Intl.message('Arts', name: 'arts', desc: '', args: []);
  }

  /// `Law`
  String get law {
    return Intl.message('Law', name: 'law', desc: '', args: []);
  }

  /// `Please select a Faculty`
  String get select_faculty {
    return Intl.message(
      'Please select a Faculty',
      name: 'select_faculty',
      desc: '',
      args: [],
    );
  }

  /// `Sign up as:`
  String get sign_up_as {
    return Intl.message('Sign up as:', name: 'sign_up_as', desc: '', args: []);
  }

  /// `Student`
  String get student {
    return Intl.message('Student', name: 'student', desc: '', args: []);
  }

  /// `Faculty Member`
  String get faculty_member {
    return Intl.message(
      'Faculty Member',
      name: 'faculty_member',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email format (e.g., user@example.com)`
  String get invalid_email_format {
    return Intl.message(
      'Please enter a valid email format (e.g., user@example.com)',
      name: 'invalid_email_format',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number`
  String get phone_required {
    return Intl.message(
      'Please enter your phone number',
      name: 'phone_required',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number (e.g., +1234567890)`
  String get invalid_phone_format {
    return Intl.message(
      'Please enter a valid phone number (e.g., +1234567890)',
      name: 'invalid_phone_format',
      desc: '',
      args: [],
    );
  }

  /// `                                                eXPLORE Screen                                         `
  String get _comment2 {
    return Intl.message(
      '                                                eXPLORE Screen                                         ',
      name: '_comment2',
      desc: '',
      args: [],
    );
  }

  /// `Top Topics`
  String get top_topics {
    return Intl.message('Top Topics', name: 'top_topics', desc: '', args: []);
  }

  /// `Upcoming Events`
  String get upcoming_events {
    return Intl.message(
      'Upcoming Events',
      name: 'upcoming_events',
      desc: '',
      args: [],
    );
  }

  /// `For You`
  String get for_you {
    return Intl.message('For You', name: 'for_you', desc: '', args: []);
  }

  /// `Past Events`
  String get past_events {
    return Intl.message('Past Events', name: 'past_events', desc: '', args: []);
  }

  /// `                                               categories Screen                                         `
  String get _comment3 {
    return Intl.message(
      '                                               categories Screen                                         ',
      name: '_comment3',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `Events`
  String get events {
    return Intl.message('Events', name: 'events', desc: '', args: []);
  }

  /// `No events found`
  String get no_events_found {
    return Intl.message(
      'No events found',
      name: 'no_events_found',
      desc: '',
      args: [],
    );
  }

  /// `                                              allmytickets Screen                                         `
  String get _comment4 {
    return Intl.message(
      '                                              allmytickets Screen                                         ',
      name: '_comment4',
      desc: '',
      args: [],
    );
  }

  /// `My Tickets`
  String get my_tickets {
    return Intl.message('My Tickets', name: 'my_tickets', desc: '', args: []);
  }

  /// `Error loading tickets`
  String get error_loading_tickets {
    return Intl.message(
      'Error loading tickets',
      name: 'error_loading_tickets',
      desc: '',
      args: [],
    );
  }

  /// `No tickets found`
  String get no_tickets_found {
    return Intl.message(
      'No tickets found',
      name: 'no_tickets_found',
      desc: '',
      args: [],
    );
  }

  /// `Faculty Courses`
  String get faculty_courses {
    return Intl.message(
      'Faculty Courses',
      name: 'faculty_courses',
      desc: '',
      args: [],
    );
  }

  /// `No courses available for this month`
  String get no_courses_available {
    return Intl.message(
      'No courses available for this month',
      name: 'no_courses_available',
      desc: '',
      args: [],
    );
  }

  /// `January`
  String get january {
    return Intl.message('January', name: 'january', desc: '', args: []);
  }

  /// `February`
  String get february {
    return Intl.message('February', name: 'february', desc: '', args: []);
  }

  /// `March`
  String get march {
    return Intl.message('March', name: 'march', desc: '', args: []);
  }

  /// `April`
  String get april {
    return Intl.message('April', name: 'april', desc: '', args: []);
  }

  /// `May`
  String get may {
    return Intl.message('May', name: 'may', desc: '', args: []);
  }

  /// `June`
  String get june {
    return Intl.message('June', name: 'june', desc: '', args: []);
  }

  /// `July`
  String get july {
    return Intl.message('July', name: 'july', desc: '', args: []);
  }

  /// `August`
  String get august {
    return Intl.message('August', name: 'august', desc: '', args: []);
  }

  /// `September`
  String get september {
    return Intl.message('September', name: 'september', desc: '', args: []);
  }

  /// `October`
  String get october {
    return Intl.message('October', name: 'october', desc: '', args: []);
  }

  /// `November`
  String get november {
    return Intl.message('November', name: 'november', desc: '', args: []);
  }

  /// `December`
  String get december {
    return Intl.message('December', name: 'december', desc: '', args: []);
  }

  /// `Course Details`
  String get course_details {
    return Intl.message(
      'Course Details',
      name: 'course_details',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Course Program`
  String get course_program {
    return Intl.message(
      'Course Program',
      name: 'course_program',
      desc: '',
      args: [],
    );
  }

  /// `Program Name`
  String get program_name {
    return Intl.message(
      'Program Name',
      name: 'program_name',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Time`
  String get time {
    return Intl.message('Time', name: 'time', desc: '', args: []);
  }

  /// `Type`
  String get type {
    return Intl.message('Type', name: 'type', desc: '', args: []);
  }

  /// `Location`
  String get location {
    return Intl.message('Location', name: 'location', desc: '', args: []);
  }

  /// `                                             Event Details Screen                                         `
  String get _comment5 {
    return Intl.message(
      '                                             Event Details Screen                                         ',
      name: '_comment5',
      desc: '',
      args: [],
    );
  }

  /// `Organizer`
  String get organizer {
    return Intl.message('Organizer', name: 'organizer', desc: '', args: []);
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `Event Ended`
  String get event_ended {
    return Intl.message('Event Ended', name: 'event_ended', desc: '', args: []);
  }

  /// `Book Ticket`
  String get book_ticket {
    return Intl.message('Book Ticket', name: 'book_ticket', desc: '', args: []);
  }

  /// `                                             Event  Screen                                         `
  String get _comment6 {
    return Intl.message(
      '                                             Event  Screen                                         ',
      name: '_comment6',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `                                             Home  Screen                                         `
  String get _comment7 {
    return Intl.message(
      '                                             Home  Screen                                         ',
      name: '_comment7',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get sign_out {
    return Intl.message('Sign Out', name: 'sign_out', desc: '', args: []);
  }

  /// `Are you sure you want to sign out?`
  String get sign_out_confirmation {
    return Intl.message(
      'Are you sure you want to sign out?',
      name: 'sign_out_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Error signing out:`
  String get sign_out_error {
    return Intl.message(
      'Error signing out:',
      name: 'sign_out_error',
      desc: '',
      args: [],
    );
  }

  /// `Please edit your profile`
  String get edit_profile_prompt {
    return Intl.message(
      'Please edit your profile',
      name: 'edit_profile_prompt',
      desc: '',
      args: [],
    );
  }

  /// `Bookmarks`
  String get bookmarks {
    return Intl.message('Bookmarks', name: 'bookmarks', desc: '', args: []);
  }

  /// `Contact Us`
  String get contact_us {
    return Intl.message('Contact Us', name: 'contact_us', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Helps & FAQs`
  String get help_faq {
    return Intl.message('Helps & FAQs', name: 'help_faq', desc: '', args: []);
  }

  /// `Search...`
  String get search_hint {
    return Intl.message('Search...', name: 'search_hint', desc: '', args: []);
  }

  /// `Explore`
  String get explore {
    return Intl.message('Explore', name: 'explore', desc: '', args: []);
  }

  /// `Calendar`
  String get calendar {
    return Intl.message('Calendar', name: 'calendar', desc: '', args: []);
  }

  /// `Faculty`
  String get faculty {
    return Intl.message('Faculty', name: 'faculty', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get current_password {
    return Intl.message(
      'Current Password',
      name: 'current_password',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get new_password {
    return Intl.message(
      'New Password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirm_new_password {
    return Intl.message(
      'Confirm New Password',
      name: 'confirm_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your current password`
  String get enter_current_password {
    return Intl.message(
      'Please enter your current password',
      name: 'enter_current_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a new password`
  String get enter_new_password {
    return Intl.message(
      'Please enter a new password',
      name: 'enter_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get password_changed_success {
    return Intl.message(
      'Password changed successfully',
      name: 'password_changed_success',
      desc: '',
      args: [],
    );
  }

  /// `Current password is incorrect`
  String get current_password_incorrect {
    return Intl.message(
      'Current password is incorrect',
      name: 'current_password_incorrect',
      desc: '',
      args: [],
    );
  }

  /// `New password is too weak`
  String get password_too_weak {
    return Intl.message(
      'New password is too weak',
      name: 'password_too_weak',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get user_not_found {
    return Intl.message(
      'User not found',
      name: 'user_not_found',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred`
  String get unexpected_error {
    return Intl.message(
      'An unexpected error occurred',
      name: 'unexpected_error',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get my_profile {
    return Intl.message('My Profile', name: 'my_profile', desc: '', args: []);
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `My Ticket`
  String get my_ticket {
    return Intl.message('My Ticket', name: 'my_ticket', desc: '', args: []);
  }

  /// `Present this QR code at the gate.`
  String get present_qr_message {
    return Intl.message(
      'Present this QR code at the gate.',
      name: 'present_qr_message',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Order No.`
  String get order_number {
    return Intl.message('Order No.', name: 'order_number', desc: '', args: []);
  }

  /// `Seat`
  String get seat {
    return Intl.message('Seat', name: 'seat', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Share`
  String get share {
    return Intl.message('Share', name: 'share', desc: '', args: []);
  }

  /// `Here's my ticket 🎟️`
  String get ticket_share_message {
    return Intl.message(
      'Here\'s my ticket 🎟️',
      name: 'ticket_share_message',
      desc: '',
      args: [],
    );
  }

  /// `Push Notifications`
  String get push_notifications {
    return Intl.message(
      'Push Notifications',
      name: 'push_notifications',
      desc: '',
      args: [],
    );
  }

  /// `Language Selection`
  String get language_selection {
    return Intl.message(
      'Language Selection',
      name: 'language_selection',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get select_language {
    return Intl.message(
      'Select Language',
      name: 'select_language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `Dark Mode`
  String get dark_mode {
    return Intl.message('Dark Mode', name: 'dark_mode', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
