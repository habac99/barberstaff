import 'dart:ui';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barberstaff/services/authentication.dart';
import 'package:barberstaff/services/StaffServices.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth,this.logoutCallback, this.email, this.data, this.currentDate,this.salonID})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String email;
  final  data;
  final String currentDate;
  
  final String salonID;
  
  // final String userId;
  // final getData mygetData;
  
 @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var now = new  DateTime.now();
  String currentDate= DateFormat('dd_MM_yyyy').format(DateTime.now());
  DateTime displaydate = DateTime.now() ;
  var test;
 
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  @override
 void initState() {
   
 
   super.initState();
}
@override
  void dispose() {

    super.dispose();
  }
  signOut() async {
    try {
      await widget.auth.signOut();
      // _Shedule.clear();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }
  setDate( DateTime date){
    setState(() {
      this.currentDate = DateFormat('dd_MM_yyyy').format(date);
      this.displaydate = date;
       
      
    });
  }
  
  @override
  Widget build(BuildContext context) {
   
    return new MaterialApp(
      home: Scaffold(

      appBar: AppBar(
        title: Text(DateFormat('dd/MM/yyyy').format(this.displaydate)),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.calendar_today,
              color: Colors.white,
            ),
            onPressed: () => {
              DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime.now().subtract(new Duration(days: 2)),
                              maxTime: DateTime.now().add(new Duration(days: 2)), 
                              onChanged: (date) {
                                print('change $date');
                             },
                              onConfirm: (date) {
                                setDate(date);
                                
                             },
                         currentTime: DateTime.now())
            },
          ),
           IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () => {},
          )
          ]
      ),
      body:  
        
        StreamBuilder<QuerySnapshot>(
          stream:  Firestore.instance.collection('AllSalon')
                                     .document(widget.data['City'])
                                     .collection('Branch')
                                     .document(widget.salonID)
                                     .collection('Barber')
                                     .document(widget.email)
                                     .collection(this.currentDate)
                                     .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            final numofbooking = snapshot.data.documents.length;
            final List<String> schedule = [];
            for(int i = 0; i<numofbooking;i++){
              schedule.add(snapshot.data.documents[i].documentID.toString());
            }
            return 
                Container(
                  // decoration: new BoxDecoration(
                  //   shape: BoxShape.rectangle,
                  //   image: new DecorationImage(
                  //     image: ExactAssetImage('assets/images/img.jpg'),
                  //     fit: BoxFit.co,
                      
                      
                  //     ),
                  // ),
        
        child: GridView.builder(
          itemCount: 20,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0,childAspectRatio:2.0),
          // ignore: missing_return
          itemBuilder: (BuildContext context, int index){
           String status;
           
            switch (index){
            case 0:
            bool istimeout = StaffServices().IsTimeout(9, 30, this.displaydate);

            if(schedule.contains('0')){
            if(istimeout) status = "Complete";
            else status = "Booked";
             return   FlatButton(
                      child: Text('9h00-9h30 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color:istimeout? Colors.green[900]:Colors.deepPurple[900],
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, this.currentDate, 0, widget.salonID),
          );
          }
          else {
             if(istimeout) status = "Time out";
              else status = "Available";
             return   FlatButton(
                      child: Text('9h00-9h30  $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      
                      color: istimeout? Colors.grey:Colors.blueAccent, 
                      
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => {},
          );
          }
          break;
          case 1:
          bool istimeout = StaffServices().IsTimeout(10, 0,this.displaydate);
          if(schedule.contains('1')){
            if(istimeout) status = "Completed";
            else status = "Booked";
             return   FlatButton(
                      child: Text('9h30h-10h00 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color:istimeout? Colors.green[900]:Colors.deepPurple[900],
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)), 
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, this.currentDate, 1, widget.salonID),
          );
          }
          else {
             if(istimeout) status = "Time out";
              else status = "Available";
            return   FlatButton(
                      child: Text('9h30h-10h00 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: istimeout? Colors.grey:Colors.blueAccent,  
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => {},
          );
          }
          break;          
          case 2:
          bool istimeout = StaffServices().IsTimeout(10, 30,this.displaydate);
          if(schedule.contains('2')){
            if(istimeout) status = "Completed";
            else status = "Booked";
             return   FlatButton(
                      child: Text('10h00-10h30 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color:istimeout? Colors.green[900]:Colors.deepPurple[900],
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, this.currentDate, 2, widget.salonID),
          );
          }
          else{
             if(istimeout) status = "Time out";
              else status = "Available";
             return   FlatButton(
                      child: Text('10h00-10h30 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: istimeout? Colors.grey:Colors.blueAccent,  
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => {},
          );

          }
            
          break;


          case 3:
          bool istimeout = StaffServices().IsTimeout(11, 0,this.displaydate);
          if(schedule.contains('3')){
            if(istimeout) status = "Completed";
            else status = "Booked";
             return   FlatButton(
                      child: Text('10h30-11h00 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color:istimeout? Colors.green[900]:Colors.deepPurple[900],
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)), 
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, this.currentDate, 3, widget.salonID),
          );
          }

          else{
             if(istimeout) status = "Time out";
              else status = "Available";
             return   FlatButton(
                      child: Text('10h00-10h30 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: istimeout? Colors.grey:Colors.blueAccent,  
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => {},
          );
             
          }
          break;
          case 4:
          bool istimeout = StaffServices().IsTimeout(11, 30,this.displaydate);
          if(schedule.contains('4')){
            if(istimeout) status = "Completed";
            else status = "Booked";
              return   FlatButton(
                      child: Text('11h00-11h30 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color:istimeout? Colors.green[900]:Colors.deepPurple[900],
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, this.currentDate, 4, widget.salonID),
          );
          }
          else{
              if(istimeout) status = "Time out";
              else status = "Available";
             return   FlatButton(
                      child: Text('11h00-11h30 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: istimeout? Colors.grey:Colors.blueAccent,  
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => {},
          );
          }
          break;
          case 5:
          bool istimeout = StaffServices().IsTimeout(12, 00,this.displaydate);
            if(schedule.contains('5')){
              if(istimeout) status = "Completed";
            else status = "Booked";
              return   FlatButton(
                      child: Text('11h30-12h00 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color:istimeout? Colors.green[900]:Colors.deepPurple[900],
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)), 
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, this.currentDate, 5, widget.salonID),
          );
            }

            else{

             if(istimeout) status = "Time out";
              else status = "Available";
              return   FlatButton(
                      child: Text('11h30-12h00 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: istimeout? Colors.grey:Colors.blueAccent, 
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)), 
                      onPressed: () => {},
          );
          }
          break;
          case 6:
          bool istimeout = StaffServices().IsTimeout(12, 30,this.displaydate);
            if(schedule.contains('6')){
              if(istimeout) status = "Completed";
            else status = "Booked";
              return   FlatButton(
                      child: Text('12h00-12h30 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                       color:istimeout? Colors.green[900]:Colors.deepPurple[900],
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, this.currentDate, 7, widget.salonID),
          );
            }
            else{
               if(istimeout) status = "Time out";
              else status = "Available";
              return   FlatButton(
                      child: Text('12h00-12h30 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: istimeout? Colors.grey:Colors.blueAccent,  
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => {},
          );
            }
          break;
          case 7:
          bool istimeout = StaffServices().IsTimeout(13, 00,this.displaydate);
            if(schedule.contains('7')){
              if(istimeout) status = "Completed";
            else status = "Booked";
              return   FlatButton(
                      child: Text('12h30-13h00 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                       color:istimeout? Colors.green[900]:Colors.deepPurple[900],
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, this.currentDate, 7, widget.salonID),
          );
            }
            else{
               if(istimeout) status = "Time out";
              else status = "Available";
              return   FlatButton(
                      child: Text('12h30-13h00 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: istimeout? Colors.grey:Colors.blueAccent,  
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => {},
          );
          }
          break;
          case 8:
           bool istimeout = StaffServices().IsTimeout(13, 30,this.displaydate);
            if(schedule.contains('8')){
              if(istimeout) status = "Completed";
            else status = "Booked";
              return   FlatButton(
                      child: Text('13h00-13h30 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                       color:istimeout? Colors.green[900]:Colors.deepPurple[900],
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, this.currentDate, 8, widget.salonID),
          );
            }
            else{
               if(istimeout) status = "Time out";
              else status = "Available";
              return   FlatButton(
                      child: Text('13h00-13h30 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: istimeout? Colors.grey:Colors.blueAccent,  
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => {},
          );
            }
          break;
          case 9:
           bool istimeout = StaffServices().IsTimeout(14, 00,this.displaydate);
            if(schedule.contains('9')){
              if(istimeout) status = "Completed";
            else status = "Booked";
              return   FlatButton(
                      child: Text('13h30-14h00 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                       color:istimeout? Colors.green[900]:Colors.deepPurple[900], 
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, this.currentDate, 9, widget.salonID),
          );
            }
            else{
               if(istimeout) status = "Time out";
              else status = "Available";
              return   FlatButton(
                      child: Text('13h30-14h00 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: istimeout? Colors.grey:Colors.blueAccent,  
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => {},
          );
            }
          break;
          case 10:
           bool istimeout = StaffServices().IsTimeout(14, 30,this.displaydate);
            if(schedule.contains('10')){
              if(istimeout) status = "Completed";
            else status = "Booked";
              return   FlatButton(
                      child: Text('14h00-14h30 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                       color:istimeout? Colors.green[900]:Colors.deepPurple[900],
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, this.currentDate, 10, widget.salonID),
          );
          }
            else{
               if(istimeout) status = "Time out";
              else status = "Available";
              return   FlatButton(
                      child: Text('14h00-14h30 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: istimeout? Colors.grey:Colors.blueAccent,  
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => {},
          );
            }
          break;
          case 11:
           bool istimeout = StaffServices().IsTimeout(15, 00,this.displaydate);
            if(schedule.contains('11')){
              if(istimeout) status = "Completed";
            else status = "Booked";
              return   FlatButton(
                      child: Text('14h30-15h00 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                       color:istimeout? Colors.green[900]:Colors.deepPurple[900],
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, this.currentDate, 11, widget.salonID),
          );
            }
            else{
               if(istimeout) status = "Time out";
              else status = "Available";
              return   FlatButton(
                      child: Text('14h30-15h00 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: istimeout? Colors.grey:Colors.blueAccent,  
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => {},
          );
          }
          break;
          case 12:
          bool istimeout = StaffServices().IsTimeout(15, 30,this.displaydate);
            if(schedule.contains('12')){
              if(istimeout) status = "Completed";
            else status = "Booked";
              return   FlatButton(
                      child: Text('15h00-15h30 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                       color:istimeout? Colors.green[900]:Colors.deepPurple[900],
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, this.currentDate, 12, widget.salonID),
          );
            }
            else{
               if(istimeout) status = "Time out";
              else status = "Available";
              return   FlatButton(
                      child: Text('15h00-15h30 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: istimeout? Colors.grey:Colors.blueAccent,  
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => {},
          );
          }
          break;
          case 13:
           bool istimeout = StaffServices().IsTimeout(16, 0,this.displaydate);
            if(schedule.contains('13')){
              if(istimeout) status = "Completed";
            else status = "Booked";
              return   FlatButton(
                      child: Text('15h30-16h00 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                       color:istimeout? Colors.green[900]:Colors.deepPurple[900],
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, this.currentDate, 13, widget.salonID),
          );
            }
            else{
               if(istimeout) status = "Time out";
              else status = "Available";
              return   FlatButton(
                      child: Text('15h30-16h00 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: istimeout? Colors.grey:Colors.blueAccent,  
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => {},
          );
            }
          break;
          case 14:
           bool istimeout = StaffServices().IsTimeout(16, 30,this.displaydate);
            if(schedule.contains('14')){
              if(istimeout) status = "Completed";
            else status = "Booked";
              return   FlatButton(
                      child: Text('16h00-16h30 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                       color:istimeout? Colors.green[900]:Colors.deepPurple[900],
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, this.currentDate, 14, widget.salonID),
          );
            }
            else{
               if(istimeout) status = "Time out";
              else status = "Available";
              return   FlatButton(
                      child: Text('16h00-16h30 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: istimeout? Colors.grey:Colors.blueAccent,  
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => {},
          );
            }
          break;
          case 15:
           bool istimeout = StaffServices().IsTimeout(17, 0,this.displaydate);
            if(schedule.contains('15')){
              if(istimeout) status = "Completed";
            else status = "Booked";
              return   FlatButton(
                      child: Text('16h30-17h00 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                       color:istimeout? Colors.green[900]:Colors.deepPurple[900],
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, this.currentDate, 15, widget.salonID),
          );
            }
            else{
               if(istimeout) status = "Time out";
              else status = "Available";
              return   FlatButton(
                      child: Text('16h30-17h00 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: istimeout? Colors.grey:Colors.blueAccent,  
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => {},
          );
            }
          break;
          case 16:
           bool istimeout = StaffServices().IsTimeout(17, 30,this.displaydate);
            if(schedule.contains('16')){
              if(istimeout) status = "Completed";
            else status = "Booked";
              return   FlatButton(
                      child: Text('17h00-17h30 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                       color:istimeout? Colors.green[900]:Colors.deepPurple[900],
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, this.currentDate, 16, widget.salonID),
          );
            }
            else{
               if(istimeout) status = "Time out";
              else status = "Available";
              return   FlatButton(
                      child: Text('17h00-17h30 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: istimeout? Colors.grey:Colors.blueAccent,  
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => {},
          );
            }
          break;
         case 17:
          bool istimeout = StaffServices().IsTimeout(18, 0,this.displaydate);
            if(schedule.contains('17')){
              if(istimeout) status = "Completed";
            else status = "Booked";
              return   FlatButton(
                      child: Text('17h30-18h00 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                       color:istimeout? Colors.green[900]:Colors.deepPurple[900],
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, this.currentDate, 17, widget.salonID),
          );
            }
            else{
               if(istimeout) status = "Time out";
              else status = "Available";
              return   FlatButton(
                      child: Text('17h30-18h00 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: istimeout? Colors.grey:Colors.blueAccent,  
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => {},
          );
          }
          break;
          case 18:
           bool istimeout = StaffServices().IsTimeout(18, 30,this.displaydate);
            if(schedule.contains('18')){
              if(istimeout) status = "Completed";
            else status = "Booked";
              return   FlatButton(
                      child: Text('18h00-18h30 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                       color:istimeout? Colors.green[900]:Colors.deepPurple[900],
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, this.currentDate, 18, widget.salonID),
          );
            }
            else{
               if(istimeout) status = "Time out";
              else status = "Available";
              return   FlatButton(
                      child: Text('18h00-18h30 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: istimeout? Colors.grey:Colors.blueAccent,  
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => {},
          );
          }
          break;
          case 19:
           bool istimeout = StaffServices().IsTimeout(19, 0,this.displaydate);
            if(schedule.contains('19')){
              if(istimeout) status = "Completed";
            else status = "Booked";
              return   FlatButton(
                      child: Text('18h30-19h00 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                       color:istimeout? Colors.green[900]:Colors.deepPurple[900],
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, this.currentDate, 19, widget.salonID),
          );
            }
            else{
               if(istimeout) status = "Time out";
              else status = "Available";
              return   FlatButton(
                      child: Text('18h30-19h00 $status',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: istimeout? Colors.grey:Colors.blueAccent,  
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () => {},
          );
          }
          break;
                  
          }
     
        }
  
        )
        
      );
      }
),
            drawer: new Drawer(
                  child: ListView(
                    children: <Widget>[
                      DrawerHeader(
                        child:  Text("  "),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                            image: DecorationImage(
                                image: AssetImage('assets/images/1.png'),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                     
                      ListTile(
                        title:  Text(widget.email),
                        onTap: () => {},
                      ),
                      ListTile(
                        title:  Text(widget.data['City']),
                        onTap: () => {},
                      ),
                      ListTile(
                        title:  Text(widget.data['salonName']),
                        onTap: () => {},
                      ),
                      ListTile(
                        title: Text('Logout'),
                        onTap: signOut
                      )
                    ],
                  )
                ),
            
     
      
      
              )
    )
              ;
         }
      
      
 
}
