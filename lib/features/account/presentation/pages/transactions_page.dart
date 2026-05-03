import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../widgets/transaction_item.dart';

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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          TransactionItem(
            title: "trans_wash".tr(),
            date: "date_mock_1".tr(),
            amount: "- ${"sp_mock_1".tr()}",
            amountColor: Colors.red,
            icon: Icons.local_car_wash,
          ),
          TransactionItem(
            title: "trans_recharge".tr(),
            date: "date_mock_2".tr(),
            amount: "+ ${"sp_mock_2".tr()}",
            amountColor: Colors.green,
            icon: Icons.add_card,
            isHighlighted: true,
          ),
          TransactionItem(
            title: "trans_oil".tr(),
            date: "date_mock_3".tr(),
            amount: "- ${"sp_mock_3".tr()}",
            amountColor: Colors.red,
            icon: Icons.oil_barrel,
          ),
          // Adding more mock transactions for demonstration
          TransactionItem(
            title: "trans_wash".tr(),
            date: "date_mock_1".tr(),
            amount: "- ${"sp_mock_1".tr()}",
            amountColor: Colors.red,
            icon: Icons.local_car_wash,
          ),
          TransactionItem(
            title: "trans_recharge".tr(),
            date: "date_mock_2".tr(),
            amount: "+ ${"sp_mock_2".tr()}",
            amountColor: Colors.green,
            icon: Icons.add_card,
          ),
          TransactionItem(
            title: "trans_oil".tr(),
            date: "date_mock_3".tr(),
            amount: "- ${"sp_mock_3".tr()}",
            amountColor: Colors.red,
            icon: Icons.oil_barrel,
          ),
          TransactionItem(
            title: "trans_wash".tr(),
            date: "date_mock_1".tr(),
            amount: "- ${"sp_mock_1".tr()}",
            amountColor: Colors.red,
            icon: Icons.local_car_wash,
          ),
        ],
      ),
    );
  }
}
