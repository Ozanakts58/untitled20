import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled18/widgets/bottom_nav_bar2.dart';

class BookAddPageExample extends StatefulWidget {
  const BookAddPageExample({Key? key}) : super(key: key);

  @override
  State<BookAddPageExample> createState() => _BookAddPageExampleState();
}

class _BookAddPageExampleState extends State<BookAddPageExample> {
  final _firestore = FirebaseFirestore.instance;
  TextEditingController bookNameController = TextEditingController();
  TextEditingController bookAuthorController = TextEditingController();
  TextEditingController pageNumberController = TextEditingController();

  @override
  void dispose() {
    bookNameController.dispose();
    bookAuthorController.dispose();
    pageNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference bookRef = _firestore.collection('bookss');
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
            "Kitap Ekleme Sayfası",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.5,
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: bookNameController,
                        decoration: InputDecoration(hintText: 'Kitap Adını Giriniz:', icon: Icon(Icons.menu_book, color: Colors.blue,)),
                      ),
                      TextFormField(
                        controller: bookAuthorController,
                        decoration: InputDecoration(hintText: 'Yazar ismini Giriniz',icon: Icon(Icons.account_circle, color: Colors.blue,),),
                      ),
                      TextFormField(
                        controller: pageNumberController,
                        decoration: InputDecoration(hintText: 'Sayfa Sayısını Giriniz', icon: Icon(Icons.numbers, color: Colors.blue,)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text('Ekle'),
          onPressed: () async {
            print(bookNameController.text);
            print(bookAuthorController.text);
            print(pageNumberController.text);

            Map<String, dynamic> bookData= {
              'name':bookNameController.text,
              'author':bookAuthorController.text,
              'page':pageNumberController.text,
            };
            //Kitap ismi yeniyse yeni document oluşturur daha onceden varsa değerini değiştirir.
            await bookRef.doc(bookNameController.text).set(bookData);
          },
        ),
      ),
    );
  }
}
