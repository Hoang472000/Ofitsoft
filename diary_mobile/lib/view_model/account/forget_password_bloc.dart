import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';
import '../../utils/constants/shared_preferences_key.dart';
import '../../utils/status/forget_password_status.dart';
import '../../utils/validator.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';



class ForgetPasswordBloc
    extends Bloc<CreatePasswordNewEvent, CreatePasswordNewState> {
  //final Repository repository;


  ForgetPasswordBloc()
      : super(CreatePasswordNewState()) {
    on<CreatePassNewEvent>(_changePasswordNew);
    on<ValidatePassNew>(_validatePass);
    //add(ForgetPasswordEvent());
  }

  void _changePasswordNew(CreatePassNewEvent event,
      Emitter<CreatePasswordNewState> emit) async {
/*    ChangePasswordInfo changePasswordInfo = await repository.createPasswordNew(event.userName, event.otp,event.passnew);
    emit(state.copyWith(datahtml: changePasswordInfo.message, formStatus: changePasswordInfo.isOk
        ? ForgetPasswordSuccess(changePasswordInfo.message,event.passnew)
        : ForgetPasswordFailed(changePasswordInfo.message)));*/
  }
  FutureOr<void> _validatePass(
      ValidatePassNew event, Emitter<CreatePasswordNewState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String errorPassNew = "";
    String errorConfirmPassNew = "";

      // if (Validator.validatorOtp(event.otp) == false) {
      //   errorotp = S.of(event.context).error_otp_length;
      // }
      if (Validator.validateFormatPass(event.passNew) == false) {
        if (Validator.validateFormatPass(event.passNew) == false) {
          if (Validator.validatePassLength(event.passNew) == false) {
            errorPassNew = S.of(event.context).error_pass_length;
          } else if (event.passNew
              .contains(prefs.getString(SharedPreferencesKey.userName)!) ==
              true) {
            errorPassNew = S.of(event.context).error_pass_contain_space_info;
          } else {
            errorPassNew = S.of(event.context).pass_format_wrong;
          }
        }
      }
      if (event.passNewConfirm.isNotEmpty && event.passNewConfirm != event.passNew) {
        errorConfirmPassNew = S.of(event.context).pass_not_same_new_pass;
      }

    emit(state.copyWith(
        formStatus: ValidatePassFail( errorPassNew, errorConfirmPassNew)));
    if ( errorPassNew == "" && errorConfirmPassNew == "" && event.submit==true) {
      add(CreatePassNewEvent(event.username,event.otp, event.passNew));
    }

  }
}

class CreatePasswordNewEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class CreatePassNewEvent extends CreatePasswordNewEvent {
  final String userName;
  final String passnew;
  final String otp;

  CreatePassNewEvent(this.userName, this.otp, this.passnew);

  @override
  List<Object?> get props => [];
}
class CreatePasswordNewState extends BlocState {
  @override
  List<Object?> get props => [formStatus];

  final String data;
  final String passnew;
  final FormForgetPasswordStatus formStatus;

  CreatePasswordNewState({this.data="",this.passnew="", this.formStatus = const ForgetFormStatus()});

  CreatePasswordNewState copyWith({
    FormForgetPasswordStatus? formStatus, String? datahtml,String? passwordnew
  }) {
    return CreatePasswordNewState(formStatus: formStatus ?? this.formStatus, data: datahtml?? data,passnew:passwordnew??passnew);
  }
}
class ValidatePassNew extends CreatePasswordNewEvent {
  final String username;
  final String otp;
  final String passNew;
  final String passNewConfirm;
  final bool submit;
  BuildContext context;

  ValidatePassNew(
      {required this.username,
        required this.otp,
        required this.passNew,
        required this.passNewConfirm,
        this.submit= false,
        required this.context});

  @override
  List<Object?> get props => [];
}