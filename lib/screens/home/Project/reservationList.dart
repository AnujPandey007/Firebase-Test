import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_app/models/projectModel.dart';
import 'reservationTile.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

    final reservationModel = Provider.of<List<ReservationModel>>(context) ?? [];

    if(reservationModel == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }else if(reservationModel.length == 0 ){
      return Container(
        child: Center(
          child: Text(
             "No Reservations",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.grey
            ),
          ),
        ),
      );
    }else{
      return Padding(
        padding: EdgeInsets.only(bottom: 25.0,left: 20.0,right: 20.0, top: 15.0),
        child: Container(
          //height: MediaQuery.of(context).size.height*0.75,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 4,
                blurRadius: 15,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: reservationModel.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ProjectTile(reservationModel: reservationModel[index], index: index);
              }
            ),
          ),
        ),
      );
    }
  }
}