import 'dart:async';
import 'package:diary_mobile/data/remote_data/object_model/object_result.dart';

/// Bkav DucLQ cac trang thai xac thuc cua tai khoan
enum AuthenticationStatus { unknown, authenticated, unauthenticated }

///
/// Bkav HoangLD cac trang thai khi lay mat khau dang nhap tai khoan bang biometric
enum GetPasswordBiometricStatus { successful, failure, moreThan3, none }

///
abstract class Repository {
  final controllerAuthentication = StreamController<AuthenticationStatus>();
  final controllerCheckTime = StreamController<bool>();


  Stream<AuthenticationStatus> get status async* {
    await Future.delayed(const Duration(seconds: 2));
    bool isExpToken = await checkExpToken();
    yield !isExpToken
        ? AuthenticationStatus.unauthenticated
        : AuthenticationStatus.authenticated;
    yield* controllerAuthentication.stream;
  }

  void dispose() {
    controllerAuthentication.close();
    controllerCheckTime.close();
  }

  /// kiem tra xem token con han khong
  Future<bool> checkExpToken();

  Future<ObjectResult> login(String userName, String pass);


}
