import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled18/pages/login_page.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

///TickerProviderStateMixin ===> Use  for animation
class _ForgetPasswordState extends State<ForgetPassword>
    with TickerProviderStateMixin {



  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _forgetPassTextController = TextEditingController(text: '');

  ///unitState açılışta bir kere çalışır. Dispose sayfa kapandığında akışı keser optimizasyon için önemli.
  @override
  void dispose() {
    _forgetPassTextController.dispose();
    super.dispose();
  }


  void _forgetPassSubmitForm () async {
    try{
      await _auth.sendPasswordResetEmail(
        email: _forgetPassTextController.text,
      );
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
    }catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //_colorBackgraund();
    return Container(
      child: Scaffold(
        body: Stack(
          children: [
              ///image veneer(kaplamak) the full size of screen
            _colorBackgraund(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              child: ListView(

                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  const Text(
                    'Şifre Sıfırlama',

                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      //fontFamily: 'Signatra',
                      fontSize: 55,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                    'Email Adresi',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _forgetPassTextController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white54,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60,),
                  MaterialButton(
                    onPressed: (){
                      ///create ForgetPassSubmitForm
                      _forgetPassSubmitForm();
                    },
                    color: Colors.cyan,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),

                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'Sıfırla',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
}
