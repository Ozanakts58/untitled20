import 'package:flutter/material.dart';
import 'package:untitled18/constants/constants.dart';
import 'package:untitled18/model/book_model.dart';
import 'package:untitled18/widgets/bottom_nav_bar2.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static List<BookModel> BOOK_DATA = [
    BookModel("Ana", "Maksim Gorki", 12, "ana.png"),
  ];

  List<BookModel> display_list = List.from(BOOK_DATA);

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
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              TextField(
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
              const SizedBox(height: 15.0),
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
                      style: const  TextStyle(
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
      ),
    );
  }
}
