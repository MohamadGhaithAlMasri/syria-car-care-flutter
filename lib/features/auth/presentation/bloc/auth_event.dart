part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSignUpWithEmailPasswordEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;

  const AuthSignUpWithEmailPasswordEvent(this.email, this.password, this.name);

  @override
  List<Object> get props => [email, password, name];
}

class AuthSignInWithEmailPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthSignInWithEmailPasswordEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
