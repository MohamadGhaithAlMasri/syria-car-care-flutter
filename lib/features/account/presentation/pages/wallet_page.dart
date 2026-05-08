import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:syria_car_care2/features/account/domain/entities/wallet_transaction.dart';
import '../widgets/balance_sub_card.dart';
import '../widgets/payment_method_card.dart';
import '../widgets/transaction_item.dart';
import 'transactions_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/account_bloc.dart';

import 'recharge_amount_page.dart';
import '../widgets/profile_avatar.dart';

class WalletPaymentsScreen extends StatefulWidget {
  const WalletPaymentsScreen({super.key});

  @override
  State<WalletPaymentsScreen> createState() => _WalletPaymentsScreenState();
}

class _WalletPaymentsScreenState extends State<WalletPaymentsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AccountBloc>().add(GetAccountInfoEvent());
  }

  Future<void> _launchWhatsApp() async {
    const phoneNumber = "+963992922651";
    final url = Uri.parse("whatsapp://send?phone=$phoneNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      final webUrl = Uri.parse("https://wa.me/$phoneNumber");
      if (await canLaunchUrl(webUrl)) {
        await launchUrl(webUrl, mode: LaunchMode.externalApplication);
      }
    }
  }

  void _showBankDetails() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'bank_transfer'.tr(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildBankRow('اسم المصرف', 'المصرف التجاري السوري'),
            _buildBankRow('رقم الحساب', '0101-123456-001'),
            _buildBankRow('اسم المستفيد', 'شركة سوريا للعناية بالسيارات'),
            const SizedBox(height: 20),
            Text(
              'يرجى إرسال صورة إيصال التحويل للدعم الفني لتأكيد الشحن',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBankRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.copy, size: 18, color: Colors.cyan),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: value));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تم النسخ: $value'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        final accountInfo = state is AccountLoaded ? state.accountInfo : null;
        final transactions = state is AccountLoaded
            ? state.transactions
            : <WalletTransaction>[];
        final isLoading = state is AccountLoading;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'app_name'.tr(),
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: const [
              Padding(padding: EdgeInsets.all(8.0), child: ProfileAvatar()),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<AccountBloc>().add(GetAccountInfoEvent());
            },
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B3B5A),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'current_balance'.tr(),
                                style: const TextStyle(
                                  color: Colors.cyanAccent,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (isLoading && accountInfo == null)
                                    const SizedBox(
                                      height: 36,
                                      width: 36,
                                      child: CircularProgressIndicator(
                                        color: Colors.cyanAccent,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  else ...[
                                    Text(
                                      accountInfo?.balance.toStringAsFixed(0) ??
                                          '0',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'syrian_pound'.tr(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  Expanded(
                                    child: BalanceSubCard(
                                      title: "loyalty_points".tr(),
                                      value: isLoading && accountInfo == null
                                          ? '...'
                                          : accountInfo?.points.toString() ??
                                                '0',
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: BalanceSubCard(
                                      title: "last_transaction".tr(),
                                      value: isLoading && accountInfo == null
                                          ? '...'
                                          : (accountInfo?.lastTransactionDate !=
                                                    null
                                                ? DateFormat(
                                                    'dd/MM/yyyy',
                                                  ).format(
                                                    accountInfo!
                                                        .lastTransactionDate!,
                                                  )
                                                : '---'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'wallet_recharge'.tr(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RechargeAmountPage(
                                  method: 'syriatel_cash'.tr(),
                                ),
                              ),
                            );
                          },
                          child: PaymentMethodCard(
                            title: "syriatel_cash".tr(),
                            subtitle: "syriatel_cash_subtitle".tr(),
                            icon:
                                "https://images.unsplash.com/photo-1552519507-da3b142c6e3d?q=80&w=1000",
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: _showBankDetails,
                          child: PaymentMethodCard(
                            title: "bank_transfer".tr(),
                            subtitle: "bank_transfer_subtitle".tr(),
                            icon: Icons.account_balance,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'transaction_history'.tr(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TransactionsPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'view_all'.tr(),
                                style: const TextStyle(color: Colors.cyan),
                              ),
                            ),
                          ],
                        ),
                        if (isLoading && transactions.isEmpty)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        else if (transactions.isEmpty)
                          Center(child: Text('no_transactions'.tr()))
                        else
                          ...transactions
                              .take(3)
                              .map(
                                (tx) => TransactionItem(
                                  title: tx.title,
                                  date: DateFormat(
                                    'dd/MM/yyyy HH:mm',
                                  ).format(tx.date),
                                  amount:
                                      "${(tx.type == TransactionType.recharge || tx.type == TransactionType.refund) ? '+' : '-'} ${tx.amount.abs().toStringAsFixed(0)} ${'syrian_pound'.tr()}",
                                  amountColor:
                                      (tx.type == TransactionType.recharge ||
                                          tx.type == TransactionType.refund)
                                      ? Colors.green
                                      : Colors.red,
                                  borderColor:
                                      (tx.type == TransactionType.recharge ||
                                          tx.type == TransactionType.refund)
                                      ? Colors.green.withOpacity(0.3)
                                      : Colors.red.withOpacity(0.3),
                                  icon: tx.type == TransactionType.recharge
                                      ? Icons.add_card
                                      : tx.type == TransactionType.refund
                                      ? Icons.history_rounded
                                      : tx.type == TransactionType.subscription
                                      ? Icons.card_membership
                                      : tx.type == TransactionType.booking
                                      ? Icons.local_car_wash
                                      : Icons.payment,
                                ),
                              ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B3B5A),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'payment_issue_q'.tr(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'support_info'.tr(),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                        ElevatedButton(
                          onPressed: _launchWhatsApp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'contact_us'.tr(),
                            style: const TextStyle(
                              color: Color(0xFF1B3B5A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
