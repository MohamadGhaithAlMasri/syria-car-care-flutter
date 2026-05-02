import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../widgets/balance_sub_card.dart';
import '../widgets/payment_method_card.dart';
import '../widgets/transaction_item.dart';

class WalletPaymentsScreen extends StatelessWidget {
  const WalletPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'app_name'.tr(),
          style: TextStyle(
            color: Color(0xFF102A43),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?q=80&w=1000',
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                    style: TextStyle(color: Colors.cyanAccent, fontSize: 14),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'balance_mock'.tr(),
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
                  ),
                  const SizedBox(height: 25),

                  Row(
                    children: [
                      BalanceSubCard(
                        title: "loyalty_points".tr(),
                        value: "points_mock".tr(),
                      ),
                      SizedBox(width: 15),
                      BalanceSubCard(
                        title: "last_transaction".tr(),
                        value: "date_mock_1".tr(),
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
                color: Color(0xFF102A43),
              ),
            ),
            const SizedBox(height: 15),
            const PaymentMethodCard(
              title: "سيريتل كاش",
              subtitle: "دفع فوري وآمن",
              icon:
                  "https://images.unsplash.com/photo-1552519507-da3b142c6e3d?q=80&w=1000",
            ),
            const SizedBox(height: 10),
            const PaymentMethodCard(
              title: "تحويل بنكي",
              subtitle: "بنوك محلية معتمدة",
              icon: Icons.account_balance,
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
                    color: Color(0xFF102A43),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'view_all'.tr(),
                    style: TextStyle(color: Colors.cyan),
                  ),
                ),
              ],
            ),

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
            const SizedBox(height: 20),

            Container(
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
                    onPressed: () {},
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
