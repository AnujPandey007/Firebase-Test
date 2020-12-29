import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservation_app/models/projectModel.dart';
import 'addReservation.dart';

class ProjectTile extends StatefulWidget {

  final ReservationModel reservationModel;
  final int index;
  ProjectTile({ this.reservationModel, this.index});

  @override
  _ProjectTileState createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            if(widget.index != 0) ... [
              Divider(
                thickness: 0.5,
                color: Colors.grey,
              ),
            ],
            ListTile(
              title: Text(
                widget.reservationModel.reservationName,
                style: GoogleFonts.playfairDisplay(
                  color: Colors.black,
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w700
                  )
                ),
              ),
              subtitle: Text(
                widget.reservationModel.reservationTime.toString().substring(0, 16),
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> AddEditProject(
                    title: "Edit Reservation",
                    reservationName: widget.reservationModel.reservationName,
                    reservationTime: widget.reservationModel.reservationTime.toString(),
                    reservationEmail: widget.reservationModel.reservationEmail,
                    reservationPhone: widget.reservationModel.reservationPhone,
                    projectId: widget.reservationModel.uid,
                    edit: true,
                  )));
                },
                icon: Icon(Icons.edit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}