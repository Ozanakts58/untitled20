import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled18/pages/book_add_page.dart';
import 'package:untitled18/pages/home_page.dart';
import 'package:untitled18/pages/profile_page.dart';
import 'package:untitled18/pages/search_page.dart';
import 'package:untitled18/user_state.dart';


class BottomNavigationBarForApp extends StatelessWidget {
  int indexNum = 0;

  BottomNavigationBarForApp({required this.indexNum});

  void _logout(context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black54,
            title: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.logout,
                    color: Colors.green,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Çıkış Yap',
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                ),
              ],
            ),
            content: const Text(
              'Çıkış yapmak mı istiyorsunuz?',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: const Text(
                  'Hayır',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _auth.signOut();
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => UserState()));
                },
                child: const Text(
                  'Evet',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: Colors.blue.shade400,
      backgroundColor: Colors.redAccent,
      buttonBackgroundColor: Colors.blue.shade400,
      height: 50,
      index: indexNum,
      items: const [
        Icon(Icons.list, size: 19, color: Colors.black),///index==0
        Icon(Icons.search, size: 19, color: Colors.black),///index==1
        Icon(Icons.add, size: 19, color: Colors.black),
        Icon(Icons.person_pin, size: 19, color: Colors.black),
        Icon(Icons.exit_to_app, size: 19, color: Colors.black),
      ],

      ///CurvedNavigationBar maus ile secimlerde değişecek animasyon
      animationDuration: const Duration(
        milliseconds: 300,
      ),
      animationCurve: Curves.bounceInOut,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => Homepage()));
        } else if (index == 1) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => SearchPage()));
        } else if (index == 2) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => BookAddPage()));
        } else if (index == 3) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => ProfilePage()));
        }else if (index == 4) {
          _logout(context);
        }
      },
    );
  }
}
