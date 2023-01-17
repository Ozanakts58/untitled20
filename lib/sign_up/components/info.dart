import 'package:flutter/material.dart';
import 'package:untitled18/widgets/input_fields.dart';

class Credentials extends StatefulWidget {

  @override
  State<Credentials> createState() => _CredentialsState();
}

class _CredentialsState extends State<Credentials> {

  final TextEditingController _fullNameController = TextEditingController(text: "");
  final TextEditingController _emailTextController = TextEditingController(text: "");
  final TextEditingController _passTextController = TextEditingController(text: "");
  final TextEditingController _phoneNumController = TextEditingController(text: "");


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        InputField(
          hintText: "Ad Soyad",
          icon: Icons.person,
          obscureText: false,
          textEditingController: _fullNameController,
        ),
        const SizedBox(height: 10.0),
        InputField(hintText: "Mail", icon: Icons.mail_rounded, obscureText: false, textEditingController: _emailTextController,),
        const SizedBox(height: 10.0),
        InputField(hintText: "Enter Password", icon: Icons.lock, obscureText: true, textEditingController: _passTextController,),
        const SizedBox(height: 10.0),
        InputField(hintText: "Telefon Numarası", icon: Icons.numbers, obscureText: false, textEditingController: _phoneNumController,),
        const SizedBox(height: 15.0),
      ],
    );
  }
}
