import '../../domain/entities/wallet_transaction.dart';

class WalletTransactionModel extends WalletTransaction {
  const WalletTransactionModel({
    required super.id,
    required super.title,
    required super.amount,
    required super.date,
    required super.type,
    super.iconName,
  });

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) {
    return WalletTransactionModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      date: DateTime.parse(json['created_at']),
      type: json['type'] == 'recharge' 
          ? TransactionType.recharge 
          : TransactionType.payment,
      iconName: json['icon_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'created_at': date.toIso8601String(),
      'type': type == TransactionType.recharge ? 'recharge' : 'payment',
      'icon_name': iconName,
    };
  }
}
