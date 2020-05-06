import 'package:cloud_firestore/cloud_firestore.dart';

class StaffData{
  getStaffInfor(String email){

    return Firestore.instance
      .collection('Staff')
      .where('Email', isEqualTo : email)
      .getDocuments();
  }
}