abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class SubmissionSuccess extends FormSubmissionStatus {
  final String? success;

  SubmissionSuccess({this.success});
}
class SubmissionSuccessDelete extends FormSubmissionStatus {
  final String? success;

  SubmissionSuccessDelete({this.success});
}

class SubmissionFailed extends FormSubmissionStatus {
  final String exception;
  static String exceptionString = "exception";

  SubmissionFailed(this.exception);
}

class SubmissionBiometricFailed extends FormSubmissionStatus {
  final String exception;

  SubmissionBiometricFailed(this.exception);
}
class ValidatePassFail extends FormSubmissionStatus{
  final String errorOrgTaxCode;
  final String errorOrgPhone;
  final String errorOrgMail;
  ValidatePassFail(this.errorOrgTaxCode, this.errorOrgPhone, this.errorOrgMail);
}
class ValidatePasswordFail extends FormSubmissionStatus{
  final String errorUsername;
  final String errorPassNew;
  final String errorPassNewConfirm;
  ValidatePasswordFail(this.errorUsername, this.errorPassNew, this.errorPassNewConfirm);
}
class ValidateWarehousedFail extends FormSubmissionStatus{
  final String errWarehouseCode;
  final String errWarehouseName;
  final String errWarehouseAddress;
  ValidateWarehousedFail(this.errWarehouseCode, this.errWarehouseName, this.errWarehouseAddress);
}