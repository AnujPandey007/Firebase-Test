import 'package:flutter/material.dart';
import 'package:reservation_app/screens/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{

  /*WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('UserId');*/

  //By using this userId we can take the user to the either home screen or auth screen
  //userId == null ? Wrapper() : HomePage();
  //But I did here with the help of StreamProvider

  runApp(App());
}
