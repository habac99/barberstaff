import 'package:flutter/material.dart';
import 'package:barberstaff/pages/login_page.dart';
import 'package:barberstaff/services/authentication.dart';
import 'package:barberstaff/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:barberstaff/services/StaffServices.dart';
import 'package:intl/intl.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}
final dbRef = Firestore.instance;

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;
  

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _email = "";
  var data;
  var salonID;
  String currentDate;

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _email= user?.email;
        }
        authStatus =
            user?.email == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
       StaffServices().getStaffInfor(_email)
              .then((QuerySnapshot docs){
                // print(_email);
                // if(docs.documents.isEmpty) print("empty");
                // else print('not empty');
                
                 setState(() {
                  _email = user.email.toString();
                //  data = docs.documents[0].data;
              
           
          });
              });
    
    });
     
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _email = "";
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginPage(
          auth: widget.auth,
          loginCallback: loginCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_email.length > 0 && _email != null) {
           var now = new  DateTime.now();
      
      String dateFormated = DateFormat('dd_MM_yyyy').format(now);
      print(dateFormated);
      setState(() {
        this.currentDate = dateFormated;
        
      });
          StaffServices().getStaffInfor(_email)
              .then((QuerySnapshot docs){
                // print(_email);
                // if(docs.documents.isEmpty) print("empty");
                // else print('not empty');
                setState(() {
                  this.data = docs.documents[0].data;
                });
          StaffServices().getSalonID(this.data['City'], this.data['salonName'])
              .then((QuerySnapshot result){
                setState(() {
                  this.salonID = result.documents[0].documentID;

                  
                });
              });
               
                   
                  //  print(this.data['City']);
               
               
                // print(data['salonName']);


          });
         
          return new HomePage(
            email: _email,
            auth: widget.auth,
            logoutCallback: logoutCallback,
            data : data,
            salonID: salonID,
            currentDate: currentDate,

          );
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}
