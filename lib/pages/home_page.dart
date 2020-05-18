import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barberstaff/services/authentication.dart';
import 'package:barberstaff/services/StaffServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  var test;
 
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  @override
 void initState() {
   
  //  StaffData().getStaffInfor(widget.email)
  //             .then((QuerySnapshot docs){
  //               // print(_email);
  //               // if(docs.documents.isEmpty) print("empty");
  //               // else print('not empty');
  //               // data = docs.documents[0].data;
    
 
  //  });
  print(widget.currentDate);
  //  StaffData().getShedule(widget.email, widget.data['City'], widget.data['Salon'])
  //             .then((QuerySnapshot docs){
  //               var data;
  //               print(widget.data['City']);
  //               if(docs.documents.isEmpty) print('empty');
  //               else {
  //                for(int i = 0; i < docs.documents.length; i++){
  //                  data = docs.documents[i].documentID;
  //                  _Shedule.add(data.toString());
  //                }
               
  //               }

  //  });
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

  
  @override
  Widget build(BuildContext context) {
   
    return new Scaffold(

      appBar: AppBar(title: Text("Staff")),
      body:  
        StreamBuilder<QuerySnapshot>(
          stream:  Firestore.instance.collection('AllSalon')
                                     .document(widget.data['City'])
                                     .collection('Branch')
                                     .document(widget.salonID)
                                     .collection('Barber')
                                     .document(widget.email)
                                     .collection(widget.currentDate)
                                     .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            final numofbooking = snapshot.data.documents.length;
            final List<String> schedule = [];
            for(int i = 0; i<numofbooking;i++){
              schedule.add(snapshot.data.documents[i].documentID.toString());
            }
            return 
                Container(
        // height: 81,
        
        child: GridView.builder(
          itemCount: 20,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0,childAspectRatio:1.0),
          // ignore: missing_return
          itemBuilder: (BuildContext context, int index){
           
            switch (index){
            case 0:
            if(schedule.contains('0'))
             return   FlatButton(
                      child: Text('9h00-9h30 booked',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.black, 
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, widget.currentDate, 0, widget.salonID),
          );
          else 
             return   FlatButton(
                      child: Text('9h00-9h30 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          break;
          case 1:
          if(schedule.contains('1'))
             return   FlatButton(
                      child: Text('9h30h-10h00 booked',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.black, 
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, widget.currentDate, 1, widget.salonID),
          );
          else 
            return   FlatButton(
                      child: Text('9h30h-10h00 avaiable',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          break;          
          case 2:
          if(schedule.contains('2'))
             return   FlatButton(
                      child: Text('10h00-10h30 booked',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.black, 
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, widget.currentDate, 2, widget.salonID),
          );
          else 
             return   FlatButton(
                      child: Text('10h00-10h30 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          break;


          case 3:
          if(schedule.contains('3'))
             return   FlatButton(
                      child: Text('10h30-11h00 booked',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.black, 
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, widget.currentDate, 3, widget.salonID),
          );

          else
             return   FlatButton(
                      child: Text('10h30-11h00 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          break;
          case 4:
          if(schedule.contains('4'))
              return   FlatButton(
                      child: Text('11h00-11h30 booked',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.black, 
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, widget.currentDate, 4, widget.salonID),
          );
          else
             return   FlatButton(
                      child: Text('11h00-11h30 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          break;
          case 5:
            if(schedule.contains('5'))
              return   FlatButton(
                      child: Text('11h30-12h00 booked',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.black, 
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, widget.currentDate, 5, widget.salonID),
          );

            else
              return   FlatButton(
                      child: Text('11h30-12h00 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          break;
          case 6:
            if(schedule.contains('6'))
              return   FlatButton(
                      child: Text('12h00-12h30 booked',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.black, 
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, widget.currentDate, 7, widget.salonID),
          );
            else
              return   FlatButton(
                      child: Text('12h00-12h30 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          break;
          case 7:
            if(schedule.contains('7'))
              return   FlatButton(
                      child: Text('12h30-13h00 booked',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.black, 
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, widget.currentDate, 7, widget.salonID),
          );
            else
              return   FlatButton(
                      child: Text('12h30-13h00 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          break;
          case 8:
            if(schedule.contains('8'))
              return   FlatButton(
                      child: Text('13h00-13h30 booked',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.black, 
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, widget.currentDate, 8, widget.salonID),
          );
            else
              return   FlatButton(
                      child: Text('13h00-13h30 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          break;
          case 9:
            if(schedule.contains('9'))
              return   FlatButton(
                      child: Text('13h30-14h00 booked',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.black, 
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, widget.currentDate, 9, widget.salonID),
          );
            else
              return   FlatButton(
                      child: Text('13h30-14h00 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          break;
          case 10:
            if(schedule.contains('10'))
              return   FlatButton(
                      child: Text('14h00-14h30 booked',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.black, 
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, widget.currentDate, 10, widget.salonID),
          );
            else
              return   FlatButton(
                      child: Text('14h00-14h30 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          break;
          case 11:
            if(schedule.contains('11'))
              return   FlatButton(
                      child: Text('14h30-15h00 booked',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.black, 
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, widget.currentDate, 11, widget.salonID),
          );
            else
              return   FlatButton(
                      child: Text('14h30-15h00 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          break;
          case 12:
            if(schedule.contains('12'))
              return   FlatButton(
                      child: Text('15h00-15h30 booked',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.black, 
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, widget.currentDate, 12, widget.salonID),
          );
            else
              return   FlatButton(
                      child: Text('15h00-15h30 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          break;
          case 13:
            if(schedule.contains('13'))
              return   FlatButton(
                      child: Text('15h30-16h00 booked',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.black, 
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, widget.currentDate, 13, widget.salonID),
          );
            else
              return   FlatButton(
                      child: Text('15h30-16h00 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          break;
          case 14:
            if(schedule.contains('14'))
              return   FlatButton(
                      child: Text('16h00-16h30 booked',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.black, 
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, widget.currentDate, 14, widget.salonID),
          );
            else
              return   FlatButton(
                      child: Text('16h00-16h30 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          break;
          case 15:
            if(schedule.contains('15'))
              return   FlatButton(
                      child: Text('16h30-17h00 booked',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.black, 
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, widget.currentDate, 15, widget.salonID),
          );
            else
              return   FlatButton(
                      child: Text('16h30-17h00available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          break;
          case 16:
            if(schedule.contains('16'))
              return   FlatButton(
                      child: Text('17h00-17h30 booked',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.black, 
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, widget.currentDate, 16, widget.salonID),
          );
            else
              return   FlatButton(
                      child: Text('17h00-17h30 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          break;
         case 17:
            if(schedule.contains('17'))
              return   FlatButton(
                      child: Text('17h30-18h00 booked',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.black, 
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, widget.currentDate, 17, widget.salonID),
          );
            else
              return   FlatButton(
                      child: Text('17h30-18h00 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          break;
          case 18:
            if(schedule.contains('18'))
              return   FlatButton(
                      child: Text('18h-18h30 booked',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.black, 
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, widget.currentDate, 18, widget.salonID),
          );
            else
              return   FlatButton(
                      child: Text('18h-18h30 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          break;
          case 19:
            if(schedule.contains('19'))
              return   FlatButton(
                      child: Text('18h30-19h booked',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.black, 
                      onPressed: () => StaffServices().showCustomerData(context,widget.data['City'],widget.email, widget.currentDate, 19, widget.salonID),
          );
            else
              return   FlatButton(
                      child: Text('18h30-19h available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
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
                      // ListTile(
                      //   title:  Text(test.toString()),
                      //   onTap: () => {},
                      // ),
                       ListTile(
                        title: Text('Logout'),
                        onTap: signOut
                      )
                    ],
                  )
                ),
            
     
      
      
              )
              ;
         }
      
      
 
}
