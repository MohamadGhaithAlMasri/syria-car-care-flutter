import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'recharge_confirmation_page.dart';

class RechargeAmountPage extends StatefulWidget {
  final String method;
  const RechargeAmountPage({super.key, required this.method});

  @override
  State<RechargeAmountPage> createState() => _RechargeAmountPageState();
}

class _RechargeAmountPageState extends State<RechargeAmountPage> {
  final TextEditingController _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('recharge_amount'.tr()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'enter_recharge_amount'.tr(),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'amount'.tr(),
                  hintText: '0.00',
                  suffixText: 'syrian_pound'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please_enter_amount'.tr();
                  }
                  if (double.tryParse(value) == null || double.parse(value) <= 0) {
                    return 'please_enter_valid_amount'.tr();
                  }
                  return null;
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RechargeConfirmationPage(
                            amount: double.parse(_amountController.text),
                            method: widget.method,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'next'.tr(),
                    style: const TextStyle(
                      color: Color(0xFF1B3B5A),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
