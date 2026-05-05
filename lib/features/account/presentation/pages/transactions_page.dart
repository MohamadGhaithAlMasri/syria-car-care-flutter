import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syria_car_care2/features/account/domain/entities/wallet_transaction.dart';
import '../widgets/transaction_item.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/account_bloc.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'transaction_history'.tr(),
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoading && state is! AccountLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AccountError && state is! AccountLoaded) {
            return Center(child: Text(state.message));
          }

          final transactions = state is AccountLoaded
              ? state.transactions
              : <WalletTransaction>[];

          if (transactions.isEmpty) {
            return Center(child: Text('no_transactions'.tr()));
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<AccountBloc>().add(GetTransactionsEvent());
            },
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final tx = transactions[index];
                return TransactionItem(
                  title: tx.title,
                  date: DateFormat('dd/MM/yyyy HH:mm').format(tx.date),
                  amount:
                      "${(tx.type == TransactionType.recharge || tx.type == TransactionType.refund) ? '+' : '-'} ${tx.amount.abs().toStringAsFixed(0)} ${'syrian_pound'.tr()}",
                  amountColor: (tx.type == TransactionType.recharge || tx.type == TransactionType.refund)
                      ? Colors.green
                      : Colors.red,
                  borderColor: (tx.type == TransactionType.recharge || tx.type == TransactionType.refund)
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
                );
              },
            ),
          );
        },
      ),
    );
  }
}
