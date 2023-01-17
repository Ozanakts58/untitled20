import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:untitled18/widgets/bottom_nav_bar2.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.red,
            ],
          )),
      child: Scaffold(
          //bottomNavigationBar: BottomNavigationBarForApp(indexNum: 3),
        body: Text("profile"),

        bottomNavigationBar: GNav(
          backgroundColor: Colors.white54,
          color: Colors.black,
          activeColor: Colors.black,
          tabBackgroundColor: Colors.blueAccent.shade200,
          gap: 8,
          padding: EdgeInsets.all(16.0),
          tabs: [
            GButton(icon: Icons.home, text: 'Ana Sayfa',),
            GButton(icon: Icons.search, text: 'Arama',),
            GButton(icon: Icons.person_rounded, text: 'Profil',),
            GButton(icon: Icons.output_rounded, text: 'Çıkış',),
          ],
        ),
        backgroundColor: Colors.transparent,

      ),
    );
  }

}
