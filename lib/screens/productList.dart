
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
      double lat,long;
  ProductListPage( this.addr, this.lat, this.long, {Key? key}) : super(key: key);

    @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  late Future<List<ProductResponsse>> prodDownload;
late Future<List<ListResponse>> catogDownload;
late Future<List<SubCatResponse>>subCatogDownload;
List<ProductResponsse>? searchprodlist=[];
  List<ProductResponsse>? listProduct=[];
FocusNode focusNode=FocusNode();
  FocusNode focusNode1=FocusNode();

  final TextEditingController _searchController = TextEditingController();
    String searchkeywrd = "";
bool isSearch= false;

  String addr="";
  double? lat,long;
  @override
  void initState() {
    lat=widget.lat;
    long=widget.long;
    prodDownload=ApiScreenHelper.getProd(lat!, long!,"","");
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
                    IconButton(onPressed:(){}, icon: const Icon(Icons.notifications,color:Color(0x0ff3288BA)) ),
                    IconButton(onPressed:(){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  LoginPage()
                          ));

                    }, icon:  Icon(Icons.logout,color:Color(0x0ff3288BA)) )

                  ],
                  surfaceTintColor: Colors.white,
                  centerTitle: true,
                  title:  const Text(
                    "Buyer",
                    style: TextStyle(
                        color: Color(0x0ff3288BA),
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                  iconTheme: const IconThemeData(color: Colors.white),
                  backgroundColor: Colors.blue.shade100,
                ),
                body:isSearch ? listSearhProd() : listProducts())
    );}
  Widget listSearhProd(){
//    _searchController.text=searchkeywrd;
    focusNode.requestFocus();
    _searchController.value=TextEditingValue(text: searchkeywrd,selection: TextSelection.collapsed(offset: searchkeywrd.length));
    return Column(children:[
      const Padding(padding: EdgeInsets.all(5)),
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            focusNode: focusNode,
             controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',hoverColor: Colors.blue,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear,color: Color(0xff3288ba),),
                  onPressed: () => _searchController.clear(),
                ),
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search,color: Color(0xff3288ba),),
                  onPressed: () {

                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onChanged: (keyword) {
                if(keyword.isEmpty){
                  isSearch=false;
                  setState(() {
                  });
                }
                searchkeywrd=keyword;
                searchprodlist = listProduct!.where((product) => product.Product_Name.toLowerCase().contains(keyword)).toList();
                setState(() {
                });
             })),

      Expanded(child:ListView.builder(

        padding: const EdgeInsets.all(5),
        // shrinkWrap: true,
        //  physics: const BouncingScrollPhysics(),
        itemCount: searchprodlist!.length ,
        itemBuilder: (BuildContext ctx, int index) {
          final product = searchprodlist![index];
          return GestureDetector(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ListDetailScreen(
                              details: product)
                  )),
              child:
              prodWidget(product: product,addr:addr));
        },
      ))]);
  }
Widget listProducts(){
   // focusNode1.requestFocus();
    return FutureBuilder<List>(
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
              listProduct=snapshot.data![0];
              return Column(children:[
                const Padding(padding: EdgeInsets.all(5)),
                Row(
                  children: [
                    Expanded(child: TextField(decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color:Colors.white)
                      ),filled: true,
                      fillColor: Colors.blue.shade100,
                      hintStyle: const TextStyle(
                          color:Colors.black
                      ),labelText: "Category",
                      prefixIcon: const Icon(Icons.list,color: Color(0x0ff3288BA),),
                      suffixIcon: const Icon(Icons.arrow_forward_ios_sharp ,color: Color(0x0ff3288BA),),

                    ),

                      onTap: (){
                        bottomSheetShow(context,snapshot.data[1]);
                      },
                      readOnly: true,
                    )
                    ),
                    const SizedBox(width: 5,height: 5,),

                    Expanded(child: TextField(decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color:Colors.white)
                      ),filled: true,
                      fillColor: Colors.blue.shade100,

                      hintStyle: const TextStyle(
                          color:Colors.black
                      ),
                      labelText: "SubCategory",
                      prefixIcon: const Icon(Icons.list,color: Color(0xff3288ba),),
                      suffixIcon: const Icon(Icons.arrow_forward_ios_sharp ,color: Colors.black,),
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
                Row(children: [IconButton(onPressed:(){}, icon: const Icon(Icons.location_on,color:Color(0xff3288ba)) ),

                  AutoSizeText(addr,style:const TextStyle(fontSize: 15,color:Colors.black,),maxLines: 2,)]),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      focusNode: focusNode1,
                       // controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search...',hoverColor: Colors.blue,
                       /*   suffixIcon: IconButton(
                            icon: const Icon(Icons.clear,color: Color(0xff3288ba),),
                            onPressed: () {
                              isSearch=true;
                              setState(()
                                  {
                                  });
                              searchprodlist = searchprodlist!.toList();

                            }
                          ),*/
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.search,color: Color(0xff3288ba),),
                            onPressed: () {

                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onChanged: (keyword) {
                            if(keyword.isEmpty){
                              isSearch=false;
                              setState(() {
                              });
                            }
                            if(keyword.isNotEmpty){
                              searchkeywrd=keyword;
                              isSearch=true;
                              setState(() {
                              });
                            }
                            searchprodlist = listProduct!.where((product) => product.Product_Name.toString().toLowerCase().contains(keyword)).toList();
                        })),
               // AutoSizeText("$addr",style: const TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Color(0xff3288ba))),

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
                        child:
                        prodWidget(product: product,addr:addr));
                  },
                ))]);
            }
          }
        });
}
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
               // catogDownload= ApiScreenHelper.getcatog(context);
                prodDownload=ApiScreenHelper.getProd(lat!, long!,categ[index].category_id,categ[index].category_id);
                setState(() {});
                Navigator.pop(context);
                },
              leading: const Icon(Icons.shopping_bag_outlined),
              title:Text(categ[index].category_name,style: const TextStyle(fontSize: 20),) ,
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
                  //  subCatogDownload= ApiScreenHelper.getProdbysubCateg(context,catogname);
                    prodDownload=ApiScreenHelper.getProd(lat!, long!,categ[index].category_id,categ[index].sub_category_id);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.shopping_bag_outlined),
                  title:Text(categ[index].sub_category_name,style: const TextStyle(fontSize: 20),) ,
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



