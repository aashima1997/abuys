
import 'package:abuys/LoginPage.dart';
import 'package:abuys/ResponseModel/SubCatResponse.dart';
import 'package:abuys/screens/prodListDetail.dart';
import 'package:abuys/service/apiScreenhelper.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../ResponseModel/categoryResponse.dart';
import '../ResponseModel/productResponse.dart';
import '../widgets/CustomWidgets.dart';

class ProductListPage extends StatefulWidget {
  String addr;
  ProductListPage( this.addr, {Key? key}) : super(key: key);

    @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  late Future<List<ProductResponsse>> prodDownload;
late Future<List<ListResponse>> catogDownload;
late Future<List<SubCatResponse>>subCatogDownload;
  final TextEditingController _searchController = TextEditingController();
    String _keyword = "";


  String addr="";
  @override
  void initState() {
    prodDownload=ApiScreenHelper.getProd();
    catogDownload=ApiScreenHelper.getcatog(context);
    subCatogDownload=ApiScreenHelper.getProdbysubCateg(context,"1");
    addr=widget.addr;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //final filteredList = _getFilteredList();

    return SafeArea(
        bottom: false,
        child: //WillPopScope(
         //   onWillPop: () => onBackPressed(context),
             Scaffold(


               backgroundColor: Colors.white,
               // resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  leading:Image.asset("images/abuysicon.png"),
                  actions:<Widget>[
                    IconButton(onPressed:(){}, icon: const Icon(Icons.notifications,color:Colors.blue) ),
                    IconButton(onPressed:(){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  LoginPage()
                          ));

                    }, icon: const Icon(Icons.logout,color:Colors.blue) )

                  ],
                  surfaceTintColor: Colors.white,
                  centerTitle: true,
                  title:  const Text(
                    "Buyer",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w700),
                  ),
                  iconTheme: const IconThemeData(color: Colors.white),
                  backgroundColor: Colors.blue.shade100,
                ),
                body: FutureBuilder<List>(
                future: Future.wait([prodDownload,catogDownload,subCatogDownload]),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
        child: Lottie.asset(
      "images/load1.json",
        ));
                  }
                  else if (snapshot.data == null) {
                    return TryAgainButton(
                      onPressed: () {
                        setState(() {});
                        },
                    );
                  } else {
                    if (snapshot.data!.isEmpty) {
                      return Column(
                        children: const [
                          Text(
                            "No Data Found",
                            style: TextStyle(
                                fontSize: 17, fontStyle: FontStyle.italic),
                          )
                        ],
                      );
                    } else {
                      return Column(children:[
                        const Padding(padding: EdgeInsets.all(5)),
                      Row(
                       children: [
                       Expanded(child: TextField(decoration: InputDecoration(
                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
                           ),filled: true,
                         hintText: "Category",
                         fillColor: Colors.blue.shade100,
                         hintStyle: const TextStyle(
                           color:Colors.black
                         ),
                         prefixIcon: const Icon(Icons.filter_list,color: Colors.black,)
                       ),
                         onTap: (){
                           bottomSheetShow(context,snapshot.data[1]);
                           },
                         readOnly: true,
                       )
                       ),
                         const SizedBox(width: 5,height: 5,),

                         Expanded(child: TextField(decoration: InputDecoration(
                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
                             ),filled: true,
                             hintText: "Sub-Category",
                             fillColor: Colors.blue.shade100,

                             hintStyle: const TextStyle(
                                 color:Colors.black
                             ),
                             prefixIcon: const Icon(Icons.filter_list,color: Colors.black,)
                         ),
                           onTap: (){
                             bottomSheetsubShow(context,snapshot.data[2]);
                           },
                           readOnly: true,
                         )
                         ),

                         const SizedBox(width: 10,),

                       ],
                      ),
                        Row(children: [IconButton(onPressed:(){}, icon: const Icon(Icons.location_on,color:Colors.blue) ),

                          AutoSizeText(addr,style:const TextStyle(fontSize: 20,color:Colors.blue,),maxLines: 2,)]),
                  Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',hoverColor: Colors.blue,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear,color: Colors.blue,),
                    onPressed: () => _searchController.clear(),
                  ),
                        prefixIcon: IconButton(
                          icon: Icon(Icons.search,color: Colors.blue,),
                          onPressed: () {

                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                  onChanged: (text) {
                  setState(() {
                  _keyword = text;
                  });
                  })),
                        Expanded(child:ListView.builder(

                        padding: const EdgeInsets.all(5),
                         // shrinkWrap: true,
                        //  physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data![0].length ,
                          itemBuilder: (BuildContext ctx, int index) {
                            final product = snapshot.data
                            ![0][index];
                            return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ListDetailScreen(
                                                details: product)
                                    )),
                              child:prodWidget(product: product));
                            },
                      ))]);
                    }
                  }
                }))
    );}

void bottomSheetShow(BuildContext ctx,List<ListResponse> categ) {
  showModalBottomSheet(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.blue.shade100,
      context: ctx,
      builder: (ctx) => Container(
        color: Colors.white54,
        alignment: Alignment.center,
        child: ListView.builder(
          itemCount: categ.length,
            itemBuilder: (context,index){
            return ListTile(
              onTap: () async{
                catogDownload= ApiScreenHelper.getcatog(context);
                setState(() {});
                Navigator.pop(context);
                },
              leading: const Icon(Icons.shopping_bag_outlined),
              title:Text(categ[index].category_name,style: TextStyle(fontSize: 20),) ,
            );
            }
        ),
      ));
}
 /* List<ProductResponsse> _getFilteredList() {
    if (_keyword.isEmpty) {
      return assetList;
    }
    return assetList
        .where((user) =>
        user.Product_Name.toLowerCase().contains(
            _keyword.toLowerCase())).toList();
  }*/

  void bottomSheetsubShow(BuildContext ctx,List<SubCatResponse> categ) {
    showModalBottomSheet(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.blue.shade100,
        context: ctx,
        builder: (ctx) => Container(
          color: Colors.white54,
          alignment: Alignment.center,
          child: ListView.builder(
              itemCount: categ.length,
              itemBuilder: (context,index){
                String catogname=categ[index].sub_category_id;
                return ListTile(
                  onTap: () async{
                    subCatogDownload= ApiScreenHelper.getProdbysubCateg(context,catogname);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.shopping_bag_outlined),
                  title:Text(categ[index].sub_category_name,style: TextStyle(fontSize: 20),) ,
                );
              }
          ),
        ));
  }

  /*List<ProductResponsse> _getFilteredList() {
    if (_keyword.isEmpty) {
      return assetList;
    }
    return assetList
        .where((user) =>
        user.name.toLowerCase().contains(
            _keyword.toLowerCase())).toList();
  }*/

}



