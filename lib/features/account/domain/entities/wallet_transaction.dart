import 'package:equatable/equatable.dart';

enum TransactionType { recharge, payment }

class WalletTransaction extends Equatable {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final String? iconName;

  const WalletTransaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    this.iconName,
  });

  @override
  List<Object?> get props => [id, title, amount, date, type, iconName];
}
