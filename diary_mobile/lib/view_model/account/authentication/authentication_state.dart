import '../../../data/repository.dart';
import '../../bloc_state.dart';

///Bkav DucLQ khi vao ung dung xe check cac trang thai xac thuc cua tai khoan de
class AuthenticationState extends BlocState {
  @override
  List<Object?> get props => [status];

  final AuthenticationStatus status;

  AuthenticationState._({this.status = AuthenticationStatus.unknown});

  AuthenticationState.unknown() : this._();

  AuthenticationState.authenticated()
      : this._(status: AuthenticationStatus.authenticated);

  AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);
}
