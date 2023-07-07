import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/forget_password_status.dart';
import '../../utils/logger.dart';
import '../../view_model/bloc_event.dart';
import '../../view_model/bloc_state.dart';



class GetOtpBloc
    extends Bloc<GetOtpEvent, SubmissionOtpState> {



  GetOtpBloc()
      : super(SubmissionOtpState()) {
    on<SubmissionOtpEvent>(_submissionGetOtp);
    //add(ForgetPasswordEvent());
  }

  void _submissionGetOtp(SubmissionOtpEvent event,
      Emitter<SubmissionOtpState> emit) async {
/*    GetOtpInfo getOtpInfo = await repository.restoreOtp(
        event.userName);
    emit(state.copyWith(otpp: getOtpInfo.otp, formStatus: getOtpInfo.isOk
        ? ForgetPasswordSuccess(getOtpInfo.otp,"")
        : ForgetPasswordFailed(getOtpInfo.otp)));
    Logger.loggerDebug(
        "Call Api ForgetPassword restorePasswordInfo: ${getOtpInfo.otp.toString()} ");*/
  }
}

class GetOtpEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class SubmissionOtpEvent extends GetOtpEvent {
  final String userName;

  SubmissionOtpEvent(this.userName);

  @override
  List<Object?> get props => [];
}

class SubmissionOtpState extends BlocState {
  @override
  List<Object?> get props => [formStatus];

  final String otp;
  final FormForgetPasswordStatus formStatus;

  SubmissionOtpState({this.otp="", this.formStatus = const ForgetFormStatus()});

  SubmissionOtpState copyWith({
    FormForgetPasswordStatus? formStatus, String? otpp
  }) {
    return SubmissionOtpState(formStatus: formStatus ?? this.formStatus, otp: otpp?? otp);
  }
}
