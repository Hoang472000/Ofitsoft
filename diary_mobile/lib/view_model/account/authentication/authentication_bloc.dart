import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_main.dart';
import '../../../utils/logger.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc():
        super(AuthenticationState.unknown()) {
    // Dang ky de xu ly cac event, khi nhan event thi goi ham de xu ly
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    // Thuc hien xu ly de lang nghe status luon ngay khi vao app, sau khi nhan duoc
    // status tu repository thi emit event AuthenticationStatusChanged voi data = status
    add(AuthenticationStatusChanged(AuthenticationStatus.authenticated));
  }


/*  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;*/

  void _onAuthenticationStatusChanged(AuthenticationStatusChanged event,
      Emitter<AuthenticationState> emit) async {
    await Future.delayed(const Duration(seconds: 3));
    Logger.loggerDebug("nhungltk onAuthenticationStatusChanged: ${event.status}");
    switch (event.status) {
      case AuthenticationStatus.authenticated:
        return emit( AuthenticationState.authenticated());
      case AuthenticationStatus.unauthenticated:
        return emit(AuthenticationState.unauthenticated());
      default:
        return emit(AuthenticationState.unknown());
    }
  }

  @override
  Future<void> close() {
    //Huy dang ky steam
    return super.close();
  }

}
