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
  const prodWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductResponsse product;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child:Card(
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Colors.white,
            elevation: 10,
            shadowColor: Colors.white,
            child: Column(children:[Padding(padding: EdgeInsets.all(0)) ,
              AutoSizeText(product.Product_Name.toString(),style: TextStyle(fontSize: 30,color: Colors.blue)),
              Row(
                   // mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      Padding(padding: EdgeInsets.all(15)),
                      Container(
                        margin: EdgeInsets.all(10),
                     child: Expanded(child:Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:CrossAxisAlignment.center,
                          children:[  const Text("MP",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.blue)),
                            AutoSizeText("Qty: "+product.Market_Qty.toString(),style: TextStyle(fontSize: 20)),
                            AutoSizeText("${product.Market_Price}/${product.Kg_Ltr}",style: TextStyle(fontSize: 20)),
                            AutoSizeText(product.Total_Market_Price.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color:Colors.blue)),
                          ]),
                     )),
                      Container(height: 80, child: const VerticalDivider(color: Colors.black,thickness: 2,)),
                      Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:CrossAxisAlignment.center,
                              children:[  const Text("SP",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.blue)),
                                AutoSizeText("Qty: "+product.Selling_Qty.toString(),style: TextStyle(fontSize: 20)),
                                AutoSizeText("${product.Selling_Price}/${product.Kg_Ltr}",style: TextStyle(fontSize: 20)),
                                AutoSizeText(product.Total_Selling_Price.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color:Colors.blue)),

                              ])),
        Container(
            margin: EdgeInsets.all(10),
            child:
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:CrossAxisAlignment.center,
                          children:[
                            Image.network(imagePrefix+product.Product_Image,
                              width: 100,height: 100,
                            )]),

        ),]
            ),
              SizedBox(width: 300,
             child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // background
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
              )])));
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
