import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barberstaff/services/authentication.dart';
import 'package:barberstaff/models/getBookingdata.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:barberstaff/models/User.dart';

import 'package:barberstaff/models/todo.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth,this.logoutCallback, this.email })
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String email;
  
  // final String userId;
  // final getData mygetData;
  
 @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {


  // final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _email ;
  User user = new User();
  List<int> _Shedule = [1,3,5,7];

    // Future  getEmail() async{
    //   final FirebaseUser user = await _firebaseAuth.currentUser();
    //   final email = user.email;
    //   this._email = email.toString();
    //   print (email);

    // }

    String getEmail(){
        test();
        return this._email ; 

      
        
    }
    void  test() async {
      FirebaseUser user =  await _firebaseAuth.currentUser();
      this._email = user.email.toString();
      
      
      
    }
   
      

   

  


 @override
 void initState() {
   
   super.initState();
   _email = getEmail();
   
}



  @override
  void dispose() {

    super.dispose();
  }
  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    // String email = getEmail();
    // test();
    return new Scaffold(

      appBar: AppBar(title: Text("Staff")),
      body:  Container(
        // height: 81,
        
        child: GridView.builder(
          itemCount: 20,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0,childAspectRatio:1.0),
          itemBuilder: (BuildContext context, int index){
            var test = [1,2,3];
            switch (index){
            case 0:
             return   FlatButton(
                      child: Text('9h00-9h30 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          case 1:
          if(_Shedule.contains(1))
             return   FlatButton(
                      child: Text('9h30h-10h00 booked',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.black, 
                      onPressed: () => {},
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
             return   FlatButton(
                      child: Text('10h00-10h30 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          case 3:
             return   FlatButton(
                      child: Text('10h30-11h00 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          case 4:
             return   FlatButton(
                      child: Text('11h00-11h30 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          case 5:
             return   FlatButton(
                      child: Text('11h30-12h00 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          case 6:
             return   FlatButton(
                      child: Text('12h00-12h30 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          case 7:
             return   FlatButton(
                      child: Text('12h30-13h00 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          case 8:
             return   FlatButton(
                      child: Text('13h00-13h30 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          case 9:
             return   FlatButton(
                      child: Text('13h30-14h00 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          case 10:
             return   FlatButton(
                      child: Text('14h00-14h30 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          case 11:
             return   FlatButton(
                      child: Text('14h30-15h00 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          case 12:
             return   FlatButton(
                      child: Text('15h00-15h30 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          case 13:
             return   FlatButton(
                      child: Text('15h30-16h00 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          case 14:
             return   FlatButton(
                      child: Text('16h00-16h30 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          case 15:
             return   FlatButton(
                      child: Text('16h30-17h00 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          case 16:
             return   FlatButton(
                      child: Text('17h00-17h30 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          case 17:
             return   FlatButton(
                      child: Text('17h30-18h00 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          case 18:
             return   FlatButton(
                      child: Text('18h-18h30 available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          case 19:
             return   FlatButton(
                      child: Text('18h30-19h available',textAlign: TextAlign.center, style: new TextStyle(  color: Colors.white) 
                              ),
                      color: Colors.blueAccent, 
                      onPressed: () => {},
          );
          }
         
          
          
          }
          
          
          
       
         

        
        
        )
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
                        title: Text('Logout'),
                        onTap: signOut
                      ),
                      ListTile(
                        title:  Text(widget.email),
                        onTap: () => {},
                      )
                    ],
                  )
                ),
            
     
      
      
              );
         }
      
      
 
}
