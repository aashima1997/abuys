import 'package:abuys/Constants.dart';
import 'package:abuys/ResponseModel/Cart.dart';
import 'package:abuys/ResponseModel/productResponse.dart';
import 'package:abuys/service/apiScreenhelper.dart';
import 'package:flutter/material.dart';


class ListDetailScreen extends StatefulWidget {
   const ListDetailScreen({Key? key,required this.details}) : super(key: key);
  final ProductResponsse details;
  @override
  State<ListDetailScreen> createState() => _ListDetailScreenState();
}

class _ListDetailScreenState extends State<ListDetailScreen> {
  List cartList=[];
  int count=0;
double totPrice=0.0;
var toast=ApiScreenHelper();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      bottom: false,
        child:  Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  centerTitle: true,
                   title:  const Text(
                    "Product Details",
                    style: TextStyle(
                        color: Color(0x0ff3288BA),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700),
                  ),
                  iconTheme: const IconThemeData(color: Colors.black),
                  backgroundColor: Colors.blue.shade100,
                ),
                body:
                        Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                             const Padding(padding: EdgeInsets.all(10)),
                      Expanded(child:  Image.network(imagePrefix+widget.details.Product_Image,
                                width: 250,height: 250,),),
                              Container(
                                margin: const EdgeInsets.all(10),
                                height:40,width: 200,decoration: BoxDecoration(
                                  color: const Color(0x0ff004E7F),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                       const Text("Add to Cart:   ",style: TextStyle(color: Colors.white),),
                               InkWell(
                                   onTap:(){
                                     setState((){
                                       if(count>=1) {
                                         count--;
                                         totPrice=(count.toDouble()*widget.details.Selling_Price);
                                       }
                                     });
                                   } ,
                                   child:const Icon(Icons.remove,color:Colors.white)
                               ),  Text("   $count   ",style: const TextStyle(color: Colors.white),
                               ),
                               InkWell(
                                   onTap:(){
                                     setState((){
                                       count++;
                                       totPrice=(count.toDouble()*widget.details.Selling_Price);
                                     });
                                   } ,
                                   child:const Icon(Icons.add,color:Colors.white)
                               ),
                             ],),),
                              Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(40),
                                  height: MediaQuery.of(context).size.height*0.5,
                              width: double.infinity,
                              decoration:  BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)
                              ),
                                color: Colors.blue.shade100,
                              ),child:SingleChildScrollView(child:Column(children: [
                                Text(widget.details.Product_Name,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                                  const SizedBox(height: 10,),
                                  Text("Rs.${widget.details.Selling_Price}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                                const SizedBox(height: 10,),
                                const SizedBox(height: 20,),
                                Text("Total Price:  $totPrice",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 26),),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                    padding: const EdgeInsets.all(10),
                                    height: 50,

                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        primary: Color(0x0ff004E7F), // background//005583
                                        onPrimary: Colors.white, // foreground
                                      ),
                                      child: const Text('Proceed'),
                                      onPressed: () {
                                        if(count==0){
                                          toast.toast("Add Quantity to Proceed");
                                        }else {
                                          addCart();
                                          }},)
                                ),
                              ],)
                              ) )])));
  }

  void addCart() async{
    Cart cartItems=Cart(
        widget.details.Product_Id.toString(),
        widget.details.Product_Name,
        count,
        totPrice
    );
    cartList.add(cartItems);
 }}
