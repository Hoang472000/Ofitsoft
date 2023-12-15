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

  /// `Đóng`
  String get close_dialog {
    return Intl.message(
      'Đóng',
      name: 'close_dialog',
      desc: '',
      args: [],
    );
  }

  /// `Tính năng đang phát triển`
  String get feature_mess {
    return Intl.message(
      'Tính năng đang phát triển',
      name: 'feature_mess',
      desc: '',
      args: [],
    );
  }

  /// `Cài đặt đăng nhập vân tay thành công !`
  String get complete_dialog {
    return Intl.message(
      'Cài đặt đăng nhập vân tay thành công !',
      name: 'complete_dialog',
      desc: '',
      args: [],
    );
  }

  /// `Vân tay không trùng khớp`
  String get error_dialog_fingerprint {
    return Intl.message(
      'Vân tay không trùng khớp',
      name: 'error_dialog_fingerprint',
      desc: '',
      args: [],
    );
  }

  /// `Bạn không thể chỉnh sửa thông tin này`
  String get warning_cannot_edit {
    return Intl.message(
      'Bạn không thể chỉnh sửa thông tin này',
      name: 'warning_cannot_edit',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập `
  String get error_input_empty {
    return Intl.message(
      'Vui lòng nhập ',
      name: 'error_input_empty',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu không được để trống.`
  String get pass_empty {
    return Intl.message(
      'Mật khẩu không được để trống.',
      name: 'pass_empty',
      desc: '',
      args: [],
    );
  }

  /// `Mã số thuế không được để trống`
  String get tax_code_empty {
    return Intl.message(
      'Mã số thuế không được để trống',
      name: 'tax_code_empty',
      desc: '',
      args: [],
    );
  }

  /// `Tên đơn vị không được để trống`
  String get name_company_emty {
    return Intl.message(
      'Tên đơn vị không được để trống',
      name: 'name_company_emty',
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

  /// `không được để trống`
  String get not_emty {
    return Intl.message(
      'không được để trống',
      name: 'not_emty',
      desc: '',
      args: [],
    );
  }

  /// `Xác thực vân tay`
  String get fingerprint_authentication {
    return Intl.message(
      'Xác thực vân tay',
      name: 'fingerprint_authentication',
      desc: '',
      args: [],
    );
  }

  /// `Huỷ`
  String get cancel {
    return Intl.message(
      'Huỷ',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Quên mật khẩu`
  String get forgot_password {
    return Intl.message(
      'Quên mật khẩu',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Đồng ý`
  String get agree {
    return Intl.message(
      'Đồng ý',
      name: 'agree',
      desc: '',
      args: [],
    );
  }

  /// `Gửi không thành công`
  String get send_not_success {
    return Intl.message(
      'Gửi không thành công',
      name: 'send_not_success',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu phải có độ dài từ 8 ký tự trở lên`
  String get error_pass_length {
    return Intl.message(
      'Mật khẩu phải có độ dài từ 8 ký tự trở lên',
      name: 'error_pass_length',
      desc: '',
      args: [],
    );
  }

  /// `Hôm nay`
  String get today {
    return Intl.message(
      'Hôm nay',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu không đúng.`
  String get pass_wrong {
    return Intl.message(
      'Mật khẩu không đúng.',
      name: 'pass_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu mới không được trùng với mật khẩu hiện tại.`
  String get pass_duplicate {
    return Intl.message(
      'Mật khẩu mới không được trùng với mật khẩu hiện tại.',
      name: 'pass_duplicate',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu không đúng định dạng.`
  String get pass_format_wrong {
    return Intl.message(
      'Mật khẩu không đúng định dạng.',
      name: 'pass_format_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu không khớp với mật khẩu mới.`
  String get pass_not_same_new_pass {
    return Intl.message(
      'Mật khẩu không khớp với mật khẩu mới.',
      name: 'pass_not_same_new_pass',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu không chứa khoảng trắng, không chứa thông tin Tên đăng nhập`
  String get error_pass_contain_space_info {
    return Intl.message(
      'Mật khẩu không chứa khoảng trắng, không chứa thông tin Tên đăng nhập',
      name: 'error_pass_contain_space_info',
      desc: '',
      args: [],
    );
  }

  /// `Thêm vào giỏ hàng`
  String get add_to_cart {
    return Intl.message(
      'Thêm vào giỏ hàng',
      name: 'add_to_cart',
      desc: '',
      args: [],
    );
  }

  /// `<b style='font-weight:500'>Người nhận: </b>`
  String get receiver {
    return Intl.message(
      '<b style=\'font-weight:500\'>Người nhận: </b>',
      name: 'receiver',
      desc: '',
      args: [],
    );
  }

  /// `<b style='font-weight:500'>Số điện thoại: </b>`
  String get phone_number {
    return Intl.message(
      '<b style=\'font-weight:500\'>Số điện thoại: </b>',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `<b style='font-weight:500'>Địa chỉ giao:</b>`
  String get address_trans {
    return Intl.message(
      '<b style=\'font-weight:500\'>Địa chỉ giao:</b>',
      name: 'address_trans',
      desc: '',
      args: [],
    );
  }

  /// `Hạn: `
  String get term_date {
    return Intl.message(
      'Hạn: ',
      name: 'term_date',
      desc: '',
      args: [],
    );
  }

  /// `Email: `
  String get email_title {
    return Intl.message(
      'Email: ',
      name: 'email_title',
      desc: '',
      args: [],
    );
  }

  /// `Ngày bán: `
  String get sell_date_title {
    return Intl.message(
      'Ngày bán: ',
      name: 'sell_date_title',
      desc: '',
      args: [],
    );
  }

  /// `<b style='font-weight:500'>Ngày giao: </b>`
  String get delivery_day {
    return Intl.message(
      '<b style=\'font-weight:500\'>Ngày giao: </b>',
      name: 'delivery_day',
      desc: '',
      args: [],
    );
  }

  /// `Sửa thông tin`
  String get edit_info {
    return Intl.message(
      'Sửa thông tin',
      name: 'edit_info',
      desc: '',
      args: [],
    );
  }

  /// `Bạn không thể sửa thông tin này`
  String get info_dont_edit {
    return Intl.message(
      'Bạn không thể sửa thông tin này',
      name: 'info_dont_edit',
      desc: '',
      args: [],
    );
  }

  /// `Quét mã thành công`
  String get scan_success {
    return Intl.message(
      'Quét mã thành công',
      name: 'scan_success',
      desc: '',
      args: [],
    );
  }

  /// `Sửa thông tin thành công`
  String get edit_success {
    return Intl.message(
      'Sửa thông tin thành công',
      name: 'edit_success',
      desc: '',
      args: [],
    );
  }

  /// `Nhập thông tin thành công`
  String get enter_success {
    return Intl.message(
      'Nhập thông tin thành công',
      name: 'enter_success',
      desc: '',
      args: [],
    );
  }

  /// `Thông Báo Cập Nhật`
  String get dialog_title_version {
    return Intl.message(
      'Thông Báo Cập Nhật',
      name: 'dialog_title_version',
      desc: '',
      args: [],
    );
  }

  /// `Cập nhật`
  String get update_version_button_text {
    return Intl.message(
      'Cập nhật',
      name: 'update_version_button_text',
      desc: '',
      args: [],
    );
  }

  /// `Đóng`
  String get dismiss_version_button_text {
    return Intl.message(
      'Đóng',
      name: 'dismiss_version_button_text',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc muốn cập nhật phiên bản từ`
  String get content_version_dialog_text {
    return Intl.message(
      'Bạn có chắc muốn cập nhật phiên bản từ',
      name: 'content_version_dialog_text',
      desc: '',
      args: [],
    );
  }

  /// `lên`
  String get to_version_text {
    return Intl.message(
      'lên',
      name: 'to_version_text',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chưa đủ điểm để đổi quà tặng này.`
  String get not_enough_point {
    return Intl.message(
      'Bạn chưa đủ điểm để đổi quà tặng này.',
      name: 'not_enough_point',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chắc chắn muốn bỏ sản phẩm này?`
  String get sure_remove_product {
    return Intl.message(
      'Bạn chắc chắn muốn bỏ sản phẩm này?',
      name: 'sure_remove_product',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc chắn muốn xóa hết số quà đã chọn không?`
  String get sure_delete_all_cart {
    return Intl.message(
      'Bạn có chắc chắn muốn xóa hết số quà đã chọn không?',
      name: 'sure_delete_all_cart',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có muốn đổi mật khẩu  mới không?`
  String get sure_change_passwork {
    return Intl.message(
      'Bạn có muốn đổi mật khẩu  mới không?',
      name: 'sure_change_passwork',
      desc: '',
      args: [],
    );
  }

  /// `ĐỔI MẬT KHẨU THÀNH CÔNG`
  String get title_dialog_exchange_pass {
    return Intl.message(
      'ĐỔI MẬT KHẨU THÀNH CÔNG',
      name: 'title_dialog_exchange_pass',
      desc: '',
      args: [],
    );
  }

  /// `Chúc mừng bạn đã đổi mật khẩu thành công`
  String get content_dialog_exchange_pass {
    return Intl.message(
      'Chúc mừng bạn đã đổi mật khẩu thành công',
      name: 'content_dialog_exchange_pass',
      desc: '',
      args: [],
    );
  }

  /// `Chọn tất cả`
  String get select_all {
    return Intl.message(
      'Chọn tất cả',
      name: 'select_all',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng chọn quà tặng mà bạn muốn đổi!`
  String get select_voucher {
    return Intl.message(
      'Vui lòng chọn quà tặng mà bạn muốn đổi!',
      name: 'select_voucher',
      desc: '',
      args: [],
    );
  }

  /// `Đăng xuất`
  String get logout {
    return Intl.message(
      'Đăng xuất',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc muốn đăng xuất không?`
  String get are_you_sure {
    return Intl.message(
      'Bạn có chắc muốn đăng xuất không?',
      name: 'are_you_sure',
      desc: '',
      args: [],
    );
  }

  /// `Di chuyển Camera đến vùng chứa mã tiến trình sẽ diễn ra tự động`
  String get bar_mess {
    return Intl.message(
      'Di chuyển Camera đến vùng chứa mã tiến trình sẽ diễn ra tự động',
      name: 'bar_mess',
      desc: '',
      args: [],
    );
  }

  /// `Nhập mã`
  String get enter_code {
    return Intl.message(
      'Nhập mã',
      name: 'enter_code',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có muốn thêm mới mặt hàng này không?`
  String get want_you_add_product_new {
    return Intl.message(
      'Bạn có muốn thêm mới mặt hàng này không?',
      name: 'want_you_add_product_new',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc chắn muốn xóa phiếu @p này không ?`
  String get you_sure_want_delete_bill {
    return Intl.message(
      'Bạn có chắc chắn muốn xóa phiếu @p này không ?',
      name: 'you_sure_want_delete_bill',
      desc: '',
      args: [],
    );
  }

  /// `Thanh toán phiếu`
  String get payment_bill {
    return Intl.message(
      'Thanh toán phiếu',
      name: 'payment_bill',
      desc: '',
      args: [],
    );
  }

  /// `Thu Tiền bán hàng`
  String get collecting_sale {
    return Intl.message(
      'Thu Tiền bán hàng',
      name: 'collecting_sale',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng quét vân tay để đăng nhập ứng dụng (lưu ý: Quý khách có thể sử dụng Vân tay đã đăng ký thành công trên thiết bị)`
  String get title_dialog_touch_id {
    return Intl.message(
      'Vui lòng quét vân tay để đăng nhập ứng dụng (lưu ý: Quý khách có thể sử dụng Vân tay đã đăng ký thành công trên thiết bị)',
      name: 'title_dialog_touch_id',
      desc: '',
      args: [],
    );
  }

  /// `Bạn đã quá số lần vân tay. Vui lòng nhập Tên đăng nhập và Mật khẩu !`
  String get error_title_fingerprint {
    return Intl.message(
      'Bạn đã quá số lần vân tay. Vui lòng nhập Tên đăng nhập và Mật khẩu !',
      name: 'error_title_fingerprint',
      desc: '',
      args: [],
    );
  }

  /// `Bạn đã quá số lần FacID. Vui lòng nhập Tên đăng nhập và Mật khẩu !`
  String get error_title_face_id {
    return Intl.message(
      'Bạn đã quá số lần FacID. Vui lòng nhập Tên đăng nhập và Mật khẩu !',
      name: 'error_title_face_id',
      desc: '',
      args: [],
    );
  }

  /// `Tên đăng nhập`
  String get label_user_name {
    return Intl.message(
      'Tên đăng nhập',
      name: 'label_user_name',
      desc: '',
      args: [],
    );
  }

  /// `Tên đăng nhập không được để trống`
  String get label_user_name_empty {
    return Intl.message(
      'Tên đăng nhập không được để trống',
      name: 'label_user_name_empty',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu`
  String get label_password {
    return Intl.message(
      'Mật khẩu',
      name: 'label_password',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập`
  String get button_login {
    return Intl.message(
      'Đăng nhập',
      name: 'button_login',
      desc: '',
      args: [],
    );
  }

  /// `Duy trì đăng nhập`
  String get remember_pass {
    return Intl.message(
      'Duy trì đăng nhập',
      name: 'remember_pass',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu hiện tại`
  String get pass_current {
    return Intl.message(
      'Mật khẩu hiện tại',
      name: 'pass_current',
      desc: '',
      args: [],
    );
  }

  /// `Hoặc đăng nhập với`
  String get login_with {
    return Intl.message(
      'Hoặc đăng nhập với',
      name: 'login_with',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chưa có tài khoản? `
  String get no_account {
    return Intl.message(
      'Bạn chưa có tài khoản? ',
      name: 'no_account',
      desc: '',
      args: [],
    );
  }

  /// `Tạo tài khoản`
  String get create_account {
    return Intl.message(
      'Tạo tài khoản',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu mới`
  String get pass_new {
    return Intl.message(
      'Mật khẩu mới',
      name: 'pass_new',
      desc: '',
      args: [],
    );
  }

  /// `Nhập lại mật khẩu mới`
  String get confirm_pass_new {
    return Intl.message(
      'Nhập lại mật khẩu mới',
      name: 'confirm_pass_new',
      desc: '',
      args: [],
    );
  }

  /// ` <h3>Lưu ý</h3><a>Mật khẩu phải thoả mãn đủ 3 điều kiện sau:</a><ul><li>Phải có độ dài từ <b>8 ký tự trở lên</b></li><li><b>Không chứa khoảng trắng hay thông tin Tên đăng nhập</b></li><li><b>Chứa 3 trong 4 kiểu ký tự</b> (a – z, A – Z, 0 – 9, !@#$%^&*) </li></ul><a>Ví dụ: Ofit0722, Diary@Note</a>`
  String get note_change_password {
    return Intl.message(
      ' <h3>Lưu ý</h3><a>Mật khẩu phải thoả mãn đủ 3 điều kiện sau:</a><ul><li>Phải có độ dài từ <b>8 ký tự trở lên</b></li><li><b>Không chứa khoảng trắng hay thông tin Tên đăng nhập</b></li><li><b>Chứa 3 trong 4 kiểu ký tự</b> (a – z, A – Z, 0 – 9, !@#\$%^&*) </li></ul><a>Ví dụ: Ofit0722, Diary@Note</a>',
      name: 'note_change_password',
      desc: '',
      args: [],
    );
  }

  /// `Cài đặt`
  String get setting {
    return Intl.message(
      'Cài đặt',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Lưu ý`
  String get note {
    return Intl.message(
      'Lưu ý',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu phải thoả mãn đủ 3 điều kiện sau:`
  String get pass_have {
    return Intl.message(
      'Mật khẩu phải thoả mãn đủ 3 điều kiện sau:',
      name: 'pass_have',
      desc: '',
      args: [],
    );
  }

  /// `Phải có độ dài từ `
  String get pass_have_length {
    return Intl.message(
      'Phải có độ dài từ ',
      name: 'pass_have_length',
      desc: '',
      args: [],
    );
  }

  /// `8 ký tự trở lên`
  String get pass_have_length_8 {
    return Intl.message(
      '8 ký tự trở lên',
      name: 'pass_have_length_8',
      desc: '',
      args: [],
    );
  }

  /// `Không chứa khoảng trắng hay thông tin Tên đăng nhập`
  String get pass_have_not_contain_space {
    return Intl.message(
      'Không chứa khoảng trắng hay thông tin Tên đăng nhập',
      name: 'pass_have_not_contain_space',
      desc: '',
      args: [],
    );
  }

  /// `Chứa 3 trong 4 kiểu ký tự `
  String get pass_have_have {
    return Intl.message(
      'Chứa 3 trong 4 kiểu ký tự ',
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

  /// `Đăng xuất thành công!`
  String get logout_message {
    return Intl.message(
      'Đăng xuất thành công!',
      name: 'logout_message',
      desc: '',
      args: [],
    );
  }

  /// `Xin chào!`
  String get hi {
    return Intl.message(
      'Xin chào!',
      name: 'hi',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập bằng nhận diện khuôn mặt`
  String get face_login {
    return Intl.message(
      'Đăng nhập bằng nhận diện khuôn mặt',
      name: 'face_login',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập bằng vân tay`
  String get fingerprint_login {
    return Intl.message(
      'Đăng nhập bằng vân tay',
      name: 'fingerprint_login',
      desc: '',
      args: [],
    );
  }

  /// `Thiết bị chưa cài đặt FaceID`
  String get title_dialog_face_Id {
    return Intl.message(
      'Thiết bị chưa cài đặt FaceID',
      name: 'title_dialog_face_Id',
      desc: '',
      args: [],
    );
  }

  /// `Bạn muốn chuyển sang hình thức đăng nhập bằng FaceID?`
  String get title_dialog_face_Id_transfer {
    return Intl.message(
      'Bạn muốn chuyển sang hình thức đăng nhập bằng FaceID?',
      name: 'title_dialog_face_Id_transfer',
      desc: '',
      args: [],
    );
  }

  /// `Sử dụng tính năng đăng nhập FaceID giúp Bạn đăng nhập tài khoản nhanh chóng và an toàn.`
  String get text_dialog_face_Id_transfer {
    return Intl.message(
      'Sử dụng tính năng đăng nhập FaceID giúp Bạn đăng nhập tài khoản nhanh chóng và an toàn.',
      name: 'text_dialog_face_Id_transfer',
      desc: '',
      args: [],
    );
  }

  /// `Bạn muốn chuyển sang hình thức đăng nhập bằng vân tay?`
  String get title_dialog_fingerprint_transfer {
    return Intl.message(
      'Bạn muốn chuyển sang hình thức đăng nhập bằng vân tay?',
      name: 'title_dialog_fingerprint_transfer',
      desc: '',
      args: [],
    );
  }

  /// `Sử dụng tính năng đăng nhập vân tay giúp Bạn đăng nhập tài khoản nhanh chóng và an toàn.`
  String get text_dialog_fingerprint_transfer {
    return Intl.message(
      'Sử dụng tính năng đăng nhập vân tay giúp Bạn đăng nhập tài khoản nhanh chóng và an toàn.',
      name: 'text_dialog_fingerprint_transfer',
      desc: '',
      args: [],
    );
  }

  /// `Thiết bị chưa cài đặt vân tay`
  String get title_dialog_fingerprint {
    return Intl.message(
      'Thiết bị chưa cài đặt vân tay',
      name: 'title_dialog_fingerprint',
      desc: '',
      args: [],
    );
  }

  /// `Bạn vui lòng đăng nhập ứng dụng và sử dụng chức năng cài đặt vân tay để kích hoạt tính năng này.`
  String get text_dialog_fingerprint {
    return Intl.message(
      'Bạn vui lòng đăng nhập ứng dụng và sử dụng chức năng cài đặt vân tay để kích hoạt tính năng này.',
      name: 'text_dialog_fingerprint',
      desc: '',
      args: [],
    );
  }

  /// `Bạn vui lòng đăng nhập ứng dụng và sử dụng chức năng cài đặt FaceID để kích hoạt tính năng này.`
  String get text_dialog_face_Id {
    return Intl.message(
      'Bạn vui lòng đăng nhập ứng dụng và sử dụng chức năng cài đặt FaceID để kích hoạt tính năng này.',
      name: 'text_dialog_face_Id',
      desc: '',
      args: [],
    );
  }

  /// `Mã xác nhận`
  String get text_verification {
    return Intl.message(
      'Mã xác nhận',
      name: 'text_verification',
      desc: '',
      args: [],
    );
  }

  /// `Mã xác nhận không được để trống`
  String get text_verification_error {
    return Intl.message(
      'Mã xác nhận không được để trống',
      name: 'text_verification_error',
      desc: '',
      args: [],
    );
  }

  /// `Tên đăng nhập`
  String get login_user_name {
    return Intl.message(
      'Tên đăng nhập',
      name: 'login_user_name',
      desc: '',
      args: [],
    );
  }

  /// `AIBook đã gửi mã xác nhận đến địa chỉ email của bạn `
  String get text_send_to_email {
    return Intl.message(
      'AIBook đã gửi mã xác nhận đến địa chỉ email của bạn ',
      name: 'text_send_to_email',
      desc: '',
      args: [],
    );
  }

  /// `.Nếu không nhận được email bạn vui lòng ấn `
  String get text_check_emal {
    return Intl.message(
      '.Nếu không nhận được email bạn vui lòng ấn ',
      name: 'text_check_emal',
      desc: '',
      args: [],
    );
  }

  /// `Gửi mã xác thực`
  String get text_button_send {
    return Intl.message(
      'Gửi mã xác thực',
      name: 'text_button_send',
      desc: '',
      args: [],
    );
  }

  /// `Gửi lại`
  String get text_button_send_again {
    return Intl.message(
      'Gửi lại',
      name: 'text_button_send_again',
      desc: '',
      args: [],
    );
  }

  /// `Lưu mật khẩu`
  String get text_button_save {
    return Intl.message(
      'Lưu mật khẩu',
      name: 'text_button_save',
      desc: '',
      args: [],
    );
  }

  /// `Huỷ`
  String get text_button_cancle {
    return Intl.message(
      'Huỷ',
      name: 'text_button_cancle',
      desc: '',
      args: [],
    );
  }

  /// `Mã xác thực không đúng`
  String get text_confilm_opt_not {
    return Intl.message(
      'Mã xác thực không đúng',
      name: 'text_confilm_opt_not',
      desc: '',
      args: [],
    );
  }

  /// `Mã xác thực không hợp lệ.Vui lòng Nhập lại.`
  String get error_resetpasword {
    return Intl.message(
      'Mã xác thực không hợp lệ.Vui lòng Nhập lại.',
      name: 'error_resetpasword',
      desc: '',
      args: [],
    );
  }

  /// `Số tiền phải thanh toán`
  String get amount_to_be_paid {
    return Intl.message(
      'Số tiền phải thanh toán',
      name: 'amount_to_be_paid',
      desc: '',
      args: [],
    );
  }

  /// `Khách hàng còn nợ`
  String get customer_debt {
    return Intl.message(
      'Khách hàng còn nợ',
      name: 'customer_debt',
      desc: '',
      args: [],
    );
  }

  /// `Thanh toán`
  String get payment {
    return Intl.message(
      'Thanh toán',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Chi tiết HBTL`
  String get detail_HBTL {
    return Intl.message(
      'Chi tiết HBTL',
      name: 'detail_HBTL',
      desc: '',
      args: [],
    );
  }

  /// `Tổng tiền`
  String get sum_amount {
    return Intl.message(
      'Tổng tiền',
      name: 'sum_amount',
      desc: '',
      args: [],
    );
  }

  /// `Tiền khách hàng đưa`
  String get money_given_by_the_customer {
    return Intl.message(
      'Tiền khách hàng đưa',
      name: 'money_given_by_the_customer',
      desc: '',
      args: [],
    );
  }

  /// `Khách hàng nợ`
  String get debt_customer {
    return Intl.message(
      'Khách hàng nợ',
      name: 'debt_customer',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin Tài khoản hoặc mật khẩu không chính xác.Vui lòng nhập lại!`
  String get error_login {
    return Intl.message(
      'Thông tin Tài khoản hoặc mật khẩu không chính xác.Vui lòng nhập lại!',
      name: 'error_login',
      desc: '',
      args: [],
    );
  }

  /// `Không có mạng`
  String get no_internet {
    return Intl.message(
      'Không có mạng',
      name: 'no_internet',
      desc: '',
      args: [],
    );
  }

  /// `Hết thời gian chờ`
  String get connect_time_out {
    return Intl.message(
      'Hết thời gian chờ',
      name: 'connect_time_out',
      desc: '',
      args: [],
    );
  }

  /// `Có lỗi xảy ra`
  String get status_error {
    return Intl.message(
      'Có lỗi xảy ra',
      name: 'status_error',
      desc: '',
      args: [],
    );
  }

  /// `Khôi phục`
  String get restore {
    return Intl.message(
      'Khôi phục',
      name: 'restore',
      desc: '',
      args: [],
    );
  }

  /// `Lưu`
  String get save {
    return Intl.message(
      'Lưu',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Không có quyền`
  String get no_permission {
    return Intl.message(
      'Không có quyền',
      name: 'no_permission',
      desc: '',
      args: [],
    );
  }

  /// `Mặt hàng`
  String get list_item_title {
    return Intl.message(
      'Mặt hàng',
      name: 'list_item_title',
      desc: '',
      args: [],
    );
  }

  /// `Chi tiền`
  String get pay {
    return Intl.message(
      'Chi tiền',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Hàng bán trả lại`
  String get item_returned {
    return Intl.message(
      'Hàng bán trả lại',
      name: 'item_returned',
      desc: '',
      args: [],
    );
  }

  /// `Trả hàng nhập`
  String get return_purchase {
    return Intl.message(
      'Trả hàng nhập',
      name: 'return_purchase',
      desc: '',
      args: [],
    );
  }

  /// `Hạn: `
  String get term {
    return Intl.message(
      'Hạn: ',
      name: 'term',
      desc: '',
      args: [],
    );
  }

  /// `Còn lại`
  String get remaining {
    return Intl.message(
      'Còn lại',
      name: 'remaining',
      desc: '',
      args: [],
    );
  }

  /// `Thanh toán 1 phần: `
  String get one_part_payment {
    return Intl.message(
      'Thanh toán 1 phần: ',
      name: 'one_part_payment',
      desc: '',
      args: [],
    );
  }

  /// `Xác định được phiếu mua hàng`
  String get confirm_there_is_a_paper_buying {
    return Intl.message(
      'Xác định được phiếu mua hàng',
      name: 'confirm_there_is_a_paper_buying',
      desc: '',
      args: [],
    );
  }

  /// `Không xác định phiếu mua hàng`
  String get confirm_there_is_not_a_paper_buying {
    return Intl.message(
      'Không xác định phiếu mua hàng',
      name: 'confirm_there_is_not_a_paper_buying',
      desc: '',
      args: [],
    );
  }

  /// `Xác định được phiếu bán hàng`
  String get confirm_there_is_a_paper_sales {
    return Intl.message(
      'Xác định được phiếu bán hàng',
      name: 'confirm_there_is_a_paper_sales',
      desc: '',
      args: [],
    );
  }

  /// `Không xác định phiếu bán hàng`
  String get confirm_there_is_not_a_paper_sales {
    return Intl.message(
      'Không xác định phiếu bán hàng',
      name: 'confirm_there_is_not_a_paper_sales',
      desc: '',
      args: [],
    );
  }

  /// `Phiếu`
  String get paper {
    return Intl.message(
      'Phiếu',
      name: 'paper',
      desc: '',
      args: [],
    );
  }

  /// `Khách hàng`
  String get customer {
    return Intl.message(
      'Khách hàng',
      name: 'customer',
      desc: '',
      args: [],
    );
  }

  /// `Hạn thanh toán`
  String get payment_term {
    return Intl.message(
      'Hạn thanh toán',
      name: 'payment_term',
      desc: '',
      args: [],
    );
  }

  /// `Phiếu gốc`
  String get original_paper {
    return Intl.message(
      'Phiếu gốc',
      name: 'original_paper',
      desc: '',
      args: [],
    );
  }

  /// `Tổng thành tiền`
  String get sum_amounts {
    return Intl.message(
      'Tổng thành tiền',
      name: 'sum_amounts',
      desc: '',
      args: [],
    );
  }

  /// `Mặt hàng/Tổng số lượng`
  String get item_sum_amount {
    return Intl.message(
      'Mặt hàng/Tổng số lượng',
      name: 'item_sum_amount',
      desc: '',
      args: [],
    );
  }

  /// `Cộng tiền hàng`
  String get plus_money_item {
    return Intl.message(
      'Cộng tiền hàng',
      name: 'plus_money_item',
      desc: '',
      args: [],
    );
  }

  /// `Tiền thuế`
  String get tax_money {
    return Intl.message(
      'Tiền thuế',
      name: 'tax_money',
      desc: '',
      args: [],
    );
  }

  /// `Kho nhập`
  String get ware_house {
    return Intl.message(
      'Kho nhập',
      name: 'ware_house',
      desc: '',
      args: [],
    );
  }

  /// `Tạo tài khoản mới`
  String get create_new_account {
    return Intl.message(
      'Tạo tài khoản mới',
      name: 'create_new_account',
      desc: '',
      args: [],
    );
  }

  /// `Tạo tài khoản mới bằng`
  String get create_new_account_with {
    return Intl.message(
      'Tạo tài khoản mới bằng',
      name: 'create_new_account_with',
      desc: '',
      args: [],
    );
  }

  /// `Tạo một tài khoản AIBOOKS mới`
  String get create_new_account_ai_book {
    return Intl.message(
      'Tạo một tài khoản AIBOOKS mới',
      name: 'create_new_account_ai_book',
      desc: '',
      args: [],
    );
  }

  /// ` Google`
  String get google {
    return Intl.message(
      ' Google',
      name: 'google',
      desc: '',
      args: [],
    );
  }

  /// `Chào mừng `
  String get hello {
    return Intl.message(
      'Chào mừng ',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chỉ còn 1 bước nữa là có thể tạo tài khoản AI BOOK mới`
  String get text_hello {
    return Intl.message(
      'Bạn chỉ còn 1 bước nữa là có thể tạo tài khoản AI BOOK mới',
      name: 'text_hello',
      desc: '',
      args: [],
    );
  }

  /// `Tôi đồng ý với các `
  String get agree_terms {
    return Intl.message(
      'Tôi đồng ý với các ',
      name: 'agree_terms',
      desc: '',
      args: [],
    );
  }

  /// `Điều khoản dịch vụ `
  String get terms_of_service {
    return Intl.message(
      'Điều khoản dịch vụ ',
      name: 'terms_of_service',
      desc: '',
      args: [],
    );
  }

  /// `Chính sách về Quyền riêng tư `
  String get privacy_policy {
    return Intl.message(
      'Chính sách về Quyền riêng tư ',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `của công ty OfitSoft`
  String get of_ofit {
    return Intl.message(
      'của công ty OfitSoft',
      name: 'of_ofit',
      desc: '',
      args: [],
    );
  }

  /// `và `
  String get and {
    return Intl.message(
      'và ',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `Tạo tài khoản`
  String get button_create_account {
    return Intl.message(
      'Tạo tài khoản',
      name: 'button_create_account',
      desc: '',
      args: [],
    );
  }

  /// `Hãy nói cho Chúng tôi về Doanh nghiệp của Bạn, AIBOOKs sẽ tối ưu theo những gì Bạn nhập`
  String get text_update_account {
    return Intl.message(
      'Hãy nói cho Chúng tôi về Doanh nghiệp của Bạn, AIBOOKs sẽ tối ưu theo những gì Bạn nhập',
      name: 'text_update_account',
      desc: '',
      args: [],
    );
  }

  /// `Người liên hệ chính`
  String get text_contact_person {
    return Intl.message(
      'Người liên hệ chính',
      name: 'text_contact_person',
      desc: '',
      args: [],
    );
  }

  /// `Loại hình doanh nghiệp`
  String get text_type_of_business {
    return Intl.message(
      'Loại hình doanh nghiệp',
      name: 'text_type_of_business',
      desc: '',
      args: [],
    );
  }

  /// `Tên công ty`
  String get text_name_org {
    return Intl.message(
      'Tên công ty',
      name: 'text_name_org',
      desc: '',
      args: [],
    );
  }

  /// `Số điện thoại di động`
  String get text_phone_number {
    return Intl.message(
      'Số điện thoại di động',
      name: 'text_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Địa chỉ Email`
  String get text_email_adderss {
    return Intl.message(
      'Địa chỉ Email',
      name: 'text_email_adderss',
      desc: '',
      args: [],
    );
  }

  /// `Địa chỉ công ty`
  String get text_company_adderss {
    return Intl.message(
      'Địa chỉ công ty',
      name: 'text_company_adderss',
      desc: '',
      args: [],
    );
  }

  /// `Địa chỉ Website`
  String get text_website_address {
    return Intl.message(
      'Địa chỉ Website',
      name: 'text_website_address',
      desc: '',
      args: [],
    );
  }

  /// `Chủ tài khoản`
  String get text_bank_own {
    return Intl.message(
      'Chủ tài khoản',
      name: 'text_bank_own',
      desc: '',
      args: [],
    );
  }

  /// `Số tài khoản`
  String get text_bank_account {
    return Intl.message(
      'Số tài khoản',
      name: 'text_bank_account',
      desc: '',
      args: [],
    );
  }

  /// `Ngân hàng`
  String get text_bank_name {
    return Intl.message(
      'Ngân hàng',
      name: 'text_bank_name',
      desc: '',
      args: [],
    );
  }

  /// `Lưu lại và tiếp tục`
  String get button_save_continue {
    return Intl.message(
      'Lưu lại và tiếp tục',
      name: 'button_save_continue',
      desc: '',
      args: [],
    );
  }

  /// `Công ty`
  String get text_company {
    return Intl.message(
      'Công ty',
      name: 'text_company',
      desc: '',
      args: [],
    );
  }

  /// `Hộ gia đình/Cá nhân`
  String get text_household_individual {
    return Intl.message(
      'Hộ gia đình/Cá nhân',
      name: 'text_household_individual',
      desc: '',
      args: [],
    );
  }

  /// `SDT nhập không đúng. Bạn vui lòng kiểm tra lại !`
  String get phone_error {
    return Intl.message(
      'SDT nhập không đúng. Bạn vui lòng kiểm tra lại !',
      name: 'phone_error',
      desc: '',
      args: [],
    );
  }

  /// `Địa chỉ email nhập không đúng. Bạn vui lòng kiểm tra lại !`
  String get email_error {
    return Intl.message(
      'Địa chỉ email nhập không đúng. Bạn vui lòng kiểm tra lại !',
      name: 'email_error',
      desc: '',
      args: [],
    );
  }

  /// `Mã số thuế nhập không đúng định dạng !`
  String get tax_code_error {
    return Intl.message(
      'Mã số thuế nhập không đúng định dạng !',
      name: 'tax_code_error',
      desc: '',
      args: [],
    );
  }

  /// `Cấu hình kế toán`
  String get text_accountant {
    return Intl.message(
      'Cấu hình kế toán',
      name: 'text_accountant',
      desc: '',
      args: [],
    );
  }

  /// `Năm tài chính`
  String get financial_year {
    return Intl.message(
      'Năm tài chính',
      name: 'financial_year',
      desc: '',
      args: [],
    );
  }

  /// `Tiền tệ`
  String get currency {
    return Intl.message(
      'Tiền tệ',
      name: 'currency',
      desc: '',
      args: [],
    );
  }

  /// `Định dạng ngày`
  String get date_format {
    return Intl.message(
      'Định dạng ngày',
      name: 'date_format',
      desc: '',
      args: [],
    );
  }

  /// `Định dạng Số`
  String get number_format_type {
    return Intl.message(
      'Định dạng Số',
      name: 'number_format_type',
      desc: '',
      args: [],
    );
  }

  /// `Quản lý Kho`
  String get inventory_management {
    return Intl.message(
      'Quản lý Kho',
      name: 'inventory_management',
      desc: '',
      args: [],
    );
  }

  /// `PP Xuất kho`
  String get export_method {
    return Intl.message(
      'PP Xuất kho',
      name: 'export_method',
      desc: '',
      args: [],
    );
  }

  /// `Thông tư thuế`
  String get circulars {
    return Intl.message(
      'Thông tư thuế',
      name: 'circulars',
      desc: '',
      args: [],
    );
  }

  /// `PP Kê khai Thuế`
  String get tax_declaration {
    return Intl.message(
      'PP Kê khai Thuế',
      name: 'tax_declaration',
      desc: '',
      args: [],
    );
  }

  /// `Kỳ tính Thuế`
  String get tax_period {
    return Intl.message(
      'Kỳ tính Thuế',
      name: 'tax_period',
      desc: '',
      args: [],
    );
  }

  /// `Quy trình duyệt`
  String get browsing_process {
    return Intl.message(
      'Quy trình duyệt',
      name: 'browsing_process',
      desc: '',
      args: [],
    );
  }

  /// `Xuất Kho âm`
  String get negative_inventory {
    return Intl.message(
      'Xuất Kho âm',
      name: 'negative_inventory',
      desc: '',
      args: [],
    );
  }

  /// `Chế độ kế toán và Cấu hình`
  String get accounting_system {
    return Intl.message(
      'Chế độ kế toán và Cấu hình',
      name: 'accounting_system',
      desc: '',
      args: [],
    );
  }

  /// `Sửa chế độ kế toán`
  String get edit_accounting_system {
    return Intl.message(
      'Sửa chế độ kế toán',
      name: 'edit_accounting_system',
      desc: '',
      args: [],
    );
  }

  /// `Tài khoản`
  String get account {
    return Intl.message(
      'Tài khoản',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Bạn hãy chọn tài khoản đăng nhập`
  String get choose_account {
    return Intl.message(
      'Bạn hãy chọn tài khoản đăng nhập',
      name: 'choose_account',
      desc: '',
      args: [],
    );
  }

  /// `Mã số thuế`
  String get tax_code {
    return Intl.message(
      'Mã số thuế',
      name: 'tax_code',
      desc: '',
      args: [],
    );
  }

  /// `SDT`
  String get phone_contact {
    return Intl.message(
      'SDT',
      name: 'phone_contact',
      desc: '',
      args: [],
    );
  }

  /// `SDT liên hệ khác`
  String get phone_contact_other {
    return Intl.message(
      'SDT liên hệ khác',
      name: 'phone_contact_other',
      desc: '',
      args: [],
    );
  }

  /// `Website`
  String get Website {
    return Intl.message(
      'Website',
      name: 'Website',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin khác`
  String get info_other {
    return Intl.message(
      'Thông tin khác',
      name: 'info_other',
      desc: '',
      args: [],
    );
  }

  /// `Tài khoản ngân hàng`
  String get bank_account {
    return Intl.message(
      'Tài khoản ngân hàng',
      name: 'bank_account',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin tài khoản`
  String get info_account {
    return Intl.message(
      'Thông tin tài khoản',
      name: 'info_account',
      desc: '',
      args: [],
    );
  }

  /// `Sửa thông tin tài khoản`
  String get edit_info_account {
    return Intl.message(
      'Sửa thông tin tài khoản',
      name: 'edit_info_account',
      desc: '',
      args: [],
    );
  }

  /// `Sửa cấu hình`
  String get edit_config {
    return Intl.message(
      'Sửa cấu hình',
      name: 'edit_config',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu hiện tại`
  String get pass_now {
    return Intl.message(
      'Mật khẩu hiện tại',
      name: 'pass_now',
      desc: '',
      args: [],
    );
  }

  /// `Lưu thay đổi`
  String get save_change {
    return Intl.message(
      'Lưu thay đổi',
      name: 'save_change',
      desc: '',
      args: [],
    );
  }

  /// `Địa chỉ`
  String get label_address {
    return Intl.message(
      'Địa chỉ',
      name: 'label_address',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Đổi mật khẩu`
  String get change_password {
    return Intl.message(
      'Đổi mật khẩu',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Còn nợ: `
  String get remain_money {
    return Intl.message(
      'Còn nợ: ',
      name: 'remain_money',
      desc: '',
      args: [],
    );
  }

  /// `Ngày CT: `
  String get time_ct {
    return Intl.message(
      'Ngày CT: ',
      name: 'time_ct',
      desc: '',
      args: [],
    );
  }

  /// `Tổng tiền: `
  String get sum_money {
    return Intl.message(
      'Tổng tiền: ',
      name: 'sum_money',
      desc: '',
      args: [],
    );
  }

  /// `Hạn TT`
  String get deadline_tt {
    return Intl.message(
      'Hạn TT',
      name: 'deadline_tt',
      desc: '',
      args: [],
    );
  }

  /// `Tồn`
  String get inventory {
    return Intl.message(
      'Tồn',
      name: 'inventory',
      desc: '',
      args: [],
    );
  }

  /// `Cộng tiền hàng`
  String get sum_item_money {
    return Intl.message(
      'Cộng tiền hàng',
      name: 'sum_item_money',
      desc: '',
      args: [],
    );
  }

  /// `Tổng thanh toán`
  String get sum_payment {
    return Intl.message(
      'Tổng thanh toán',
      name: 'sum_payment',
      desc: '',
      args: [],
    );
  }

  /// `Chiết khấu`
  String get discount {
    return Intl.message(
      'Chiết khấu',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Xem chứng từ`
  String get view_license {
    return Intl.message(
      'Xem chứng từ',
      name: 'view_license',
      desc: '',
      args: [],
    );
  }

  /// `Tổng số `
  String get sum {
    return Intl.message(
      'Tổng số ',
      name: 'sum',
      desc: '',
      args: [],
    );
  }

  /// `Chứng từ bị trả lại`
  String get license_remain {
    return Intl.message(
      'Chứng từ bị trả lại',
      name: 'license_remain',
      desc: '',
      args: [],
    );
  }

  /// `Giá: `
  String get price {
    return Intl.message(
      'Giá: ',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `SL còn lại`
  String get amount_in_warehouse {
    return Intl.message(
      'SL còn lại',
      name: 'amount_in_warehouse',
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

  /// `Bán hàng`
  String get sales_slip {
    return Intl.message(
      'Bán hàng',
      name: 'sales_slip',
      desc: '',
      args: [],
    );
  }

  /// `Tổng số @ phiếu`
  String get sum_amount_slip {
    return Intl.message(
      'Tổng số @ phiếu',
      name: 'sum_amount_slip',
      desc: '',
      args: [],
    );
  }

  /// `thùng`
  String get bin {
    return Intl.message(
      'thùng',
      name: 'bin',
      desc: '',
      args: [],
    );
  }

  /// `Chọn mặt hàng`
  String get select_item {
    return Intl.message(
      'Chọn mặt hàng',
      name: 'select_item',
      desc: '',
      args: [],
    );
  }

  /// `Chọn ảnh`
  String get pick_a_photo {
    return Intl.message(
      'Chọn ảnh',
      name: 'pick_a_photo',
      desc: '',
      args: [],
    );
  }

  /// `Chụp ảnh`
  String get from_camera {
    return Intl.message(
      'Chụp ảnh',
      name: 'from_camera',
      desc: '',
      args: [],
    );
  }

  /// `Bộ sưu tập`
  String get from_library {
    return Intl.message(
      'Bộ sưu tập',
      name: 'from_library',
      desc: '',
      args: [],
    );
  }

  /// `Tên đơn vị`
  String get name_company {
    return Intl.message(
      'Tên đơn vị',
      name: 'name_company',
      desc: '',
      args: [],
    );
  }

  /// `Có`
  String get yes {
    return Intl.message(
      'Có',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Không`
  String get no {
    return Intl.message(
      'Không',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Tiếp`
  String get continues {
    return Intl.message(
      'Tiếp',
      name: 'continues',
      desc: '',
      args: [],
    );
  }

  /// `Cho phép xuất kho `
  String get allow_negative_export {
    return Intl.message(
      'Cho phép xuất kho ',
      name: 'allow_negative_export',
      desc: '',
      args: [],
    );
  }

  /// `Âm`
  String get am {
    return Intl.message(
      'Âm',
      name: 'am',
      desc: '',
      args: [],
    );
  }

  /// `Có quy trình kiểm duyệt`
  String get censorship_process {
    return Intl.message(
      'Có quy trình kiểm duyệt',
      name: 'censorship_process',
      desc: '',
      args: [],
    );
  }

  /// `Ngày CT:`
  String get date_ct {
    return Intl.message(
      'Ngày CT:',
      name: 'date_ct',
      desc: '',
      args: [],
    );
  }

  /// `Số tiền:`
  String get number_money {
    return Intl.message(
      'Số tiền:',
      name: 'number_money',
      desc: '',
      args: [],
    );
  }

  /// `Chứng từ được thanh toán:`
  String get payment_vouchers {
    return Intl.message(
      'Chứng từ được thanh toán:',
      name: 'payment_vouchers',
      desc: '',
      args: [],
    );
  }

  /// `Tổng số`
  String get amount_number {
    return Intl.message(
      'Tổng số',
      name: 'amount_number',
      desc: '',
      args: [],
    );
  }

  /// `Thêm mới thu tiền`
  String get add_new_payment {
    return Intl.message(
      'Thêm mới thu tiền',
      name: 'add_new_payment',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin thanh toán`
  String get information_payment {
    return Intl.message(
      'Thông tin thanh toán',
      name: 'information_payment',
      desc: '',
      args: [],
    );
  }

  /// `Thu tiền`
  String get collect_money {
    return Intl.message(
      'Thu tiền',
      name: 'collect_money',
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

  /// `Mua hàng`
  String get sell_label {
    return Intl.message(
      'Mua hàng',
      name: 'sell_label',
      desc: '',
      args: [],
    );
  }

  /// `Bán Hàng`
  String get buy_label {
    return Intl.message(
      'Bán Hàng',
      name: 'buy_label',
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

  /// `Nhiều hơn`
  String get more_label {
    return Intl.message(
      'Nhiều hơn',
      name: 'more_label',
      desc: '',
      args: [],
    );
  }

  /// `Tạo bán hàng`
  String get create_sell_label {
    return Intl.message(
      'Tạo bán hàng',
      name: 'create_sell_label',
      desc: '',
      args: [],
    );
  }

  /// `Tạo mua hàng`
  String get create_buy_label {
    return Intl.message(
      'Tạo mua hàng',
      name: 'create_buy_label',
      desc: '',
      args: [],
    );
  }

  /// `Tạo mặt hàng`
  String get create_item_label {
    return Intl.message(
      'Tạo mặt hàng',
      name: 'create_item_label',
      desc: '',
      args: [],
    );
  }

  /// `Tạo khách hàng`
  String get create_customer_label {
    return Intl.message(
      'Tạo khách hàng',
      name: 'create_customer_label',
      desc: '',
      args: [],
    );
  }

  /// `Tạo nhà cung cấp`
  String get create_supply_label {
    return Intl.message(
      'Tạo nhà cung cấp',
      name: 'create_supply_label',
      desc: '',
      args: [],
    );
  }

  /// `Doanh thu bán hàng`
  String get doanh_thu_label {
    return Intl.message(
      'Doanh thu bán hàng',
      name: 'doanh_thu_label',
      desc: '',
      args: [],
    );
  }

  /// `Số phiếu bán hàng`
  String get so_phieu_label {
    return Intl.message(
      'Số phiếu bán hàng',
      name: 'so_phieu_label',
      desc: '',
      args: [],
    );
  }

  /// `Tiền thu được`
  String get tien_thu_label {
    return Intl.message(
      'Tiền thu được',
      name: 'tien_thu_label',
      desc: '',
      args: [],
    );
  }

  /// `Tiền chi`
  String get tien_chi_label {
    return Intl.message(
      'Tiền chi',
      name: 'tien_chi_label',
      desc: '',
      args: [],
    );
  }

  /// `TÌNH HÌNH HOẠT ĐỘNG HÔM NAY`
  String get report_home_label {
    return Intl.message(
      'TÌNH HÌNH HOẠT ĐỘNG HÔM NAY',
      name: 'report_home_label',
      desc: '',
      args: [],
    );
  }

  /// `CHỌN ĐƠN VỊ HIỂN THỊ`
  String get change_units_label {
    return Intl.message(
      'CHỌN ĐƠN VỊ HIỂN THỊ',
      name: 'change_units_label',
      desc: '',
      args: [],
    );
  }

  /// `Thêm mặt hàng`
  String get add_item_tile {
    return Intl.message(
      'Thêm mặt hàng',
      name: 'add_item_tile',
      desc: '',
      args: [],
    );
  }

  /// `Sửa mặt hàng`
  String get edit_item_title {
    return Intl.message(
      'Sửa mặt hàng',
      name: 'edit_item_title',
      desc: '',
      args: [],
    );
  }

  /// `Bạn phải nhập đủ thông tin vào các trường bắt buộc (có *)!`
  String get error_validate_add_item {
    return Intl.message(
      'Bạn phải nhập đủ thông tin vào các trường bắt buộc (có *)!',
      name: 'error_validate_add_item',
      desc: '',
      args: [],
    );
  }

  /// `Thêm thành công mặt hàng`
  String get success_mess_add_item {
    return Intl.message(
      'Thêm thành công mặt hàng',
      name: 'success_mess_add_item',
      desc: '',
      args: [],
    );
  }

  /// `Loại mặt hàng`
  String get type_item_label {
    return Intl.message(
      'Loại mặt hàng',
      name: 'type_item_label',
      desc: '',
      args: [],
    );
  }

  /// `Tên mặt hàng`
  String get name_item_label {
    return Intl.message(
      'Tên mặt hàng',
      name: 'name_item_label',
      desc: '',
      args: [],
    );
  }

  /// `Mã SKU`
  String get sku_item_label {
    return Intl.message(
      'Mã SKU',
      name: 'sku_item_label',
      desc: '',
      args: [],
    );
  }

  /// `Mã vạch`
  String get bar_code_item_label {
    return Intl.message(
      'Mã vạch',
      name: 'bar_code_item_label',
      desc: '',
      args: [],
    );
  }

  /// `Giá bán`
  String get price_item_label {
    return Intl.message(
      'Giá bán',
      name: 'price_item_label',
      desc: '',
      args: [],
    );
  }

  /// `Giá mua`
  String get cost_item_label {
    return Intl.message(
      'Giá mua',
      name: 'cost_item_label',
      desc: '',
      args: [],
    );
  }

  /// `Thuế`
  String get tax_item_label {
    return Intl.message(
      'Thuế',
      name: 'tax_item_label',
      desc: '',
      args: [],
    );
  }

  /// `Đơn vị tính`
  String get unit_item_label {
    return Intl.message(
      'Đơn vị tính',
      name: 'unit_item_label',
      desc: '',
      args: [],
    );
  }

  /// `Hệ số`
  String get coef_item_label {
    return Intl.message(
      'Hệ số',
      name: 'coef_item_label',
      desc: '',
      args: [],
    );
  }

  /// `Ảnh :`
  String get image_item_label {
    return Intl.message(
      'Ảnh :',
      name: 'image_item_label',
      desc: '',
      args: [],
    );
  }

  /// `Thuộc tính`
  String get attr_item_label {
    return Intl.message(
      'Thuộc tính',
      name: 'attr_item_label',
      desc: '',
      args: [],
    );
  }

  /// `Tạo mặt hàng chi tiết`
  String get create_item_detail_label {
    return Intl.message(
      'Tạo mặt hàng chi tiết',
      name: 'create_item_detail_label',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chưa nhập tên mặt hàng`
  String get error_validate_name_item {
    return Intl.message(
      'Bạn chưa nhập tên mặt hàng',
      name: 'error_validate_name_item',
      desc: '',
      args: [],
    );
  }

  /// `Mặt hàng`
  String get items {
    return Intl.message(
      'Mặt hàng',
      name: 'items',
      desc: '',
      args: [],
    );
  }

  /// `Cài đặt đăng nhập`
  String get text_setting_login {
    return Intl.message(
      'Cài đặt đăng nhập',
      name: 'text_setting_login',
      desc: '',
      args: [],
    );
  }

  /// `Sinh trắc học và bảo mật`
  String get Biometrics_security {
    return Intl.message(
      'Sinh trắc học và bảo mật',
      name: 'Biometrics_security',
      desc: '',
      args: [],
    );
  }

  /// `Ngôn ngữ`
  String get language {
    return Intl.message(
      'Ngôn ngữ',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Tiếng Việt`
  String get vietnamese {
    return Intl.message(
      'Tiếng Việt',
      name: 'vietnamese',
      desc: '',
      args: [],
    );
  }

  /// `Tiếng Anh`
  String get english {
    return Intl.message(
      'Tiếng Anh',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Phiên bản phần mềm `
  String get version {
    return Intl.message(
      'Phiên bản phần mềm ',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Phiên bản mới nhất `
  String get version_new {
    return Intl.message(
      'Phiên bản mới nhất ',
      name: 'version_new',
      desc: '',
      args: [],
    );
  }

  /// ` phát hành ngày `
  String get version_new_time {
    return Intl.message(
      ' phát hành ngày ',
      name: 'version_new_time',
      desc: '',
      args: [],
    );
  }

  /// `Cập nhật phần mềm`
  String get update_version {
    return Intl.message(
      'Cập nhật phần mềm',
      name: 'update_version',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập thông tin tìm kiếm`
  String get please_enter_info_search {
    return Intl.message(
      'Vui lòng nhập thông tin tìm kiếm',
      name: 'please_enter_info_search',
      desc: '',
      args: [],
    );
  }

  /// `Không có kết quả phù hợp với`
  String get not_search_match_result {
    return Intl.message(
      'Không có kết quả phù hợp với',
      name: 'not_search_match_result',
      desc: '',
      args: [],
    );
  }

  /// `Thu gọn<<`
  String get collapse {
    return Intl.message(
      'Thu gọn<<',
      name: 'collapse',
      desc: '',
      args: [],
    );
  }

  /// `Xem thêm>>`
  String get extend {
    return Intl.message(
      'Xem thêm>>',
      name: 'extend',
      desc: '',
      args: [],
    );
  }

  /// `Loại hình doanh nghiệp`
  String get org_type {
    return Intl.message(
      'Loại hình doanh nghiệp',
      name: 'org_type',
      desc: '',
      args: [],
    );
  }

  /// `Tổng số @ mặt hàng`
  String get sum_amount_item {
    return Intl.message(
      'Tổng số @ mặt hàng',
      name: 'sum_amount_item',
      desc: '',
      args: [],
    );
  }

  /// `Thêm Logo`
  String get add_logo {
    return Intl.message(
      'Thêm Logo',
      name: 'add_logo',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng kiểm tra Email  này để lấy mã và nhập vào bên dưới.`
  String get check_email {
    return Intl.message(
      'Vui lòng kiểm tra Email  này để lấy mã và nhập vào bên dưới.',
      name: 'check_email',
      desc: '',
      args: [],
    );
  }

  /// `Mã xác thực không đúng định dạng.Vui lòng kiểm tra lại`
  String get error_otp_length {
    return Intl.message(
      'Mã xác thực không đúng định dạng.Vui lòng kiểm tra lại',
      name: 'error_otp_length',
      desc: '',
      args: [],
    );
  }

  /// `Doanh thu`
  String get turnover {
    return Intl.message(
      'Doanh thu',
      name: 'turnover',
      desc: '',
      args: [],
    );
  }

  /// `Chi phí`
  String get cost {
    return Intl.message(
      'Chi phí',
      name: 'cost',
      desc: '',
      args: [],
    );
  }

  /// `Tạo đơn hàng`
  String get create_order {
    return Intl.message(
      'Tạo đơn hàng',
      name: 'create_order',
      desc: '',
      args: [],
    );
  }

  /// `Sửa`
  String get edit {
    return Intl.message(
      'Sửa',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Nhân viên`
  String get employee {
    return Intl.message(
      'Nhân viên',
      name: 'employee',
      desc: '',
      args: [],
    );
  }

  /// `Chọn chứng từ`
  String get select_ct {
    return Intl.message(
      'Chọn chứng từ',
      name: 'select_ct',
      desc: '',
      args: [],
    );
  }

  /// `kho`
  String get warehouse {
    return Intl.message(
      'kho',
      name: 'warehouse',
      desc: '',
      args: [],
    );
  }

  /// `Cấn trừ nợ`
  String get Debt_deduction {
    return Intl.message(
      'Cấn trừ nợ',
      name: 'Debt_deduction',
      desc: '',
      args: [],
    );
  }

  /// `Báo cáo`
  String get report {
    return Intl.message(
      'Báo cáo',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `Nhà cung cấp`
  String get supplier {
    return Intl.message(
      'Nhà cung cấp',
      name: 'supplier',
      desc: '',
      args: [],
    );
  }

  /// `Nhân viên`
  String get Staff {
    return Intl.message(
      'Nhân viên',
      name: 'Staff',
      desc: '',
      args: [],
    );
  }

  /// `Bảng lương`
  String get payroll {
    return Intl.message(
      'Bảng lương',
      name: 'payroll',
      desc: '',
      args: [],
    );
  }

  /// `Kiểm kê kho`
  String get inventory_check {
    return Intl.message(
      'Kiểm kê kho',
      name: 'inventory_check',
      desc: '',
      args: [],
    );
  }

  /// `Trống`
  String get empty {
    return Intl.message(
      'Trống',
      name: 'empty',
      desc: '',
      args: [],
    );
  }

  /// `Đặt lại mật khẩu không thành công !`
  String get pasword_failure {
    return Intl.message(
      'Đặt lại mật khẩu không thành công !',
      name: 'pasword_failure',
      desc: '',
      args: [],
    );
  }

  /// `Đặt lại mật khẩu thành công !`
  String get pasword_successful {
    return Intl.message(
      'Đặt lại mật khẩu thành công !',
      name: 'pasword_successful',
      desc: '',
      args: [],
    );
  }

  /// `Xóa thông tin kho`
  String get delete_warehouse {
    return Intl.message(
      'Xóa thông tin kho',
      name: 'delete_warehouse',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc chắn muốn xoá kho`
  String get sure_delete_warehouse {
    return Intl.message(
      'Bạn có chắc chắn muốn xoá kho',
      name: 'sure_delete_warehouse',
      desc: '',
      args: [],
    );
  }

  /// `Bạn hãy chọn 1 trong 2 phương thức xoá dưới đây`
  String get choose_delete_warehouse {
    return Intl.message(
      'Bạn hãy chọn 1 trong 2 phương thức xoá dưới đây',
      name: 'choose_delete_warehouse',
      desc: '',
      args: [],
    );
  }

  /// `Xóa khỏi hệ thống`
  String get delete_warehouse_system {
    return Intl.message(
      'Xóa khỏi hệ thống',
      name: 'delete_warehouse_system',
      desc: '',
      args: [],
    );
  }

  /// `Xóa cho phép khôi phục`
  String get delete_warehouse_restore {
    return Intl.message(
      'Xóa cho phép khôi phục',
      name: 'delete_warehouse_restore',
      desc: '',
      args: [],
    );
  }

  /// `Thêm kho`
  String get text_add_warehouse {
    return Intl.message(
      'Thêm kho',
      name: 'text_add_warehouse',
      desc: '',
      args: [],
    );
  }

  /// `Sửa thông tin kho`
  String get text_edit_warehouse {
    return Intl.message(
      'Sửa thông tin kho',
      name: 'text_edit_warehouse',
      desc: '',
      args: [],
    );
  }

  /// `Kho`
  String get text_warehouse {
    return Intl.message(
      'Kho',
      name: 'text_warehouse',
      desc: '',
      args: [],
    );
  }

  /// `Mã kho`
  String get code_warehouse {
    return Intl.message(
      'Mã kho',
      name: 'code_warehouse',
      desc: '',
      args: [],
    );
  }

  /// `Tên kho`
  String get name_warehouse {
    return Intl.message(
      'Tên kho',
      name: 'name_warehouse',
      desc: '',
      args: [],
    );
  }

  /// `Địa chỉ`
  String get adderss {
    return Intl.message(
      'Địa chỉ',
      name: 'adderss',
      desc: '',
      args: [],
    );
  }

  /// `Tổng tồn: `
  String get total_damage {
    return Intl.message(
      'Tổng tồn: ',
      name: 'total_damage',
      desc: '',
      args: [],
    );
  }

  /// `Giá: `
  String get cost_price {
    return Intl.message(
      'Giá: ',
      name: 'cost_price',
      desc: '',
      args: [],
    );
  }

  /// `Thêm ảnh mặt hàng`
  String get add_img_item {
    return Intl.message(
      'Thêm ảnh mặt hàng',
      name: 'add_img_item',
      desc: '',
      args: [],
    );
  }

  /// `Ngày tạo phiếu`
  String get date_create {
    return Intl.message(
      'Ngày tạo phiếu',
      name: 'date_create',
      desc: '',
      args: [],
    );
  }

  /// `Xong`
  String get done {
    return Intl.message(
      'Xong',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Phiếu mua hàng`
  String get vouchers {
    return Intl.message(
      'Phiếu mua hàng',
      name: 'vouchers',
      desc: '',
      args: [],
    );
  }

  /// `Phiếu bán hàng`
  String get sales_order {
    return Intl.message(
      'Phiếu bán hàng',
      name: 'sales_order',
      desc: '',
      args: [],
    );
  }

  /// `Cập nhật thu tiền`
  String get payment_update {
    return Intl.message(
      'Cập nhật thu tiền',
      name: 'payment_update',
      desc: '',
      args: [],
    );
  }

  /// `Cập nhật chi tiền`
  String get collect_money_payment_update {
    return Intl.message(
      'Cập nhật chi tiền',
      name: 'collect_money_payment_update',
      desc: '',
      args: [],
    );
  }

  /// `Thêm mới chi tiền`
  String get more_money_to_spend {
    return Intl.message(
      'Thêm mới chi tiền',
      name: 'more_money_to_spend',
      desc: '',
      args: [],
    );
  }

  /// `Kiểm kê tồn kho`
  String get inventory_check_warehouse {
    return Intl.message(
      'Kiểm kê tồn kho',
      name: 'inventory_check_warehouse',
      desc: '',
      args: [],
    );
  }

  /// `Đến ngày`
  String get to_date {
    return Intl.message(
      'Đến ngày',
      name: 'to_date',
      desc: '',
      args: [],
    );
  }

  /// `Tồn hệ thống`
  String get system_inventory {
    return Intl.message(
      'Tồn hệ thống',
      name: 'system_inventory',
      desc: '',
      args: [],
    );
  }

  /// `Chênh lệch`
  String get deviant {
    return Intl.message(
      'Chênh lệch',
      name: 'deviant',
      desc: '',
      args: [],
    );
  }

  /// `Total {total} pay slips`
  String total_pay_slips(int total) {
    return Intl.message(
      'Total $total pay slips',
      name: 'total_pay_slips',
      desc: '',
      args: [total],
    );
  }

  /// `Total {total} suppliers`
  String total_suppliers(int total) {
    return Intl.message(
      'Total $total suppliers',
      name: 'total_suppliers',
      desc: '',
      args: [total],
    );
  }

  /// `Total {total} employees`
  String total_employees(int total) {
    return Intl.message(
      'Total $total employees',
      name: 'total_employees',
      desc: '',
      args: [total],
    );
  }

  /// `Transaction information`
  String get transaction_info {
    return Intl.message(
      'Transaction information',
      name: 'transaction_info',
      desc: '',
      args: [],
    );
  }

  /// `Supplier name`
  String get supplier_name {
    return Intl.message(
      'Supplier name',
      name: 'supplier_name',
      desc: '',
      args: [],
    );
  }

  /// `Total sale orders`
  String get total_sale_orders {
    return Intl.message(
      'Total sale orders',
      name: 'total_sale_orders',
      desc: '',
      args: [],
    );
  }

  /// `Purchase costs`
  String get purchase_costs {
    return Intl.message(
      'Purchase costs',
      name: 'purchase_costs',
      desc: '',
      args: [],
    );
  }

  /// `Debts`
  String get debts {
    return Intl.message(
      'Debts',
      name: 'debts',
      desc: '',
      args: [],
    );
  }

  /// `Total revenue`
  String get total_revenue {
    return Intl.message(
      'Total revenue',
      name: 'total_revenue',
      desc: '',
      args: [],
    );
  }

  /// `Total expenditure`
  String get total_expenditure {
    return Intl.message(
      'Total expenditure',
      name: 'total_expenditure',
      desc: '',
      args: [],
    );
  }

  /// `Bạn đang quét `
  String get you_scanning {
    return Intl.message(
      'Bạn đang quét ',
      name: 'you_scanning',
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

  /// ` không phải `
  String get not {
    return Intl.message(
      ' không phải ',
      name: 'not',
      desc: '',
      args: [],
    );
  }

  /// `, Xin vui lòng thực hiện lại.`
  String get please_re {
    return Intl.message(
      ', Xin vui lòng thực hiện lại.',
      name: 'please_re',
      desc: '',
      args: [],
    );
  }

  /// `Bạn đang quét qrcode không phải là barcode.Xin vui lòng thực hiện lại.`
  String get barcode_error {
    return Intl.message(
      'Bạn đang quét qrcode không phải là barcode.Xin vui lòng thực hiện lại.',
      name: 'barcode_error',
      desc: '',
      args: [],
    );
  }

  /// `Bạn đang quét barcode không phải là qrcode.Xin vui lòng thực hiện lại.`
  String get qrcode_error {
    return Intl.message(
      'Bạn đang quét barcode không phải là qrcode.Xin vui lòng thực hiện lại.',
      name: 'qrcode_error',
      desc: '',
      args: [],
    );
  }

  /// `Đã thanh toán`
  String get paid {
    return Intl.message(
      'Đã thanh toán',
      name: 'paid',
      desc: '',
      args: [],
    );
  }

  /// `Chưa thanh toán`
  String get unpaid {
    return Intl.message(
      'Chưa thanh toán',
      name: 'unpaid',
      desc: '',
      args: [],
    );
  }

  /// `Thanh toán một phần`
  String get partial_payment {
    return Intl.message(
      'Thanh toán một phần',
      name: 'partial_payment',
      desc: '',
      args: [],
    );
  }

  /// `Giỏ hàng`
  String get cart {
    return Intl.message(
      'Giỏ hàng',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Quét mã`
  String get code_scan {
    return Intl.message(
      'Quét mã',
      name: 'code_scan',
      desc: '',
      args: [],
    );
  }

  /// `không tồn tại, vui lòng thử lại`
  String get code_not_exist {
    return Intl.message(
      'không tồn tại, vui lòng thử lại',
      name: 'code_not_exist',
      desc: '',
      args: [],
    );
  }

  /// `Nhập mã`
  String get insert_code {
    return Intl.message(
      'Nhập mã',
      name: 'insert_code',
      desc: '',
      args: [],
    );
  }

  /// `Mã`
  String get code {
    return Intl.message(
      'Mã',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Số điện thoại không được trống`
  String get phone_unable_to_empty {
    return Intl.message(
      'Số điện thoại không được trống',
      name: 'phone_unable_to_empty',
      desc: '',
      args: [],
    );
  }

  /// `Mã khách hàng`
  String get customer_code {
    return Intl.message(
      'Mã khách hàng',
      name: 'customer_code',
      desc: '',
      args: [],
    );
  }

  /// `Tên khách hàng`
  String get customer_name {
    return Intl.message(
      'Tên khách hàng',
      name: 'customer_name',
      desc: '',
      args: [],
    );
  }

  /// `Mã nhà cung cấp`
  String get supplier_code {
    return Intl.message(
      'Mã nhà cung cấp',
      name: 'supplier_code',
      desc: '',
      args: [],
    );
  }

  /// `Thêm nhà cung cấp`
  String get add_supplier {
    return Intl.message(
      'Thêm nhà cung cấp',
      name: 'add_supplier',
      desc: '',
      args: [],
    );
  }

  /// `Sửa thông tin nhà cung cấp`
  String get change_supplier_info {
    return Intl.message(
      'Sửa thông tin nhà cung cấp',
      name: 'change_supplier_info',
      desc: '',
      args: [],
    );
  }

  /// `Mã số thuế không hợp lệ`
  String get invalid_tax_code {
    return Intl.message(
      'Mã số thuế không hợp lệ',
      name: 'invalid_tax_code',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chưa tick chọn Đồng ý với các Điều khoản Dịch vụ và Chính sách về Quyền riêng tư của công ty OFITSOFT.`
  String get check_box_agree {
    return Intl.message(
      'Bạn chưa tick chọn Đồng ý với các Điều khoản Dịch vụ và Chính sách về Quyền riêng tư của công ty OFITSOFT.',
      name: 'check_box_agree',
      desc: '',
      args: [],
    );
  }

  /// `Đổi thông tin thành công`
  String get change_info_success {
    return Intl.message(
      'Đổi thông tin thành công',
      name: 'change_info_success',
      desc: '',
      args: [],
    );
  }

  /// `PHIẾU`
  String get promissory_note {
    return Intl.message(
      'PHIẾU',
      name: 'promissory_note',
      desc: '',
      args: [],
    );
  }

  /// `Bộ Lọc`
  String get filter {
    return Intl.message(
      'Bộ Lọc',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Tổng số phiếu đã chọn: @`
  String get select_amount_slip {
    return Intl.message(
      'Tổng số phiếu đã chọn: @',
      name: 'select_amount_slip',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc chắn muốn xóa ảnh này không ?`
  String get you_sure_want_delete_image {
    return Intl.message(
      'Bạn có chắc chắn muốn xóa ảnh này không ?',
      name: 'you_sure_want_delete_image',
      desc: '',
      args: [],
    );
  }

  /// `Thêm Khách hàng`
  String get add_customer {
    return Intl.message(
      'Thêm Khách hàng',
      name: 'add_customer',
      desc: '',
      args: [],
    );
  }

  /// `Thêm phiếu kiểm kê thành công`
  String get success_add_inventory {
    return Intl.message(
      'Thêm phiếu kiểm kê thành công',
      name: 'success_add_inventory',
      desc: '',
      args: [],
    );
  }

  /// `Cập nhật phiếu kiểm kê thành công`
  String get success_update_inventory {
    return Intl.message(
      'Cập nhật phiếu kiểm kê thành công',
      name: 'success_update_inventory',
      desc: '',
      args: [],
    );
  }

  /// `Tên nhà cung cấp không được trống`
  String get supplier_name_empty {
    return Intl.message(
      'Tên nhà cung cấp không được trống',
      name: 'supplier_name_empty',
      desc: '',
      args: [],
    );
  }

  /// `Tên nhà cung cấp phải có độ dài trong khoảng 3 - 325 ký tự`
  String get supplier_name_rule {
    return Intl.message(
      'Tên nhà cung cấp phải có độ dài trong khoảng 3 - 325 ký tự',
      name: 'supplier_name_rule',
      desc: '',
      args: [],
    );
  }

  /// `Địa chỉ không được trống`
  String get address_empty {
    return Intl.message(
      'Địa chỉ không được trống',
      name: 'address_empty',
      desc: '',
      args: [],
    );
  }

  /// `Thành tiền`
  String get into_money {
    return Intl.message(
      'Thành tiền',
      name: 'into_money',
      desc: '',
      args: [],
    );
  }

  /// `Tổng tiền hàng`
  String get total_amount {
    return Intl.message(
      'Tổng tiền hàng',
      name: 'total_amount',
      desc: '',
      args: [],
    );
  }

  /// `Một trong các email không hợp lệ, vui lòng kiểm tra lại`
  String get emails_error_notification {
    return Intl.message(
      'Một trong các email không hợp lệ, vui lòng kiểm tra lại',
      name: 'emails_error_notification',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập ít nhất 1 email`
  String get emails_empty_notification {
    return Intl.message(
      'Vui lòng nhập ít nhất 1 email',
      name: 'emails_empty_notification',
      desc: '',
      args: [],
    );
  }

  /// `Số điện thoại cố định`
  String get landline_number {
    return Intl.message(
      'Số điện thoại cố định',
      name: 'landline_number',
      desc: '',
      args: [],
    );
  }

  /// `Cần ít nhất một số điện thoại`
  String get least_one_phone_number {
    return Intl.message(
      'Cần ít nhất một số điện thoại',
      name: 'least_one_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Số điện thoại không đúng định dạng`
  String get phone_incorrect_format {
    return Intl.message(
      'Số điện thoại không đúng định dạng',
      name: 'phone_incorrect_format',
      desc: '',
      args: [],
    );
  }

  /// `Ngưng sử dụng`
  String get stop_using {
    return Intl.message(
      'Ngưng sử dụng',
      name: 'stop_using',
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
