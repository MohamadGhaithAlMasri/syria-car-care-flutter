import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/account_info.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<LoadAccountEvent>((event, emit) async {
      emit(AccountLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(
        const AccountLoaded(
          AccountInfo(name: 'User', email: 'user@example.com', balance: 0.0),
        ),
      );
    });
  }
}
