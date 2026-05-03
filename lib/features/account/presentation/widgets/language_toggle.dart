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
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
        border: Border(bottom: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.transparent : Colors.grey.shade100)),
      ),
      child: Row(
        children: [

          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.language,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              size: 20,
            ),
          ),
          const SizedBox(width: 15),

          Text(
            "language".tr(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const Spacer(),

          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF111827) : Colors.grey.shade200,
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
          color: isSelected ? (Theme.of(context).brightness == Brightness.dark ? const Color(0xFF374151) : Colors.white) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [BoxShadow(color: Theme.of(context).brightness == Brightness.dark ? Colors.black38 : Colors.black12, blurRadius: 4)]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Theme.of(context).textTheme.bodyLarge?.color : Colors.grey,
          ),
        ),
      ),
    );
  }
}
