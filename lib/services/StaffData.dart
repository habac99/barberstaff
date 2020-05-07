

import 'package:cloud_firestore/cloud_firestore.dart';

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
    //  String _city = city;
    //  String _salonName = salonName;
     // StaffData().getSalonID(_city, _salonName);

     // if(this.salonId.length > 1) print(this.salonId);
     //                 else print("Fuck Flutter");
    //  StaffData().test();
     //  print("SalonId: " + this.salonId);
      return Firestore.instance.collection('AllSalon')
          .document(city)
          .collection('Branch')
          .document(salonId)
          .collection('Barber')
          .document(email)
          .collection('24_04_2020')
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