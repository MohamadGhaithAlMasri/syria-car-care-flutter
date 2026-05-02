import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/sign_in_with_email_password.dart';
import '../../domain/usecases/sign_up_with_email_password.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final SignUpWithEmailPassword signUpWithEmailPassword;
  final SignInWithEmailPassword signInWithEmailPassword;

  AuthBloc({
    required this.signUpWithEmailPassword,
    required this.signInWithEmailPassword,
  }) : super(AuthInitial()) {

    on<AuthSignUpWithEmailPasswordEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await signUpWithEmailPassword(event.email, event.password, event.name);
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (user) => emit(AuthSuccess(user)),
      );
    });

    on<AuthSignInWithEmailPasswordEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await signInWithEmailPassword(event.email, event.password);
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (user) => emit(AuthSuccess(user)),
      );
    });
  }
}
