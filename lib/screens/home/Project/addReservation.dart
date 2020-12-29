import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservation_app/service/database.dart';
import 'package:reservation_app/utilities/constants.dart';

class AddEditProject extends StatefulWidget {

  final String title;
  final String reservationName;
  final String reservationPhone;
  final String reservationEmail;
  final String reservationTime;
  final bool edit;
  final String projectId;

  AddEditProject({this.title, this.reservationName, this.reservationPhone, this.reservationEmail, this.reservationTime, this.edit, this.projectId});

  @override
  _AddEditProjectState createState() => _AddEditProjectState();
}

class _AddEditProjectState extends State<AddEditProject> {

  String reservationName;
  String reservationPhone;
  String reservationEmail;
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: myBar(widget.title),
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: () {
          if(widget.edit == true){
            deleteDialog(context, widget.projectId);
          }
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.orange[800],
        tooltip: 'Delete Reservation',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5.0),
                      //height: 60,
                      child: TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: "Reservation Name",
                        ),
                        maxLength: 100,
                        initialValue: widget.reservationName,
                        validator: (val) => val.isEmpty ? 'Enter reservation name' : null,
                        onChanged: (val) {
                          setState(() => reservationName = val);
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      child: TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: "Phone number",
                        ),
                        initialValue: widget.reservationPhone,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        validator: (val) {
                          if(val.isEmpty && !validateNumber(val)) {
                            return 'Enter valid number';
                          }else {
                            return null;
                          }
                        },
                        onChanged: (val) {
                          setState(() => reservationPhone = val);
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      //height: 60,
                      child: TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: "Email Id",
                        ),
                        initialValue: widget.reservationEmail,
                        validator: (val) {
                          if(val.isEmpty) {
                            return 'Enter email id';
                          }else {
                            return null;
                          }
                        },
                        onChanged: (val) {
                          setState(() => reservationEmail = val);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 2.0),
                child: Container(
                  height: 40.0,
                  width: 380,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.orange[900], Colors.orange[500]]
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: MaterialButton(
                    child: Text(
                      'Submit',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0
                        ),
                      ),
                    ),
                    color: Colors.transparent,
                    elevation: 0.0,
                    highlightElevation: 0.0,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    height: 50.0,
                    minWidth: 320.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        if(widget.edit == true){
                          if(widget.reservationName != reservationName) {
                            var checking = await checkReservation(reservationName);
                              if (checking == false) {
                                await DatabaseService(uid: widget.projectId).updateReservationName(reservationName ?? widget.reservationName);
                              }
                            }
                            if(widget.reservationEmail != reservationEmail){
                              await DatabaseService(uid: widget.projectId).updateReservationEmail(reservationEmail  ?? widget.reservationEmail);
                            }
                            if(widget.reservationPhone != reservationPhone){
                              await DatabaseService(uid: widget.projectId).updateReservationPhone(reservationPhone  ?? widget.reservationPhone);
                            }
                            myDialog(context, "Reservation successfully edited", true);
                        }else{
                          var checking = await checkReservation(reservationName);
                          if(checking == true){
                            myDialog(context, "Reservation name already exist, please change the Reservation name", false);
                          }else{
                            await DatabaseService().addReservation(reservationName, reservationPhone, reservationEmail);
                            myDialog(context, "Reservation Successfully Added", true);
                          }
                        }
                      }
                    }
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
