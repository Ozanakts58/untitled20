import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled18/pages/home_page.dart';
import 'package:untitled18/pages/login_page.dart';


class UserState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, userSnapshot) {
        if(userSnapshot.data == null) {
          print('User is not logged in yet');
          return LoginPage();
        }else if(userSnapshot.hasData){
          print('User is already logged yet');
          return Homepage();
        }else if(userSnapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text(
                'An error has been occurred. Try again later',
              ),
            ),
          );
        }else if(userSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(

              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: Text(
              'Something went wrong',
            ),
          ),
        );
      },
    );
  }
}
