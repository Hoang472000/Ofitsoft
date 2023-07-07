abstract class FormForgetPasswordStatus {
  const FormForgetPasswordStatus();
}

class ForgetFormStatus extends FormForgetPasswordStatus {
  const ForgetFormStatus();
}

class ForgetPasswordSuccess extends FormForgetPasswordStatus {
  final String message;
  final String passnew;
  ForgetPasswordSuccess(this.message, this.passnew);
}

class ForgetPasswordFailed extends FormForgetPasswordStatus {
  final String stringError;

  ForgetPasswordFailed(this.stringError);
}
class ValidatePassFail extends FormForgetPasswordStatus{

  final String errorPassNew;
  final String errorPassNewConfirm;
  ValidatePassFail( this.errorPassNew, this.errorPassNewConfirm);
}

class ValidatePassSuccess extends FormForgetPasswordStatus{}