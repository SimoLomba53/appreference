import 'package:flutter/material.dart';
import 'package:growingapp/components/navbar/bottom_nav_bar.dart';
import 'package:growingapp/features/news/presentation/pages/news_page.dart';
import 'package:growingapp/features/notifications/presentation/pages/notification_page.dart';
import 'package:growingapp/features/shop/presentation/pages/shop_page.dart';
import 'package:growingapp/features/terrarium/presentation/pages/terrariums_garden.dart';
import 'package:growingapp/pages/luxmeter.dart';

class MainViewPage extends StatefulWidget {
  const MainViewPage({super.key});

  @override
  State<MainViewPage> createState() => _MainViewPageState();
}

class _MainViewPageState extends State<MainViewPage> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const LuxmeterPage(),
    NewsPage(),
    const TerrariumsGarden(),
    const ShopPage(),
    const NotificationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBarCustom(
        updateView: _onItemTapped,
        initialIndex: _selectedIndex,
      ),
    );
  }
}
