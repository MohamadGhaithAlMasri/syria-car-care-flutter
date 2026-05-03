import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syria_car_care2/core/theme/theme_bloc.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,

        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.transparent
                : Colors.grey.shade100,
          ),
        ),
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
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              size: 20,
            ),
          ),
          const SizedBox(width: 15),
          Text(
            Theme.of(context).brightness == Brightness.dark
                ? "Dark Theme"
                : "Light Theme", // Using text directly since 'theme' tr might not exist yet
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const Spacer(),
          Switch(
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: (value) {
              context.read<ThemeBloc>().add(ToggleThemeEvent());
            },
            activeColor: Theme.of(context).primaryColor,
            activeTrackColor: Colors.blue.shade200,
            inactiveThumbColor: Colors.grey.shade400,
            inactiveTrackColor: Colors.grey.shade200,
          ),
        ],
      ),
    );
  }
}
