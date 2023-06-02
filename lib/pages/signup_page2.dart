import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:untitled18/pages/login_page.dart';

class SignUpScreenn extends StatefulWidget {
  const SignUpScreenn({Key? key}) : super(key: key);

  @override
  State<SignUpScreenn> createState() => _SignUpScreennState();
}

class _SignUpScreennState extends State<SignUpScreenn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _firestore = FirebaseFirestore.instance;
//
  final _userName = TextEditingController();
  final _userSurname = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _telephoneController = TextEditingController();

  String get userName => _userName.text.trim();
  String get userSurname => _userSurname.text.trim();
  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();
  String get telephoneNumber => _telephoneController.text.trim();




  //
  TextEditingController userNameController = TextEditingController();
  TextEditingController userSurnameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();

  Future<void> KayitOl() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: mailController.text.trim().toLowerCase(),
      password: passwordController.text.trim(),
    );

    final User? user = _auth.currentUser;
    final _uid = user!.uid;
    FirebaseFirestore.instance.collection('kullanicilar').doc(_uid).set({
      'id': _uid,
      'name': userNameController.text,
      'surname': userSurnameController.text,
      'email': mailController.text,
      'phoneNumber': telephoneController,
      'create': Timestamp.now(),
    });
    Navigator.canPop(context) ? Navigator.pop(context) : null;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference userRef = _firestore.collection('Userss');
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Colors.red,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _page(),
      ),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              _extraText3(),
              const SizedBox(height: 15),
              _extraText4(),
              const SizedBox(height: 10),
              _icon(),
              const SizedBox(height: 25),
              _inputField("Adınız", userNameController),
              const SizedBox(height: 12),
              _inputField("Soyadınız", userSurnameController),
              const SizedBox(height: 12),
              _inputField("Mail adresiniz", mailController),
              const SizedBox(height: 12),
              _inputField("Parolanız", passwordController, isPassword: true),
              const SizedBox(height: 13),
              _inputField("Telefon numaranız", telephoneController),
              const SizedBox(height: 25),
              _signupBtn(),
              const SizedBox(height: 15),
              _extraText2(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          shape: BoxShape.circle),
      child: const Icon(Icons.person, color: Colors.white, size: 120),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {isPassword = false}) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.white));

    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: border,
        focusedBorder: border,
      ),
      obscureText: isPassword,
    );
  }

  Widget _signupBtn() {

    return ElevatedButton(

      onPressed: () async {
        KayitOl();
        /*CollectionReference userRef = _firestore.collection('Userss');
        final User? user = _auth.currentUser;
        final _uid = user!.uid;
        Map<String, dynamic> userData= {
        'id': _uid,
          'name':userNameController.text,
          'surname':userSurnameController.text,
          'email':mailController.text,
          'phone':telephoneController.text.toString(),
          'create': Timestamp.now(),
        };
        //Kitap ismi yeniyse yeni document oluşturur daha onceden varsa değerini değiştirir.
        await userRef.doc(userNameController.text).set(userData);
        debugPrint("Adınız : ${userNameController.text}");
        debugPrint("Soyadınız : ${userSurnameController.text}");
        debugPrint("Mail Adresiniz : ${mailController.text}");
        debugPrint("Parolanız : ${passwordController.text}");
        debugPrint("Telefon Numaranız : ${telephoneController.text}");*/
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.blue,
        backgroundColor: Colors.white,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: const SizedBox(
          width: double.infinity,
          child: Text(
            "Kaydol",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          )),
    );
  }

  Widget _extraText2() {
    return RichText(
      text: TextSpan(children: [
        const TextSpan(
          text: 'Üye değil misiniz?',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const TextSpan(text: '      '),
        TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginPage())),
          text: 'Giriş Yap',
          style: const TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        )
      ]),
    );
  }

  Widget _extraText3() {
    return const Text(
      "Ödünç Kitap",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
  Widget _extraText4() {
    return const Text(
      "Kayıt Ol",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 28, color: Colors.white70, fontWeight: FontWeight.w700),
    );
  }

}
