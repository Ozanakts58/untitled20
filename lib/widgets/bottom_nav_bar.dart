import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:untitled18/pages/logout_page.dart';
import 'package:untitled18/pages/profile_page.dart';
import 'package:untitled18/pages/search_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final List<String> _titles = const [
    'Ana Sayfa',
    'Arama',
    'Profil',
    'Çıkış',
  ];
  final List<Widget> _tabs = const [
    //Homepage(),
    SearchPage(),
    ProfilePage(),
    logOutPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        onTabChange: (newIndex) => setState(() => _selectedIndex = newIndex),
        backgroundColor: Colors.white54,
        color: Colors.black,
        activeColor: Colors.black,
        tabBackgroundColor: Colors.blueAccent.shade200,
        gap: 8,
        padding: const EdgeInsets.all(16.0),
        tabs: const [
          GButton(icon: Icons.home, text: 'Ana Sayfa',),
          GButton(icon: Icons.search, text: 'Arama',),
          GButton(icon: Icons.person_rounded, text: 'Profil',),
          GButton(icon: Icons.output_rounded, text: 'Çıkış',),
        ],
      ),
    );
  }
}
