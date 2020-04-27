// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class getData{
  
//    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//    final FirebaseDatabase _database = FirebaseDatabase.instance;

//    Future<List> getBookingTime() async{
//      var timeList = new List();
//      CollectionReference crf = Firestore.instance.collection("/AllSalon/Bắc Giang/Branch/MCCqxGrnEmMO1T7YB6YH/Barber/clanniko18@gmail.com/21_04_2020");
//      QuerySnapshot _querySnapshot = await crf.getDocuments();
//      _querySnapshot.documents.forEach((element) { 
//        timeList.add(element);
//        print(element);
//      });

//      return timeList;
//    }
// }