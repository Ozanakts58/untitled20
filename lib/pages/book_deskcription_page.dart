import 'package:flutter/material.dart';
import 'package:untitled18/constants/constants.dart';
import 'package:untitled18/services/global_veriables.dart';
import 'package:untitled18/widgets/bottom_nav_bar2.dart';

class BookDescriptionPage extends StatefulWidget {
  const BookDescriptionPage({super.key});
  @override
  State<BookDescriptionPage> createState() => _BookDescriptionPageState();
}

class _BookDescriptionPageState extends State<BookDescriptionPage> {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Widget> itemsData = [];

  void getPostsData() {
    List<dynamic> responseList = BOOK_DATA;
    List<Widget> listItems = [];
    responseList.indexOf((post) {
      listItems.add(
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),

          /*decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
          ]),*/
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  "assets/images/${post["image"]}",
                  height: 180,
                  width: 110,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      post["name"],
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      post["author"],
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${post["price"]} \₺",
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        responseList.indexOf(post);
                      },
                      child: const Text(
                        "Daha fazla bilgi",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),


                /* Image.asset(
                    "assets/images/${post["image"]}",
                    height: double.infinity,
                     width: double.infinity,
                  ),*/
              ],
            ),
          ),
        ),
      );
    });
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
    controller.addListener(() {
      double value = controller.offset / 119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
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
        appBar: AppBar(
          title: Text("Kitap Açıklama Sayfası"),
          leading: GestureDetector(
            onTap: () {/* Write listener code here */},
            child: Padding(
              padding: EdgeInsets.only(left: 12),

            ),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    getPostsData();
                  },
                  child: const Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    getPostsData();
                  },
                  child: Icon(Icons.more_vert),
                )),
          ],
        ),
        body: ListView.builder(
            controller: controller,
            itemCount: itemsData.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              double scale = 1.0;

              return Opacity(
                opacity: scale,
                child: Transform(
                  transform: Matrix4.identity()..scale(scale, scale),
                  alignment: Alignment.bottomCenter,
                  child: Align(
                      heightFactor: 0.8,
                      alignment: Alignment.topCenter,
                      child: itemsData[index]),
                ),
              );
            }),
      ),
    );
  }

/*Widget _page() {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(
      height: 230,
      child: Stack(
        children: [
          Positioned(

              child: Material(
                 child: Container(
              height: 180.0,
              width: width * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0.0),
                  new BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: new Offset(-10.0, 10.0),
                      blurRadius: 20.0,
                      spreadRadius: 4.0)],
              ),
            ),
          ),),
        ],
      ),
    );
  }*/
}
