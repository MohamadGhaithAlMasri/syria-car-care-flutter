import 'package:syria_car_care2/features/account/domain/entities/account_info.dart';

class AccountInfoModel extends AccountInfo {
  const AccountInfoModel({
    required super.name,
    required super.email,
    required super.balance,
    required super.points,
    super.plan,
    super.lastTransactionDate,
    super.avatarUrl,
    super.phoneNumber,
  });

  factory AccountInfoModel.fromJson(Map<String, dynamic> json) {
    return AccountInfoModel(
      name: json['full_name'] ?? json['name'] ?? '',
      email: json['email'] ?? '',
      balance: (json['balance'] ?? 0).toDouble(),
      points: json['points'] ?? 0,
      plan: json['plan'],
      lastTransactionDate: json['last_transaction_at'] != null
          ? DateTime.parse(json['last_transaction_at'])
          : null,
      avatarUrl: json['avatar_url'],
      phoneNumber: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': name,
      'email': email,
      'balance': balance,
      'points': points,
      'plan': plan,
      'last_transaction_at': lastTransactionDate?.toIso8601String(),
      'avatar_url': avatarUrl,
      'phone_number': phoneNumber,
    };
  }
}
