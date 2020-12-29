import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservation_app/models/projectModel.dart';

class DatabaseService{

  final String uid;
  final String taskId;

  DatabaseService({this.uid, this.taskId});

  /////////////////////////////////////////User///////////////////////////////////////////////

  final CollectionReference userCollection = Firestore.instance.collection('user');

  Future<void> updateUserData(String userName) async {
    return await userCollection.document(uid).setData({
      'userName': userName,
    });
  }


  /////////////////////////////////////////Project///////////////////////////////////////////////

  final CollectionReference reservationCollection = Firestore.instance.collection("reservation");


  List<ReservationModel> reservationList(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ReservationModel(
        uid: doc.documentID,
        reservationName: doc.data['reservationName'] ?? '' ,
        reservationPhone: doc.data['reservationPhone'] ?? '',
        reservationEmail: doc.data['reservationEmail'] ?? '' ,
        reservationTime: doc.data['reservationTime'] ?? '',
      );
    }).toList();
  }


  Stream<List<ReservationModel>> get myProject {
    return reservationCollection.orderBy("reservationTime", descending: true).snapshots().map(reservationList);
  }


  addReservationDocument(projectRoom) async{
    final doc = Firestore.instance.collection("reservation").document();
    await doc.setData(projectRoom).catchError((e) {
      print(e);
    });
    return doc.documentID;
  }

  addReservation(String reservationName, String reservationPhone, String reservationEmail) async{
    Map<String, dynamic> reservationRoom = {
      "reservationName" : reservationName,
      "reservationPhone" : reservationPhone,
      "reservationEmail" : reservationEmail,
      "reservationTime": DateTime.now().toString(),
    };
    await DatabaseService().addReservationDocument(reservationRoom);
  }

  Future updateReservationName (String reservationName) async{
    return await reservationCollection.document(uid).updateData({
      'reservationName': reservationName,
    });
  }

  Future updateReservationPhone (String reservationPhone) async{
    return await reservationCollection.document(uid).updateData({
      'reservationPhone': reservationPhone,
    });
  }

  Future updateReservationEmail(String reservationEmail) async{
    return await reservationCollection.document(uid).updateData({
      'reservationEmail': reservationEmail,
    });
  }
  
}


