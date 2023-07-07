class StatusConst {
  // trang thai cua phieu
  static const int paid = 3; // trang thai da thanh toan
  static const int partialPayment = 2; // trang thai thanh toán 1 phần
  static const int unpaid = 1; // trang thai Chua thanh toan

  // trang thai cua kieu thanh toan
  static const String tm = "TM"; // kieu thanh toan tien mat
  static const String the = "THE"; // kieu thanh toan thẻ
  static const String ck = "CK"; // kieu thanh toan chuyen khoan
  static const String ctcn = "CTCN"; // kieu thanh toan Can tru cong no

 //trang thai xoa phieu kiem kho
  static const int deleteFromSystem= 1;
  static const int deleteAllowRestore= 2;
}
