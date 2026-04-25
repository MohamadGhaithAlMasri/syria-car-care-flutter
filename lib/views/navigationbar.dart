import 'package:flutter/material.dart';
import 'package:last/views/garageview.dart';
import 'package:last/views/homeview.dart';
import 'package:last/views/profileview.dart';
import 'package:last/views/walletview.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 3;

  final List<Widget> _pages = [
    const ProfileScreen(),
    const WalletPaymentsScreen(),
    const GarageScreen(),
    const HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.blueGrey.shade200,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_filled_outlined),
            label: 'Garage',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        ],
      ),
    );
  }
}



