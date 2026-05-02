import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {

    final isArabic = context.locale.languageCode == 'ar';

    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        children: [

          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.language,
              color: Color(0xFF102A43),
              size: 20,
            ),
          ),
          const SizedBox(width: 15),

          Text(
            "language".tr(),
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const Spacer(),

          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                _buildLangBtn(
                  context,
                  "English",
                  !isArabic,
                  const Locale('en'),
                ),
                _buildLangBtn(
                  context,
                  "العربية",
                  isArabic,
                  const Locale('ar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLangBtn(
    BuildContext context,
    String label,
    bool isSelected,
    Locale locale,
  ) {
    return InkWell(
      onTap: () {

        context.setLocale(locale);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(

          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [const BoxShadow(color: Colors.black12, blurRadius: 4)]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
