import 'package:flutter/material.dart';
import 'package:untitled18/widgets/bottom_nav_bar2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePageEx extends StatefulWidget {
  const HomePageEx({Key? key}) : super(key: key);

  @override
  State<HomePageEx> createState() => _HomePageExState();
}

class _HomePageExState extends State<HomePageEx> {

  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  var gelenYaziIsim = "";
  var gelenYaziSoyad = "";
  var gelenYaziResim = "";
  var gelenYaziKitaplar = "";
  var gelenYaziMail = "";
  var gelenYaziAdres = "";
  var gelenKitapResim = "";
  var gelenKitapResim1 = "";




  YaziGetir() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(t1.text)
        .get()
        .then((gelenVeri) {
      setState(() {
        gelenYaziIsim = gelenVeri.data()!['name'];
        gelenYaziSoyad = gelenVeri.data()!['surname'];
        gelenYaziResim = gelenVeri.data()!['image'];
        gelenYaziKitaplar = gelenVeri.data()!['kitaplar'];
        gelenYaziMail = gelenVeri.data()!['mail'];
        gelenYaziAdres = gelenVeri.data()!['adres'];
        gelenKitapResim = gelenVeri.data()!["bookImage"];
        gelenKitapResim1 = gelenVeri.data()!["bookImage1"];
      });

    });
  }







  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
        //bottomNavigationBar: BottomNavigationBarForApp(indexNum: 0),
        backgroundColor: Colors.transparent,
        appBar: AppBar(

          title: const Text("Kitap Açıklama Sayfası"),
          leading: GestureDetector(
            onTap: () { /* Write listener code here */ },
            child: const Padding(
              padding: EdgeInsets.only(left: 12),
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                )
            ),
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(
                      Icons.more_vert
                  ),
                )
            ),
          ],
        ),

        body: Container(
          margin: const EdgeInsets.all(40),
          child: SingleChildScrollView(
            child: Center(

              child: Column(
                children: [
                  Text(gelenYaziIsim, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                  Text(gelenYaziSoyad, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(gelenYaziResim),
                    radius: size.height* 0.08,
                  ),



                  Text(gelenYaziMail, style: const TextStyle(fontSize: 18),),
                  Text(gelenYaziAdres, style: const TextStyle(fontSize: 15),),

                  Text(gelenYaziKitaplar),
                  Card(
                    color: Colors.transparent,
                    child:
                    Image.network(gelenKitapResim, width: 130, height: 190,),

                  ),


                  Card(
                    color: Colors.transparent,
                    child:  Image.network(gelenKitapResim1, width: 130, height: 190,),),


                  // SizedBox(height: 60,),






                  //Text(gelenYaziIsim),
                  //Text(gelenYaziIsim),

                ],

              ),
            ),
          ),

        ),

      ),



    );

  }
  Widget imageCard() => Card (
    child: Stack(
      children: const [
        //Ink.image(image: )
      ],
    ),
  );
}
