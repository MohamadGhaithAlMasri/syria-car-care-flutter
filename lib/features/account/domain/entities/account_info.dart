import 'package:equatable/equatable.dart';

class AccountInfo extends Equatable {
  final String name;
  final String email;
  final double balance;

  const AccountInfo({
    required this.name,
    required this.email,
    required this.balance,
  });

  @override
  List<Object?> get props => [name, email, balance];
}
