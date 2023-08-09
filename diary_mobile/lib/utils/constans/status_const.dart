class StatusConst {
  // trang thai cua phieu
  static const int paid = 3; // trang thai da thanh toan
  static const int partialPayment = 2; // trang thai thanh toán 1 phần
  static const int unpaid = 1; // trang thai Chua thanh toan

  // trang thai sever tra ve
  static const String code00 = "00"; // Thành công - có dữ liệu
  static const String code01 = "01"; // Dữ liệu không hợp lệ
  static const String code02 = "02"; // Không có dữ liệu
  static const String code03 = "03"; // Token hết hạn/Sai token/Lỗi token
  static const String code05 = "05"; // Lỗi hệ thống
  static const String code06 = "06"; // Mất kết nối mạng
  static const String code07 = "07"; // Kết nối quá hạn
  static const String code08 = "08"; // Lỗi không xác định

 //trang thai xoa phieu kiem kho
  static const int deleteFromSystem= 1;
  static const int deleteAllowRestore= 2;
}
