part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final AccountInfo accountInfo;
  const AccountLoaded(this.accountInfo);

  @override
  List<Object> get props => [accountInfo];
}

class AccountError extends AccountState {
  final String message;
  const AccountError(this.message);

  @override
  List<Object> get props => [message];
}
