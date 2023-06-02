import 'package:flutter/material.dart';
import 'package:untitled18/constants/constants.dart';
import 'package:untitled18/model/book_model.dart';
import 'package:untitled18/pages/profile_page.dart';
import 'package:untitled18/widgets/bottom_nav_bar2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  var gelenKitapIsim = "";
  var gelenKitapYazar = "";
  var gelenYaziSoyad = "";
  var gelenYaziResim = "";
  var gelenKitapResim = "";
  var gelenKitapAciklama = "";

  YaziGetirArama() {
    FirebaseFirestore.instance
        .collection("books")
        .doc(t2.text)
        .get()
        .then((gelenVeri) {
      setState(() {
        gelenKitapIsim = gelenVeri.data()!['book_name'];
        gelenKitapYazar = gelenVeri.data()!["writer"];
        gelenKitapResim = gelenVeri.data()!["book_image"];
        gelenKitapAciklama = gelenVeri.data()!["book_description"];
      });
    });
  }
  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      double value = controller.offset / 119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  static List<BookModel> BOOK_DATA = [
    //BookModel("Ana", "Maksim Gorki", 12, "ana.png", 15),
  ];

  List<BookModel> display_list = List.from(BOOK_DATA);


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
        bottomNavigationBar: BottomNavigationBarForApp(indexNum: 1),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            "Kitap Arama Sayfası",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.5,
        ),
        body: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              TextField(
                controller: t2,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Ör. İnce Memed",
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: Colors.black,
                ),
              ),

              TextButton(
                  onPressed: YaziGetirArama,
                  child: const Text(
                    "Kitap Ara",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  )),
              /*Card(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(

                    ),
                      Text(gelenKitapIsim),
                      Text(
                        gelenKitapYazar,
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                      Image.network(
                        gelenKitapResim,
                        width: 180,
                        height: 210,
                      ),
                      Text(
                        gelenKitapAciklama,
                        style: const TextStyle(
                            fontSize: 25,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),*/
              Card(

                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  color: Colors.transparent,
                /*decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
          ]),*/
                child: Padding(

                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Image.network(
                        gelenKitapResim,
                        width: 180,
                        height: 110,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            gelenKitapIsim,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            gelenKitapYazar,
                            style: const TextStyle(fontSize: 19, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 10,
                          ),


                          TextButton(
                            onPressed: () async {
                              /*//Navigator.pop(context);
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => const ProfilePage()));*/
                              String? encodeQueryParameters(
                                Map<String, String> params) {
                                return  params.entries
                                    .map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                .join('&');
                              }
                              final Uri emailUri = Uri(
                                scheme: 'mailto',
                                path: 'ozanakts58@gmail.com',
                                query: encodeQueryParameters(<String, String>{
                                  'subject':'Ödünç Kitap Uygulaması',
                                  'body':'$gelenKitapIsim kitabınızı ödünç almak istiyorum. Ne zaman müsait olursunuz?',
                                }),
                              );
                              //if(await canLaunchUrl(emailUri)) {
                               // launchUrl(emailUri);
                              //} else {
                               // throw Exception('Could not launch $emailUri');
                              //}
                              try{
                                await launchUrl(emailUri);
                              } catch (e) {
                                print(e.toString());
                              }

                            },
                            child: const Text(
                              "Mail İle Ödünç Al",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          ElevatedButton(onPressed: () async {
                               final Uri url = Uri(
                                scheme: 'sms',
                                path: '0537 457 96 29'
                               );
                               if (await canLaunchUrl(url)) {
                                 await launchUrl(url);
                               } else {
                                 print('Show dialog: cannot lauch this url');
                               }
                          },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade50),
                            child: const Text('Sms'),

                          ),
                          /*TextButton(
                            onPressed: () async {
                              /*//Navigator.pop(context);
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => const ProfilePage()));*/
                              String? encodeQueryParameters(
                                  Map<String, String> params) {
                                return  params.entries
                                    .map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                    .join('&');
                              }
                              final Uri emailUri = Uri(
                                scheme: 'sms',
                                path: '05374579629',
                                query: encodeQueryParameters(<String, String>{
                                  'subject':'Ödünç Kitap Uygulaması',
                                  'body':'$gelenKitapIsim kitabınızı ödünç almak istiyorum. Ne zaman müsait olursunuz?',
                                }),
                              );
                              //if(await canLaunchUrl(emailUri)) {
                              // launchUrl(emailUri);
                              //} else {
                              // throw Exception('Could not launch $emailUri');
                              //}
                              try{
                                await launchUrl(emailUri);
                              } catch (e) {
                                print(e.toString());
                              }

                            },
                            child: const Text(
                              "SMS İle Ödünç Al",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                              ),
                            ),

                                ),*/
                        ],

                      ),

                      /* Image.asset(
                    "assets/images/${post["image"]}",
                    height: double.infinity,
                     width: double.infinity,
                  ),*/
                    ],
                  ),
               /*Text(
                    gelenKitapAciklama,
                    style: const TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),*/
                ),

              ),

              //Text(gelenKitapIsim, style: TextStyle(fontSize: 25, color: Colors.red, fontWeight: FontWeight.bold),),

              const SizedBox(height: 15.0),
              /*Container(

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
                        TextButton(onPressed: YaziGetirArama, child: const Text("profil getir", style: TextStyle(fontSize: 25,),)),
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

              ),*/

              Expanded(
                child: ListView.builder(
                  itemCount: display_list.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      display_list[index].name!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      display_list[index].author!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      "${display_list[index].price}",
                      style: const TextStyle(
                        color: Colors.white10,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

    );
  }
}
