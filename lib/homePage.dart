import 'package:abuys/screens/productList.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  String addr="";
  double? lat,long;
   HomePage(this. addr,this.lat,this.long ,{Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String addr="";
  double? lat,long;
  late var pages=[];
  void initState() {
    lat=widget.lat;
    long=widget.long;
    addr=widget.addr;
    pages = [
      ProductListPage(addr!, lat!, long!),
      ProductListPage(addr, lat!, long!),
      ProductListPage(addr, lat!, long!),
    ];

    super.initState();
  }

  int pageIndex = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffC4DFCB),

      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 45,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color:Colors.grey,blurRadius: 5)],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
              Icons.home_filled,
              color: Color(0xff3288ba),
              size: 20,
            )
                : const Icon(
              Icons.home_outlined,
              color: Color(0xff3288ba),
              size: 20,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
              Icons.shopping_cart,
              color: Color(0xff3288ba),
              size: 20,
            )
                : const Icon(
              Icons.shopping_cart_outlined,
              color: Color(0xff3288ba),
              size: 20,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
              Icons.person,
              color: Color(0xff3288ba),
              size: 25,
            )
                : const Icon(
              Icons.person_outline,
              color: Color(0xff3288ba),
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
