import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_app/models/projectModel.dart';
import 'package:reservation_app/service/database.dart';
import 'package:reservation_app/utilities/constants.dart';
import 'addReservation.dart';
import 'reservationList.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    //saveUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ReservationModel>>.value(
      value: DatabaseService().myProject,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: myBar("Reservations List", context: context, show: true),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.orange[800],
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> AddEditProject(title: "Add Reservation", edit: false)));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: BrewList(),
      ),
    );
  }
}