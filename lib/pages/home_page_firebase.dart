import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:untitled18/pages/book_deskcription_page.dart';
import 'package:untitled18/services/status_service.dart';
import 'package:untitled18/widgets/bottom_nav_bar2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePageFirebase extends StatefulWidget {
  const HomePageFirebase({Key? key}) : super(key: key);

  @override
  State<HomePageFirebase> createState() => _HomePageFirebaseState();
}

class _HomePageFirebaseState extends State<HomePageFirebase> {
  //StatusService _statusService = StatusService();
  TextEditingController t1 = TextEditingController();

  var gelenKitapIsim = "";
  var gelenKitapYazar = "";
  var gelenKitapFiyat = "";
  var gelenKitapResim = "";

  YaziGetir() {
    FirebaseFirestore.instance
        .collection("kitap")
        .doc(t1.text)
        .get()
        .then((gelenVeri) {
      setState(() {
        gelenKitapIsim = gelenVeri.data()!['name'];
        gelenKitapYazar = gelenVeri.data()!['author'];
        gelenKitapFiyat = gelenVeri.data()!['price'];
        gelenKitapResim = gelenVeri.data()!['image'];
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
          margin: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              YaziGetir();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BookDescriptionPage()));
            },
            child: Card(
              elevation: 10,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    /*Image.network(
                      gelenKitapResim,
                      height: 20,
                      width: 20,
                    ),*/
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          gelenKitapIsim,
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          gelenKitapYazar,
                          style: const TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          gelenKitapFiyat,
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),

                        TextButton(
                          onPressed: () {
                            //Navigator.pop(context);
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => const BookDescriptionPage()));
                          },
                          child: const Text(
                            "Daha fazla bilgi",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )


                )
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
