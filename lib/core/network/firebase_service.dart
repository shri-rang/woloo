import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreService {
  final FirebaseFirestore db;
  // FirebaseFirestore ff;

  const CloudFirestoreService(this.db);

  /* .... */

  // get all   `user` collection's documents
  Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() {
    return db.collection('washroom').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTime() {
    return db.collection('monthTest').snapshots();
  }


  Future updateWashroom(
      String? id, bool? status,) async {
    try {
      await db
          .collection('washroom')
          .doc(id)
          .update({
        'occupied': status,

        //'start_time': date, 'color': color

          });
    } catch (e) {
      print(e);
    }
  }

  Future updateOccuipency(
      String? id,
      //String? status, String date, String color,
      bool isOccupied) async {
    try {
      await db.collection('washroom').doc(id).update({
        // 'status': status,
        // 'start_time': date,
        // 'color': color,
        'occupied': isOccupied
      });
    } catch (e) {
      print(e);
    }
  }



  Future loginWashroom(
      String? id,  String date, String time ) async {
    try {
      await db
          .collection('monthTest').doc().set({
        "date": time,
        "title": "Login Time",
        'time': date,});
    } catch (e) {
      print(e);
    }
  }


  Future exitWashroom(
      String? id, String date, String time  ) async {
    try {
      await db
          .collection('monthTest')
          .doc()
          .set({
        "date": date,
        "title": "Exit Time",
        'time': time,  });
    } catch (e) {
      print(e);
    }
  }

  Future announmentTime(
    String? id,
    String date,
      String time
      ) async {
    try {
      await db.collection('monthTest').doc().set({
        "date": time,
        "title": "Announcement Time",
        'time': date,
      });
    } catch (e) {
      print(e);
    }
  }
}
