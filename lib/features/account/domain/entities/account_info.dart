import 'package:equatable/equatable.dart';

class AccountInfo extends Equatable {
  final String name;
  final String email;
  final double balance;
  final int points;
  final String? plan;
  final DateTime? lastTransactionDate;
  final String? avatarUrl;
  final String? phoneNumber;

  const AccountInfo({
    required this.name,
    required this.email,
    required this.balance,
    required this.points,
    this.plan,
    this.lastTransactionDate,
    this.avatarUrl,
    this.phoneNumber,
  });

  @override
  List<Object?> get props => [name, email, balance, points, plan, lastTransactionDate, avatarUrl, phoneNumber];
}
