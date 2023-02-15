import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled18/pages/forget_password.dart';
import 'package:untitled18/pages/home_page.dart';
import 'package:untitled18/pages/signup_page.dart';
import 'package:untitled18/services/global_methods.dart';
import 'package:untitled18/widgets/text_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _loginFromKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  //TextEditingController usernameController = TextEditingController();
  //TextEditingController passwordController = TextEditingController();

  Future signIn() async {
    final isValid = _loginFromKey.currentState!.validate();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),

        );
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Homepage()),
        );
        //Navigator.canPop(context) ? Navigator.pop(context) : null;
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        GlobalMethod.showErrorDialog(error: error.toString(), ctx: context);
        print('error$error');
      }
    }
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  static Future<void> errorDialog({
    required String subtitle,
    required BuildContext context,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Image.asset(
                'assets/images/warning_sign.png',
                height: 20,
                width: 20,
                fit: BoxFit.fill,
              ),
              const SizedBox(width: 8),
              const Text('Bir Hata Oluştu'),
            ],
          ),
          content: Text(subtitle),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: TextWidget(
                color: Colors.cyan,
                text: 'Ok',
                textSize: 18,
              ),
            ),
          ],
        );
      },
    );
  }

  bool _isloading = false;
  Future<void> _googleSignIn(context) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          await _auth.signInWithCredential(GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken));
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Homepage()),
          );
        } on FirebaseException catch (error) {
          errorDialog(subtitle: '${error.message}', context: context);
        } catch (error) {
          errorDialog(subtitle: '$error', context: context);
        } finally {}
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
      padding: const EdgeInsets.all(23.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _extraText3(),
              const SizedBox(height: 10),
              _extraText4(),
              const SizedBox(height: 15),
              _icon(),
              const SizedBox(height: 25),
              _inputField("Mail adresiniz", _emailController),
              const SizedBox(height: 12),
              _inputField("Parolanız", _passwordController, isPassword: true),
              const SizedBox(height: 15),
              _extraText(),
              const SizedBox(height: 30),
              _loginBtn(),
              const SizedBox(height: 15),
              _extraText5(),
              const SizedBox(height: 15),
              _googleSignInWidget(),
              const SizedBox(height: 50),
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
          border: Border.all(color: Colors.white, width: 0.7),
          shape: BoxShape.rectangle),
      child: const Icon(Icons.menu_book_sharp, color: Colors.white, size: 120),
    );
  }

  Widget _colorBackgraund() {
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

  Widget _loginBtn() {
    return MaterialButton(
      onPressed: signIn,
      color: Colors.cyan,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
  /*Widget _loginBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: GestureDetector(
        onTap: signIn,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue.shade400,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Text(
              'Giriş Yap',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }*/

  /* Widget _loginBtn() {
    return ElevatedButton(

      onPressed: () {
        debugPrint("Mail adresnizi girin : " + usernameController.text);
        debugPrint("Password : " + passwordController.text);
      },

      style: ElevatedButton .styleFrom(
        foregroundColor: Colors.blue,
        backgroundColor: Colors.white,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),

      child: const SizedBox(
          width: double.infinity,
          child: Text(
            "Sign in ",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          )),

    );
  }*/

  Widget _extraText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            //Forget Password
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => ForgetPassword()));
          },
          child: const Text(
            "Forget Password?",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }

  Widget _extraText2() {
    return RichText(
      text: TextSpan(children: [
        const TextSpan(
          text: 'Üye değil misiniz??',
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
                MaterialPageRoute(builder: (context) => SignUpScreen())),
          text: 'Kayıt Ol',
          style: const TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        )
      ]),
    );
  }

  /*Widget _extraText2() {
    return const Text(
      "Hesabınız yok mu? Üye olun",
      textAlign: TextAlign.end,
      style: TextStyle(fontSize: 16, color: Colors.white),
    );
  }*/

  Widget _extraText3() {
    return const Text(
      "Ödünç Kitap",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  Widget _extraText5() {
    return const Text(
      "Ya da",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  Widget _extraText4() {
    return const Text(
      "Giriş Yap",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 28, color: Colors.white70, fontWeight: FontWeight.w700),
    );
  }

  Widget _googleSignInWidget() {
    return FloatingActionButton.extended(
      onPressed: () {
        _googleSignIn(context);
      },
      icon: Image.asset(
        'assets/images/google.png',
        height: 32,
        width: 32,
      ),
      label: Text('Google Hesabınız İle Giriş Yapın'),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    );
  }
}
