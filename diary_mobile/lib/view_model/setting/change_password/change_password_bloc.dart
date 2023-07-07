import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../generated/l10n.dart';
import '../../../utils/change_password_status.dart';
import '../../../utils/validator.dart';
import '../../bloc_event.dart';
import '../../bloc_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  //final Repository repository;
  final BuildContext context;
  final bool isCreate; // tao mat khau
  final bool isFirst; // thay doi mat khau lan dau

  ChangePasswordBloc(this.context,
      {this.isCreate = false, this.isFirst = false})
      : super(ChangePasswordState()) {
    on<SubmissionChangePassword>(_submissionChangePassword);
    on<SubmissionCreatePassword>(_submissionCreatePassword);
    on<ValidatePassNew>(_validatePass);
    // on<Logout>(_logout);
  }

  void _submissionChangePassword(
      SubmissionChangePassword event, Emitter<ChangePasswordState> emit) async {
    //emit(state.copyWith(formStatus: ChangingPassword()));
/*    int changePasswordOk =
    await repository.changePassword(event.passwordOld, event.passwordNew);*/
    emit(state.copyWith(
        formStatus: ChangePasswordSuccess(""),
        code: 1));
  }

  void _submissionCreatePassword(
      SubmissionCreatePassword event, Emitter<ChangePasswordState> emit) async {
    //emit(state.copyWith(formStatus: ChangingPassword()));
/*    int changePasswordOk =
    await repository.createPassword(event.passwordNew, isFirst: isFirst);*/
    emit(state.copyWith(
        formStatus: ChangePasswordSuccess(""),
        code: 1));
  }

  FutureOr<void> _validatePass(
      ValidatePassNew event, Emitter<ChangePasswordState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String errorPassOld = "";
    String errorPassNew = "";
    String errorConfirmPassNew = "";
    if (event.passNew == event.passCurrent && event.passCurrent.isNotEmpty) {
      errorPassNew = S.of(event.context).pass_duplicate;
    }
    if(Validator.validatePassLength(event.passCurrent) == false&&event.passCurrent.isNotEmpty){
      errorPassOld=S.of(context).error_pass_length;
    }
    if(event.passNew.isNotEmpty){
      if (Validator.validateFormatPassWord(event.passNew) == false) {
        if (Validator.validateFormatPassWord(event.passNew) == false) {
          if (Validator.validatePassLength(event.passNew) == false) {
            errorPassNew = S.of(event.context).error_pass_length;
          } else {
            errorPassNew = S.of(event.context).pass_format_wrong;
          }
        }
      }}
    if (event.passNewConfirm.isNotEmpty &&
        event.passNewConfirm != event.passNew) {
      errorConfirmPassNew = S.of(event.context).pass_not_same_new_pass;
    }
    emit(state.copyWith(
        formStatus:
        ValidatePassFail(errorPassOld, errorPassNew, errorConfirmPassNew)));
    if (errorPassNew == "" &&
        errorConfirmPassNew == "" &&
        event.submit == true) {
      if(isCreate){
        add(SubmissionCreatePassword(event.passNew));
      } else {
        add(SubmissionChangePassword(event.passCurrent, event.passNew));
      }
    }
  }
}

class ChangePasswordEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class SubmissionChangePassword extends ChangePasswordEvent {
  final String passwordOld;
  final String passwordNew;

  SubmissionChangePassword(this.passwordOld, this.passwordNew);

  @override
  List<Object?> get props => [passwordOld, passwordNew];
}

class SubmissionCreatePassword extends ChangePasswordEvent {
  final String passwordNew;

  SubmissionCreatePassword(this.passwordNew);

  @override
  List<Object?> get props => [passwordNew];
}

class ValidatePassNew extends ChangePasswordEvent {
  final String passCurrent;
  final String passNew;
  final String passNewConfirm;
  final bool submit;
  BuildContext context;

  ValidatePassNew(
      {required this.passCurrent,
        required this.passNew,
        required this.passNewConfirm,
        this.submit = false,
        required this.context});

  @override
  List<Object?> get props =>
      [passCurrent, passNew, passNewConfirm, submit, context];
}

class ChangePasswordState extends BlocState {
  @override
  List<Object?> get props => [formStatus, statusCode];

  final FormChangePasswordStatus formStatus;
  final int statusCode;

  ChangePasswordState(
      {this.formStatus = const ChangeFormStatus(), this.statusCode = 0});

  ChangePasswordState copyWith({
    FormChangePasswordStatus? formStatus,
    int? code,
  }) {
    return ChangePasswordState(
        formStatus: formStatus ?? const ChangeFormStatus(),
        statusCode: code ?? statusCode);
  }
}
