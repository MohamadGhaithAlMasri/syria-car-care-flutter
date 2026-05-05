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

class UpgradePlanEvent extends AccountEvent {
  final String planName;
  final double price;

  const UpgradePlanEvent({required this.planName, required this.price});

  @override
  List<Object> get props => [planName, price];
}

class UploadAvatarEvent extends AccountEvent {
  final String filePath;

  const UploadAvatarEvent({required this.filePath});

  @override
  List<Object> get props => [filePath];
}

class GetAddressesEvent extends AccountEvent {}

class SaveAddressEvent extends AccountEvent {
  final UserAddress address;

  const SaveAddressEvent(this.address);

  @override
  List<Object> get props => [address];
}
