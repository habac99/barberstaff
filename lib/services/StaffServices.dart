



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
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(20.0)),
                                child: Container(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Booking infomation: \n",  style: new TextStyle(  fontSize: 18,
                                                                                         fontWeight: FontWeight.bold,)),
                                        Text("Customer's name: " + customerData['customerName'].toString() + "\n"),
                                        Text("Customer's number:  " + customerData['customerPhone'].toString()+'\n'),
                                        Text("Time: " + customerData['time']),
                                        SizedBox(
                                          width: 320.0,
                                          child: RaisedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "Close",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            color: const Color(0xFF1BC0C5),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });


                        });
 
 }
 bool IsTimeout(int hour, int minute, DateTime date){
  
   
   DateTime now = DateTime.now();
   int currentHour = now.hour.toInt();
   int currentMinute = now.minute.toInt();
   if(date.year < now.year) return true;
   else if (date.year == now.year){
          if(date.month < now.month) return true;
          else if(date.month==now.month){
            if(date.day < now.day) return true;
            else if(date.day == now.day){
              if(hour < currentHour)
                 return true;
              else if(hour == currentHour){
                if(minute > currentMinute)
                    return false;
              else return true;
              }
                else return false;
           }
          else return false;
              
            
          }
          else return false;

   }
   else return false;
   

 }
}