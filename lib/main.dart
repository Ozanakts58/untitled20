import 'package:flutter/material.dart';
import 'package:untitled18/account_check/main_page.dart';
import 'package:untitled18/pages/book_add_page.dart';
import 'package:untitled18/pages/forget_password.dart';
import 'package:untitled18/pages/home_page.dart';
import 'package:untitled18/pages/login_page.dart';
import 'package:untitled18/pages/profile_page.dart';
import 'package:untitled18/pages/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled18/pages/signup_page.dart';
///import 'package:untitled18/sign_up/sign_up_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(

                body: Center(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Text('Ödünç Kitap Uygulamasına Hoşgeldiniz'),
                    ),
                  )

                ),
              ),
            );
          }

          else if(snapshot.hasError){
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Center(
                    child: Text('Hata Oluştu lütfen bekleyin.. '),
                  ),
                ),
              ),
            );
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Flutter Ödünç Kitap Uygulaması",
            home: FirebaseAuth.instance.currentUser == null ? ForgetPassword() : Homepage(),
          );
        }
    );
  }
}