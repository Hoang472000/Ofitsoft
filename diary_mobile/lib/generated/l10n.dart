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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Close`
  String get close_dialog {
    return Intl.message(
      'Close',
      name: 'close_dialog',
      desc: '',
      args: [],
    );
  }

  /// `Features are under development`
  String get feature_mess {
    return Intl.message(
      'Features are under development',
      name: 'feature_mess',
      desc: '',
      args: [],
    );
  }

  /// `Please enter `
  String get error_input_empty {
    return Intl.message(
      'Please enter ',
      name: 'error_input_empty',
      desc: '',
      args: [],
    );
  }

  /// `Password can not be blank.`
  String get pass_empty {
    return Intl.message(
      'Password can not be blank.',
      name: 'pass_empty',
      desc: '',
      args: [],
    );
  }

  /// `SDT không được để trống`
  String get phone_emty {
    return Intl.message(
      'SDT không được để trống',
      name: 'phone_emty',
      desc: '',
      args: [],
    );
  }

  /// `cannot be left blank`
  String get not_emty {
    return Intl.message(
      'cannot be left blank',
      name: 'not_emty',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgot_password {
    return Intl.message(
      'Forgot Password',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Agree`
  String get agree {
    return Intl.message(
      'Agree',
      name: 'agree',
      desc: '',
      args: [],
    );
  }

  /// `Password must be 8 characters or more in length`
  String get error_pass_length {
    return Intl.message(
      'Password must be 8 characters or more in length',
      name: 'error_pass_length',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password.`
  String get pass_wrong {
    return Intl.message(
      'Incorrect password.',
      name: 'pass_wrong',
      desc: '',
      args: [],
    );
  }

  /// `The new password must not be the same as the current password.`
  String get pass_duplicate {
    return Intl.message(
      'The new password must not be the same as the current password.',
      name: 'pass_duplicate',
      desc: '',
      args: [],
    );
  }

  /// `Password is not in correct format.`
  String get pass_format_wrong {
    return Intl.message(
      'Password is not in correct format.',
      name: 'pass_format_wrong',
      desc: '',
      args: [],
    );
  }

  /// `The password does not match the new password.`
  String get pass_not_same_new_pass {
    return Intl.message(
      'The password does not match the new password.',
      name: 'pass_not_same_new_pass',
      desc: '',
      args: [],
    );
  }

  /// `Password does not contain spaces, does not contain Username information`
  String get error_pass_contain_space_info {
    return Intl.message(
      'Password does not contain spaces, does not contain Username information',
      name: 'error_pass_contain_space_info',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Moving the Camera to the progress code container will happen automatically`
  String get bar_mess {
    return Intl.message(
      'Moving the Camera to the progress code container will happen automatically',
      name: 'bar_mess',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get label_user_name {
    return Intl.message(
      'Username',
      name: 'label_user_name',
      desc: '',
      args: [],
    );
  }

  /// `Username cannot be blank`
  String get label_user_name_empty {
    return Intl.message(
      'Username cannot be blank',
      name: 'label_user_name_empty',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get label_password {
    return Intl.message(
      'Password',
      name: 'label_password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get button_login {
    return Intl.message(
      'Login',
      name: 'button_login',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get pass_current {
    return Intl.message(
      'Current Password',
      name: 'pass_current',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get pass_new {
    return Intl.message(
      'New Password',
      name: 'pass_new',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirm_pass_new {
    return Intl.message(
      'Confirm New Password',
      name: 'confirm_pass_new',
      desc: '',
      args: [],
    );
  }

  /// ` <h3>Note</h3><a>Password must satisfy the following 3 conditions:</a><ul><li>Must be <b>8 characters or more in length</b> </li><li><b>Contains no spaces or information Username</b></li><li><b>Contains 3 of 4 character types</b> (a – z, A – Z, 0 – 9, !@#$%^&*) </li></ul><a>Example: Ofit0722, Diary@Note</a>`
  String get note_change_password {
    return Intl.message(
      ' <h3>Note</h3><a>Password must satisfy the following 3 conditions:</a><ul><li>Must be <b>8 characters or more in length</b> </li><li><b>Contains no spaces or information Username</b></li><li><b>Contains 3 of 4 character types</b> (a – z, A – Z, 0 – 9, !@#\$%^&*) </li></ul><a>Example: Ofit0722, Diary@Note</a>',
      name: 'note_change_password',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get note {
    return Intl.message(
      'Note',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Password must satisfy the following 3 conditions:`
  String get pass_have {
    return Intl.message(
      'Password must satisfy the following 3 conditions:',
      name: 'pass_have',
      desc: '',
      args: [],
    );
  }

  /// `Must have word length `
  String get pass_have_length {
    return Intl.message(
      'Must have word length ',
      name: 'pass_have_length',
      desc: '',
      args: [],
    );
  }

  /// `8 characters or more`
  String get pass_have_length_8 {
    return Intl.message(
      '8 characters or more',
      name: 'pass_have_length_8',
      desc: '',
      args: [],
    );
  }

  /// `Does not contain spaces or Username information`
  String get pass_have_not_contain_space {
    return Intl.message(
      'Does not contain spaces or Username information',
      name: 'pass_have_not_contain_space',
      desc: '',
      args: [],
    );
  }

  /// `Contains 3 of 4 character styles `
  String get pass_have_have {
    return Intl.message(
      'Contains 3 of 4 character styles ',
      name: 'pass_have_have',
      desc: '',
      args: [],
    );
  }

  /// `(a – z, A – Z, 0 – 9, !@#$%^&*) `
  String get pass_have_special {
    return Intl.message(
      '(a – z, A – Z, 0 – 9, !@#\$%^&*) ',
      name: 'pass_have_special',
      desc: '',
      args: [],
    );
  }

  /// `Example: Ofit2023, Ofit@Soft`
  String get pass_have_vd {
    return Intl.message(
      'Example: Ofit2023, Ofit@Soft',
      name: 'pass_have_vd',
      desc: '',
      args: [],
    );
  }

  /// `Sign out successfully!`
  String get logout_message {
    return Intl.message(
      'Sign out successfully!',
      name: 'logout_message',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get login_user_name {
    return Intl.message(
      'Username',
      name: 'login_user_name',
      desc: '',
      args: [],
    );
  }

  /// `Trang chủ`
  String get home_label {
    return Intl.message(
      'Trang chủ',
      name: 'home_label',
      desc: '',
      args: [],
    );
  }

  /// `Thông báo`
  String get notify_label {
    return Intl.message(
      'Thông báo',
      name: 'notify_label',
      desc: '',
      args: [],
    );
  }

  /// `You are scanning qrcode not barcode. Please try again.`
  String get barcode_error {
    return Intl.message(
      'You are scanning qrcode not barcode. Please try again.',
      name: 'barcode_error',
      desc: '',
      args: [],
    );
  }

  /// `You are scanning barcode not qrcode. Please try again.`
  String get qrcode_error {
    return Intl.message(
      'You are scanning barcode not qrcode. Please try again.',
      name: 'qrcode_error',
      desc: '',
      args: [],
    );
  }

  /// `Select photo/video`
  String get pick_a_photo {
    return Intl.message(
      'Select photo/video',
      name: 'pick_a_photo',
      desc: '',
      args: [],
    );
  }

  /// `Take a photo`
  String get from_camera {
    return Intl.message(
      'Take a photo',
      name: 'from_camera',
      desc: '',
      args: [],
    );
  }

  /// `Collection`
  String get from_library {
    return Intl.message(
      'Collection',
      name: 'from_library',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this photo?`
  String get you_sure_want_delete_image {
    return Intl.message(
      'Are you sure you want to delete this photo?',
      name: 'you_sure_want_delete_image',
      desc: '',
      args: [],
    );
  }

  /// `Into money`
  String get into_money {
    return Intl.message(
      'Into money',
      name: 'into_money',
      desc: '',
      args: [],
    );
  }

  /// `Scan the code`
  String get code_scan {
    return Intl.message(
      'Scan the code',
      name: 'code_scan',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Does not exist, please try again`
  String get code_not_exist {
    return Intl.message(
      'Does not exist, please try again',
      name: 'code_not_exist',
      desc: '',
      args: [],
    );
  }

  /// `qrcode`
  String get qrcode {
    return Intl.message(
      'qrcode',
      name: 'qrcode',
      desc: '',
      args: [],
    );
  }

  /// `barcode`
  String get barcode {
    return Intl.message(
      'barcode',
      name: 'barcode',
      desc: '',
      args: [],
    );
  }

  /// `No right`
  String get no_permission {
    return Intl.message(
      'No right',
      name: 'no_permission',
      desc: '',
      args: [],
    );
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

  /// `VND`
  String get vnd {
    return Intl.message(
      'VND',
      name: 'vnd',
      desc: '',
      args: [],
    );
  }

  /// `Total @ votes`
  String get sum_amount_slip {
    return Intl.message(
      'Total @ votes',
      name: 'sum_amount_slip',
      desc: '',
      args: [],
    );
  }

  /// `Empty`
  String get empty {
    return Intl.message(
      'Empty',
      name: 'empty',
      desc: '',
      args: [],
    );
  }

  /// `Hỗ trợ`
  String get Support {
    return Intl.message(
      'Hỗ trợ',
      name: 'Support',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `You cannot edit this information`
  String get warning_cannot_edit {
    return Intl.message(
      'You cannot edit this information',
      name: 'warning_cannot_edit',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get support {
    return Intl.message(
      'Support',
      name: 'support',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
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
