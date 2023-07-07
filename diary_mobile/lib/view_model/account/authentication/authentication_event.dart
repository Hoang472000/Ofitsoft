
import '../../../app_main.dart';
import '../../bloc_event.dart';

class AuthenticationEvent extends BlocEvent {

  @override
  List<Object?> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {

  final AuthenticationStatus status;

  AuthenticationStatusChanged(this.status);

  @override
  List<Object> get props => [status];
}





