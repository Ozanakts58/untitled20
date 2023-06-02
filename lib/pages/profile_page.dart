import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:untitled18/services/status_service.dart';
import 'package:untitled18/widgets/bottom_nav_bar2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //StatusService _statusService = StatusService();
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

    return  Container(
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
        bottomNavigationBar: BottomNavigationBarForApp(indexNum: 3),

        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            "Profil Sayfası",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.5,
        ),
        body: Container(

          margin: const EdgeInsets.all(40),
          child: SingleChildScrollView(
          child: Center(

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: t1,

                  ),
                ),
                TextButton(onPressed: YaziGetir, child: const Text("profil getir", style: TextStyle(fontSize: 25,),)),
                Text(gelenYaziIsim, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                Text(gelenYaziSoyad, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(gelenYaziResim),
                  radius: size.height* 0.08,
                ),



                Text(gelenYaziMail, style: TextStyle(fontSize: 18),),
                Text(gelenYaziAdres, style: TextStyle(fontSize: 15),),

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
    /*return StreamBuilder(
        stream: _statusService.getStatus(),
        builder: (context, snaphot) {
          return snaphot.hasData
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: snaphot.data?.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot mypost = snaphot.data!.docs[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text("${mypost['users']}"),
                                const SizedBox(height: 10),
                                Center(
                                  child: CircleAvatar(
                                    backgroundImage: mypost['image'] == ""
                                        ? AssetImage("assets/images/siyah.png")
                                        : NetworkImage(mypost['image']),
                                    radius: size.height *0.08,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
        });*/
  }
}
