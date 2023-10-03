part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class AuthSignIn extends AuthEvent {
  const AuthSignIn({
    required this.name,
    required this.email,
    required this.password,
    this.oAuth = true,
    this.signUp = false,
  });

  final String name;
  final String email;
  final String password;
  final bool oAuth;
  final bool signUp;
}

class AuthSignOut extends AuthEvent {
  const AuthSignOut({this.forced = false});

  final bool forced;
}
