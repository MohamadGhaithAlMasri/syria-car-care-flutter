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
  final String phoneNumber;

  const AuthSignUpWithEmailPasswordEvent(this.email, this.password, this.name, this.phoneNumber);

  @override
  List<Object> get props => [email, password, name, phoneNumber];
}

class AuthSignInWithEmailPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthSignInWithEmailPasswordEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
