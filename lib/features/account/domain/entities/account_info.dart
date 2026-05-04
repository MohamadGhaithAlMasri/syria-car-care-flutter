import 'package:equatable/equatable.dart';

class AccountInfo extends Equatable {
  final String name;
  final String email;
  final double balance;
  final int points;
  final DateTime? lastTransactionDate;

  const AccountInfo({
    required this.name,
    required this.email,
    required this.balance,
    required this.points,
    this.lastTransactionDate,
  });

  @override
  List<Object?> get props => [name, email, balance, points, lastTransactionDate];
}
