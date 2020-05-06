import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);
  Future<FirebaseUser> getCurrentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.email;
  }
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }
  Future<List> getStaffData() async{

  }
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }


}
