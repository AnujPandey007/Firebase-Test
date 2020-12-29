import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservation_app/screens/authenticate/signIn.dart';
import 'package:reservation_app/service/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeColor = Color(0xfff5a623);
final greyColor = Color(0xffaeaeae);
final greyColor2 = Color(0xffE8E8E8);

class ConstantsForQuestion{
  static const String Edit = 'Edit';
  static const String Delete = 'Delete';
  static const List<String> choices = <String>[
    Edit,
    Delete,
  ];
}
Future<bool> checkReservation(String reservationName) async{
  final check = await Firestore.instance.collection('reservation').where("reservationName", isEqualTo: reservationName).getDocuments();
  return check.documents.length > 0;
}

void saveUser() async{
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("UserId", user.uid);
}

bool validateNumber(String value) {
  String  pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40.0))),
  hintStyle: TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  ),
);


Widget myBar(String name, {bool show = false, BuildContext context}){
  return SafeArea(
    child: Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft:  Radius.circular(20)),
        gradient: LinearGradient(
          colors: [Colors.orange[800],Colors.orange[600]],
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            if (show == true) ... [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: IconButton(
                  icon: Icon(Icons.logout, color: Colors.white, size: 30,),
                  onPressed: () async{
                    await AuthService().signingOut();
                    //SharedPreferences prefs = await SharedPreferences.getInstance();
                    //prefs.remove('UserId');
                  },
                ),
              ),
            ],
          ],
        )
      ),
    ),
  );
}

Future<bool> myDialog(context, String info, bool show) {
  return showDialog(
      context: context,
      builder: (context)=> AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        title: Text(
          info,
          style: TextStyle(
              fontSize: 15.0
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            shape: StadiumBorder(),
            elevation: 1.0,
            color: Colors.white,
            child: Text(
              "Ok",
              style: TextStyle(
                  color: Colors.orange
              ),
            ),
            splashColor: Colors.orange[600],
            onPressed: () {
              Navigator.pop(context,true);
              if(show == true){
                Navigator.pop(context,true);
              }
            },
          ),
        ],
      )
  );
}

Future<bool> deleteDialog(context, String projectId) {
  return showDialog(
      context: context,
      builder: (context)=> AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        title: Text(
          "Are you sure about deleting the Reservation?",
          style: TextStyle(
              fontSize: 15.0
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            shape: StadiumBorder(),
            elevation: 1.0,
            color: Colors.white,
            child: Text(
              "Yes",
              style: TextStyle(
                  color: Colors.orange
              ),
            ),
            splashColor: Colors.orange[600],
            onPressed: () async{
              await Firestore.instance.collection("reservation").document(projectId).delete();
              Navigator.pop(context,true);
              Navigator.pop(context,true);
            },
          ),
          MaterialButton(
            shape: StadiumBorder(),
            elevation: 1.0,
            color: Colors.white,
            child: Text(
              "No",
              style: TextStyle(
                  color: Colors.orange
              ),
            ),
            splashColor: Colors.orange[600],
            onPressed: () {
              Navigator.pop(context,true);
            },
          ),
        ],
      )
  );
}





