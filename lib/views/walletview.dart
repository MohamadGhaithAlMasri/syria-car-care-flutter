import 'package:flutter/material.dart';

class WalletPaymentsScreen extends StatelessWidget {
  const WalletPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF102A43)),
                onPressed: () => Navigator.pop(context),
              )
            : const Icon(Icons.menu, color: Color(0xFF102A43)),
        title: const Text(
          'Syria Car Care',
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
          crossAxisAlignment: CrossAxisAlignment.end,
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
                  const Text(
                    'رصيدك الحالي',
                    style: TextStyle(color: Colors.cyanAccent, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ل.س',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '١٥٠,٠٠٠',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      _buildBalanceSubCard("نقاط الولاء", "٢,٤٥٠ نقطة"),
                      const SizedBox(width: 15),
                      _buildBalanceSubCard("آخر عملية", "١٥ مايو"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'شحن المحفظة',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF102A43),
              ),
            ),
            const SizedBox(height: 15),
            _buildPaymentMethodCard(
              "سيريتل كاش",
              "دفع فوري وآمن",
              "https://images.unsplash.com/photo-1552519507-da3b142c6e3d?q=80&w=1000",
            ),
            const SizedBox(height: 10),
            _buildPaymentMethodCard(
              "تحويل بنكي",
              "بنوك محلية معتمدة",
              Icons.account_balance,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'عرض الكل',
                    style: TextStyle(color: Colors.cyan),
                  ),
                ),
                const Text(
                  'سجل العمليات',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF102A43),
                  ),
                ),
              ],
            ),
            _buildTransactionItem(
              "غسيل سيارة - كيا سيراتو",
              "١٥ مايو • ٠٨:٣٠ ص",
              "- ٦٥,٠٠٠ ل.س",
              Colors.red,
              Icons.local_car_wash,
            ),
            _buildTransactionItem(
              "شحن رصيد - سيريتل كاش",
              "١٢ مايو • مكتمل",
              "+ ١٠٠,٠٠٠ ل.س",
              Colors.green,
              Icons.add_card,
              isHighlighted: true,
            ),
            _buildTransactionItem(
              "تغيير زيت - هيونداي",
              "٠٨ مايو • منذ أسبوع",
              "- ١٢٠,٠٠٠ ل.س",
              Colors.red,
              Icons.oil_barrel,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1B3B5A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'تواصل معنا',
                      style: TextStyle(
                        color: Color(0xFF1B3B5A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'هل تواجه مشكلة في الدفع؟',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'فريق الدعم الفني جاهز لمساعدتك ٢٤/٧',
                        style: TextStyle(color: Colors.white70, fontSize: 10),
                      ),
                    ],
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

  Widget _buildBalanceSubCard(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodCard(String title, String subtitle, dynamic icon) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.arrow_back_ios, size: 14, color: Colors.grey),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(width: 15),
          CircleAvatar(
            backgroundColor: Colors.blue.shade50,
            child: icon is IconData
                ? Icon(icon, color: Colors.blue)
                : Image.network(icon as String, width: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
    String title,
    String date,
    String amount,
    Color amountColor,
    IconData icon, {
    bool isHighlighted = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isHighlighted
            ? Border.all(color: Colors.cyanAccent, width: 1)
            : null,
      ),
      child: Row(
        children: [
          Text(
            amount,
            style: TextStyle(color: amountColor, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                date,
                style: const TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(width: 15),
          CircleAvatar(
            backgroundColor: Colors.grey.shade100,
            child: Icon(icon, color: Colors.blueGrey, size: 20),
          ),
        ],
      ),
    );
  }
}
