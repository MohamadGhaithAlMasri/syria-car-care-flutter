import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/account_info_model.dart';
import '../models/wallet_transaction_model.dart';

abstract class AccountRemoteDataSource {
  Future<AccountInfoModel> getAccountInfo();
  Future<List<WalletTransactionModel>> getTransactions();
  Future<void> rechargeWallet(double amount, String method);
  Future<void> upgradePlan(String planName, double price);
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
}
