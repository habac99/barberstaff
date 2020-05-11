

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

//String salonId;
class StaffData{
  // String salonId;
  getStaffInfor(String email){

    return Firestore.instance
      .collection('Staff')
      .where('Email', isEqualTo : email)
      .getDocuments();
  }
//   getSalonID(String city, String salonName){
//     Firestore.instance.collection('AllSalon')
//                    .document(city)
//                    .collection('Branch')
//                    .where('name', isEqualTo: salonName)
//                    .getDocuments().then((QuerySnapshot docs){
//                       this.salonId = docs.documents[0].documentID;
//                       if(this.salonId.length > 1) print(this.salonId);
//                       else print("Fuck Flutter");
//                       // return salonId;
//                    });
//                    print('this.salonId' + "jhdfjh");
                   

//  }

 getShedule(String email, String city, String salonId) {
      var now = new  DateTime.now();
      
      String dateFormated = DateFormat('dd_MM_yyyy').format(now);
      // String year  = now.year.toString();
      // int month = now.month.toInt();
      // if (month < 10){
      //   monthFormat = "0" + month.toString();
      // }
      // else{
      //   monthFormat = month.toString();
      // }
      // String day   = now.day.toString();
      // String bookingDate = day + "_" + month + "_" + year;
      // print( "this is date" + bookingDate);
      print("this is date " +" " + dateFormated);
      return Firestore.instance.collection('AllSalon')
          .document(city)
          .collection('Branch')
          .document(salonId)
          .collection('Barber')
          .document(email)
          .collection(dateFormated)
          .getDocuments();
 }

  // getShedule(String email, String city, String salonName) {
  //    Firestore.instance.collection('AllSalon')
  //                    .document(city)
  //                    .collection('Branch')
  //                    .where('name', isEqualTo: salonName)
  //                    .getDocuments().then((QuerySnapshot docs){
  //                       String salonId = docs.documents[0].documentID.toString();
  //                       return Firestore.instance.collection('AllSalon')
  //                             .document(city)
  //                             .collection('Branch')
  //                             .document(salonId)
  //                             .collection('Barber')
  //                             .document(email)
  //                             .collection('24_04_2020')
  //                             .getDocuments();

  //                    });
    //  String salonId = testdata[0].documentID.toString();
    //  testdata.then((QuerySnapshot docs){

    //  } );
    //  return Firestore.instance.collection('AllSalon')
    //          .document(city)
    //          .collection('Branch')
    //          .document(salonId)
    //          .collection('Barber')
    //          .document(email)
    //          .collection('24_04_2020')
    //          .getDocuments();

//        print("SalonId: " + salonId);
//        print(testdata[0].documentID);
  
}