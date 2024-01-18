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

  /// `Huỷ`
  String get cancel {
    return Intl.message(
      'Huỷ',
      name: 'cancel',
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

  /// `Quét mã thành công`
  String get scan_success {
    return Intl.message(
      'Quét mã thành công',
      name: 'scan_success',
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

  /// `Lưu mật khẩu`
  String get text_button_save {
    return Intl.message(
      'Lưu mật khẩu',
      name: 'text_button_save',
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

  /// `Ví dụ: Ofit2023, Ofit@Soft`
  String get pass_have_vd {
    return Intl.message(
      'Ví dụ: Ofit2023, Ofit@Soft',
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

  /// `VND`
  String get vnd {
    return Intl.message(
      'VND',
      name: 'vnd',
      desc: '',
      args: [],
    );
  }

  /// `Chọn ảnh/video`
  String get pick_a_photo {
    return Intl.message(
      'Chọn ảnh/video',
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

  /// `Trống`
  String get empty {
    return Intl.message(
      'Trống',
      name: 'empty',
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

  /// `Mã`
  String get code {
    return Intl.message(
      'Mã',
      name: 'code',
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

  /// `Hỗ trợ`
  String get support {
    return Intl.message(
      'Hỗ trợ',
      name: 'support',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin tài khoản`
  String get account_information {
    return Intl.message(
      'Thông tin tài khoản',
      name: 'account_information',
      desc: '',
      args: [],
    );
  }

  /// `Dữ liệu không hợp lệ! \nVui lòng kiểm tra lại.`
  String get invalid_data {
    return Intl.message(
      'Dữ liệu không hợp lệ! \nVui lòng kiểm tra lại.',
      name: 'invalid_data',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin ứng dụng`
  String get application_information {
    return Intl.message(
      'Thông tin ứng dụng',
      name: 'application_information',
      desc: '',
      args: [],
    );
  }

  /// `Danh sách thông báo`
  String get notification_list {
    return Intl.message(
      'Danh sách thông báo',
      name: 'notification_list',
      desc: '',
      args: [],
    );
  }

  /// `Nhật ký`
  String get diary {
    return Intl.message(
      'Nhật ký',
      name: 'diary',
      desc: '',
      args: [],
    );
  }

  /// `Danh sách nhật ký`
  String get list_diary {
    return Intl.message(
      'Danh sách nhật ký',
      name: 'list_diary',
      desc: '',
      args: [],
    );
  }

  /// `Nhật ký ghi hộ`
  String get diary_support {
    return Intl.message(
      'Nhật ký ghi hộ',
      name: 'diary_support',
      desc: '',
      args: [],
    );
  }

  /// `Tính năng`
  String get feature {
    return Intl.message(
      'Tính năng',
      name: 'feature',
      desc: '',
      args: [],
    );
  }

  /// `Giao dịch mua hàng`
  String get purchase_transaction {
    return Intl.message(
      'Giao dịch mua hàng',
      name: 'purchase_transaction',
      desc: '',
      args: [],
    );
  }

  /// `Đánh giá khảo sát`
  String get survey_review {
    return Intl.message(
      'Đánh giá khảo sát',
      name: 'survey_review',
      desc: '',
      args: [],
    );
  }

  /// `Đánh giá & khảo sát`
  String get survey_reviews {
    return Intl.message(
      'Đánh giá & khảo sát',
      name: 'survey_reviews',
      desc: '',
      args: [],
    );
  }

  /// `Truy xuất`
  String get trace {
    return Intl.message(
      'Truy xuất',
      name: 'trace',
      desc: '',
      args: [],
    );
  }

  /// `Truy xuất nguồn gốc`
  String get traceability {
    return Intl.message(
      'Truy xuất nguồn gốc',
      name: 'traceability',
      desc: '',
      args: [],
    );
  }

  /// `Ghi nhật ký`
  String get create_diary {
    return Intl.message(
      'Ghi nhật ký',
      name: 'create_diary',
      desc: '',
      args: [],
    );
  }

  /// `Trao đổi`
  String get communication {
    return Intl.message(
      'Trao đổi',
      name: 'communication',
      desc: '',
      args: [],
    );
  }

  /// `Hướng dẫn`
  String get er_manual {
    return Intl.message(
      'Hướng dẫn',
      name: 'er_manual',
      desc: '',
      args: [],
    );
  }

  /// `Hướng dẫn sử dụng`
  String get user_manual {
    return Intl.message(
      'Hướng dẫn sử dụng',
      name: 'user_manual',
      desc: '',
      args: [],
    );
  }

  /// `Liên hệ`
  String get contact {
    return Intl.message(
      'Liên hệ',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin phản hồi`
  String get feedback_information {
    return Intl.message(
      'Thông tin phản hồi',
      name: 'feedback_information',
      desc: '',
      args: [],
    );
  }

  /// `Bộ lọc tìm kiếm`
  String get search_filters {
    return Intl.message(
      'Bộ lọc tìm kiếm',
      name: 'search_filters',
      desc: '',
      args: [],
    );
  }

  /// `Khoảng thời gian`
  String get interval {
    return Intl.message(
      'Khoảng thời gian',
      name: 'interval',
      desc: '',
      args: [],
    );
  }

  /// `Lọc theo`
  String get filter_list {
    return Intl.message(
      'Lọc theo',
      name: 'filter_list',
      desc: '',
      args: [],
    );
  }

  /// `Số tiền`
  String get amount_of_money {
    return Intl.message(
      'Số tiền',
      name: 'amount_of_money',
      desc: '',
      args: [],
    );
  }

  /// `Số lượng`
  String get amount {
    return Intl.message(
      'Số lượng',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Áp dụng`
  String get apply {
    return Intl.message(
      'Áp dụng',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Thiết lập lại`
  String get reset {
    return Intl.message(
      'Thiết lập lại',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Tìm kiếm`
  String get search {
    return Intl.message(
      'Tìm kiếm',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc chắn muốn xóa ảnh này?`
  String get you_sure_want_delete_image {
    return Intl.message(
      'Bạn có chắc chắn muốn xóa ảnh này?',
      name: 'you_sure_want_delete_image',
      desc: '',
      args: [],
    );
  }

  /// `Bạn đang quét qrcode chứ không phải mã vạch. Vui lòng thử lại.`
  String get barcode_error {
    return Intl.message(
      'Bạn đang quét qrcode chứ không phải mã vạch. Vui lòng thử lại.',
      name: 'barcode_error',
      desc: '',
      args: [],
    );
  }

  /// `Bạn đang quét mã vạch chứ không phải qrcode. Vui lòng thử lại.`
  String get qrcode_error {
    return Intl.message(
      'Bạn đang quét mã vạch chứ không phải qrcode. Vui lòng thử lại.',
      name: 'qrcode_error',
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

  /// `Đổi mật khẩu`
  String get change_password {
    return Intl.message(
      'Đổi mật khẩu',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Lịch sử hoạt động`
  String get history_activity {
    return Intl.message(
      'Lịch sử hoạt động',
      name: 'history_activity',
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
