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
          : json['type'] == 'refund'
              ? TransactionType.refund
              : json['type'] == 'subscription'
                  ? TransactionType.subscription
                  : json['type'] == 'booking'
                      ? TransactionType.booking
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
      'type': type == TransactionType.recharge 
          ? 'recharge' 
          : type == TransactionType.refund
              ? 'refund'
              : type == TransactionType.subscription
                  ? 'subscription'
                  : type == TransactionType.booking
                      ? 'booking'
                      : 'payment',
      'icon_name': iconName,
    };
  }
}
