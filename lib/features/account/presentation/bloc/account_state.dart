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
  final List<WalletTransaction> transactions;
  final List<UserAddress> addresses;
  
  const AccountLoaded({
    required this.accountInfo, 
    this.transactions = const [],
    this.addresses = const [],
  });

  @override
  List<Object> get props => [accountInfo, transactions, addresses];
}

class AccountError extends AccountState {
  final String message;
  const AccountError(this.message);

  @override
  List<Object> get props => [message];
}

class RechargeSuccess extends AccountState {}

class UpgradePlanSuccess extends AccountState {}
