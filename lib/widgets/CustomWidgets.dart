import 'package:abuys/Constants.dart';
import 'package:abuys/ResponseModel/categoryResponse.dart';
import 'package:abuys/ResponseModel/productResponse.dart';
import 'package:abuys/screens/prodListDetail.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:auto_size_text/auto_size_text.dart';

errordialog(dialogContext, String title, String description) {
  var alertStyle = const AlertStyle(
    animationType: AnimationType.grow,
    overlayColor: Colors.black87,
    isCloseButton: true,
    isOverlayTapDismiss: true,
    titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    descStyle:
    TextStyle(color: Colors.red, fontWeight: FontWeight.w500, fontSize: 16),
    animationDuration: Duration(milliseconds: 400),
  );

  Alert(
      context: dialogContext,
      style: alertStyle,
      title: title,
      desc: description,
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.pop(dialogContext);
            },
          color: Colors.pinkAccent,
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        )
      ]).show();
}

class prodWidget extends StatelessWidget {
  const prodWidget({Key? key,required this.product,required this.addr}) : super(key: key);

  final ProductResponsse product;
 final String addr;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child:
        Column(children:[
          AutoSizeText("${product.Product_Name},$addr",style: const TextStyle(fontSize: 18,fontWeight:FontWeight.bold,color: Color(0xff3288ba))),
          Card(
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Colors.white,
            elevation: 10,
            shadowColor: Colors.white,
            child: Column(children:[const Padding(padding: EdgeInsets.all(0)) ,
              Row(
                    children:[
                      const Padding(padding: EdgeInsets.all(12)),
                      Container(
                        margin: const EdgeInsets.all(12),
                     child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:CrossAxisAlignment.center,
                          children:[  const Text("MP",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0xff3288ba))),
                            Text("(₹ ${product.Market_Price}per${product.Kg_Ltr})",style: const TextStyle(fontSize: 10)),
                            AutoSizeText("30.00Kg".toString(),style: TextStyle(fontSize: 15,color:Colors.grey.shade500)),
                            AutoSizeText("₹ ${product.Total_Selling_Price}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color:Color(0x0ff3288BA))),
                          ])),
                      const SizedBox(height: 80, child: VerticalDivider(color: Colors.black,thickness: 2,)),
                      Container(
                          margin: const EdgeInsets.all(12),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:CrossAxisAlignment.center,
                              children:[  const Text("SP",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0xff3288ba))),
                                Text("(₹ ${product.Selling_Price}per${product.Kg_Ltr})",style: const TextStyle(fontSize: 10)),
                                AutoSizeText("30.00Kg".toString(),style: TextStyle(fontSize: 15,color:Colors.grey.shade500)),
                                Text("₹ ${product.Total_Selling_Price}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color:Color(0x0ff3288BA))),

                              ])),
        Container(
            margin: const EdgeInsets.all(12),
            child:
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:CrossAxisAlignment.center,
                          children:[
                            ClipRRect(borderRadius:BorderRadius.circular(8.0),child: Image.network(imagePrefix+product.Product_Image,
                              width: 100,height: 80,
                            ))]),

        ),]
            ),
              SizedBox(width: 300,
             child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  primary: const Color(0x0ff004E7F), // background//005583
                  onPrimary: Colors.white, // foreground
                ),
                child: const Text('Buy'),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ListDetailScreen(
                                  details: product)
                      ));
                  },)
              )]))]));
  }
}
class TryAgainButton extends StatelessWidget {
  const TryAgainButton({Key? key, this.onPressed}) : super(key: key);
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            Lottie.asset("images/tryagain.json", width: 400,height: 300),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: onPressed,
                child: const Text("Try Again")),
          ],
        ));
  }
}
Future<bool> onBackPressed(BuildContext context, ) async {
  return (await Alert(
    context: context,
    type: AlertType.warning,
    title:"Cancel",
    desc:
    "Are you sure want to cancel?",
    buttons: [
      DialogButton(
        onPressed:() {
         Navigator.pop(context);
        },
        width: 120,
        child: const Text(
          "Yes",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      DialogButton(
        onPressed: () {
          Navigator.pop(context);
        },
        width: 120,
        child: const Text(
          "No",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      )
    ],
  ).show()) ??
      false;
}
