import 'package:flutter/material.dart';
//kullanılmadı.

class AccountCheck extends StatelessWidget {

  final bool login;
  final VoidCallback press;

  AccountCheck({required this.login, required this.press});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(login ? "Don't have an Account?" : "Already have an Account?",
          style: const TextStyle(fontSize: 16.0, color: Colors.white),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Create Account" : "Log in",
            style: const TextStyle(fontSize: 16.0, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
