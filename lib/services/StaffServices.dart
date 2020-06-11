



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class StaffServices{
  
  getStaffInfor(String email){

    return Firestore.instance
      .collection('Staff')
      .where('Email', isEqualTo : email)
      .getDocuments();
  }
  getSalonID(String city, String salonName){
   return Firestore.instance.collection('AllSalon')
                   .document(city)
                   .collection('Branch')
                   .where('name', isEqualTo: salonName)
                   .getDocuments();
  }

 getShedule(String email, String city, String salonId) {
      var now = new  DateTime.now();
      String dateFormated = DateFormat('dd_MM_yyyy').format(now);
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
showCustomerData(BuildContext context, String city, String email, String date, int slot,String salonID) {
  //  showDialog(
  //    context: context,
  //    builder: (BuildContext context){
       
      Firestore.instance.collection('AllSalon')
                        .document(city)
                        .collection('Branch')
                        .document(salonID)
                        .collection('Barber')
                        .document(email)
                        .collection(date)
                        .where('slot', isEqualTo: slot)
                        .getDocuments()
                        .then((QuerySnapshot data){
                          var customerData = data.documents[0].data;
                          showDialog(
                          context: context,
                          builder: (BuildContext context){
                             return AlertDialog(
                              title: new Text("Customer infor"),
                              content: new ListView(
                                children: <Widget>[
                                  ListTile(
                                  title:  Text("Customer's name: \n" + customerData['customerName'].toString()),
                                    onTap: () =>{},
                                  ),
                                  ListTile(
                                  title:  Text("Customer's number:  "+'\n' + customerData['customerPhone'].toString()),
                                    onTap: () =>{},
                                  ),
                                  ListTile(
                                  title:  Text("Time: \n" + customerData['time']),
                                  
                                  onTap: () =>{},
                                  ),

                                ],

                              ),
                              actions: <Widget>[
                               
                                new FlatButton(
                                  child: new Text("Close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );

                          }
                          );


                        });
                                     
        
      
      //  return AlertDialog(
      //     title: new Text("Customer infor"),
      //     content: new Text("Alert Dialog body"),
      //     actions: <Widget>[
      //       // usually buttons at the bottom of the dialog
      //       new FlatButton(
      //         child: new Text("Close"),
      //         onPressed: () {
      //           Navigator.of(context).pop();
      //         },
      //       ),
      //     ],
      //   );

       

    //  }
    //  );
 }
}