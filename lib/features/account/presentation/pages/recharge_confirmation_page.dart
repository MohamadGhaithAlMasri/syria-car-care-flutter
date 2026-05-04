import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/account_bloc.dart';

class RechargeConfirmationPage extends StatelessWidget {
  final double amount;
  final String method;

  const RechargeConfirmationPage({
    super.key,
    required this.amount,
    required this.method,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is RechargeSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('recharge_success'.tr())),
          );
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else if (state is AccountError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('recharge_confirmation'.tr()),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.account_balance_wallet,
                  size: 80,
                  color: Colors.cyan,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'confirm_recharge_msg'.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    _buildInfoRow('amount'.tr(), '$amount ${'syrian_pound'.tr()}'),
                    const Divider(),
                    _buildInfoRow('payment_method'.tr(), method),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: BlocBuilder<AccountBloc, AccountState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is AccountLoading
                          ? null
                          : () {
                              context.read<AccountBloc>().add(
                                    RechargeWalletEvent(
                                      amount: amount,
                                      method: method,
                                    ),
                                  );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: state is AccountLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'confirm'.tr(),
                              style: const TextStyle(
                                color: Color(0xFF1B3B5A),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
