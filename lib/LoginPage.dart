import 'package:abuys/screens/productList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>  {

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  double? lat, long;
  String addr="";

  @override
  void initState() {
    checkperm();

    // TODO: implement initState
    super.initState();
  }
  void checkperm() async{
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position =await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    lat=position.latitude;
    long=position.longitude;
    setState(() {
    });
    print(lat);
    print(long);

  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("abuys"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Hey Hi,Hope you are doing Great!',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),

            Container(
                padding: const EdgeInsets.all(10),
                height: 60,
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    print(nameController.text);
                    print(passwordController.text);
                    login();
                  },
                )
            ),
          ],
        ),
      ),
    );
  }

  void toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 12.0);
  }

  login() async {
    if (nameController.text.isEmpty) {
      toast("Please Enter User ID");
    } else if (passwordController.text.isEmpty) {
      toast("Please Enter Password");
    } else {
      List<Placemark> placemark=await placemarkFromCoordinates(lat!, long!);
     addr= placemark.reversed.last.locality! +","+placemark.reversed.last.subLocality!+","+ placemark.reversed.last.country!;
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => ProductListPage(addr)));
    }
  }}
