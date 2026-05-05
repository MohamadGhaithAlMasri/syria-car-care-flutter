import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/account_info_model.dart';
import '../models/wallet_transaction_model.dart';
import '../models/user_address_model.dart';

abstract class AccountRemoteDataSource {
  Future<AccountInfoModel> getAccountInfo();
  Future<List<WalletTransactionModel>> getTransactions();
  Future<void> rechargeWallet(double amount, String method);
  Future<void> upgradePlan(String planName, double price);
  Future<String> uploadAvatar(String filePath);
  Future<List<UserAddressModel>> getAddresses();
  Future<void> saveAddress(UserAddressModel address);
}

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final SupabaseClient supabase;

  AccountRemoteDataSourceImpl(this.supabase);

  @override
  Future<AccountInfoModel> getAccountInfo() async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final response = await supabase
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single();

    return AccountInfoModel.fromJson(response);
  }

  @override
  Future<List<WalletTransactionModel>> getTransactions() async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final response = await supabase
        .from('wallet_transactions')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => WalletTransactionModel.fromJson(json))
        .toList();
  }

  @override
  Future<void> rechargeWallet(double amount, String method) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    // 1. Create a transaction record
    await supabase.from('wallet_transactions').insert({
      'user_id': user.id,
      'title': 'Recharge via $method',
      'amount': amount,
      'type': 'recharge',
      'created_at': DateTime.now().toIso8601String(),
    });

    // 2. Update user balance
    final currentProfile = await supabase
        .from('profiles')
        .select('balance')
        .eq('id', user.id)
        .single();
    
    final newBalance = (currentProfile['balance'] ?? 0) + amount;

    await supabase
        .from('profiles')
        .update({
          'balance': newBalance,
          'last_transaction_at': DateTime.now().toIso8601String(),
        })
        .eq('id', user.id);
  }

  @override
  Future<void> upgradePlan(String planName, double price) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    // 1. Get current balance
    final profile = await supabase
        .from('profiles')
        .select('balance')
        .eq('id', user.id)
        .single();
    
    final currentBalance = (profile['balance'] ?? 0).toDouble();

    if (currentBalance < price) {
      throw Exception('insufficient_balance');
    }

    // 2. Create transaction record
    await supabase.from('wallet_transactions').insert({
      'user_id': user.id,
      'title': 'Subscription: $planName',
      'amount': -price, // Deducting
      'type': 'subscription',
      'created_at': DateTime.now().toIso8601String(),
    });

    // 3. Update user profile (balance and plan)
    await supabase
        .from('profiles')
        .update({
          'balance': currentBalance - price,
          'plan': planName,
          'last_transaction_at': DateTime.now().toIso8601String(),
        })
        .eq('id', user.id);
  }
  
  @override
  Future<String> uploadAvatar(String filePath) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final file = await _getFileFromPath(filePath);
    final fileName = '${user.id}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final path = 'avatars/$fileName';

    await supabase.storage.from('avatars').upload(path, file);
    
    final publicUrl = supabase.storage.from('avatars').getPublicUrl(path);

    await supabase.from('profiles').update({
      'avatar_url': publicUrl,
    }).eq('id', user.id);

    return publicUrl;
  }

  @override
  Future<List<UserAddressModel>> getAddresses() async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final response = await supabase
        .from('user_addresses')
        .select()
        .eq('user_id', user.id);

    return (response as List)
        .map((json) => UserAddressModel.fromJson(json))
        .toList();
  }

  @override
  Future<void> saveAddress(UserAddressModel address) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    await supabase.from('user_addresses').upsert({
      ...address.toJson(),
      'user_id': user.id,
    });
  }

  // Helper method to handle file conversion
  Future<File> _getFileFromPath(String path) async {
    return File(path);
  }
}
