part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class GetAccountInfoEvent extends AccountEvent {}

class GetTransactionsEvent extends AccountEvent {}

class RechargeWalletEvent extends AccountEvent {
  final double amount;
  final String method;

  const RechargeWalletEvent({required this.amount, required this.method});

  @override
  List<Object> get props => [amount, method];
}
