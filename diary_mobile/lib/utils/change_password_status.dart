abstract class FormChangePasswordStatus {
  const FormChangePasswordStatus();
}

class ChangeFormStatus extends FormChangePasswordStatus {
  const ChangeFormStatus();
}
class ChangeFormSubmitting extends FormChangePasswordStatus {}

class ChangePasswordSuccess extends FormChangePasswordStatus {
  final String message;
  ChangePasswordSuccess(this.message);
}

class ChangePasswordFailed extends FormChangePasswordStatus {
  final String stringError;

  ChangePasswordFailed(this.stringError);
}

class ValidatePassFail extends FormChangePasswordStatus{
  final String errorPassCurrent;
  final String errorPassNew;
  final String errorPassNewConfirm;
  ValidatePassFail(this.errorPassCurrent, this.errorPassNew, this.errorPassNewConfirm);
}

class ValidatePassSuccess extends FormChangePasswordStatus{}