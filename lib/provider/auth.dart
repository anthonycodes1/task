import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:otp_text_field/otp_text_field.dart';
class User extends ChangeNotifier{
  User({required this.uid,required this.photoUrl,required this.displayName});
  final String uid;
  final String displayName;
  final String photoUrl;
}

abstract class AuthBase {
  Stream<User> get onAuthChanged;
  Future<User> createUserWithEmailAndPassword(String email,String password);
  Future<User> signInWithEmailAndPassword(String email,String password);
  Future<User> currentUser();
  Future<String> updateUser(String name);

  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase( user) {
    if (user == null) {
      return User(uid: '', displayName: '', photoUrl: '');
    }
    return User(uid: user.uid,photoUrl: user.photoUrl,displayName: user.displayName);
  }

  @override
  Stream<User> get onAuthChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }
  @override
  Future<String> updateUser(String name) async {
    final user = _firebaseAuth.currentUser;
    await user!.updateProfile(displayName: name);
    return user.uid;
  }
  @override
  Future<User> currentUser() async {
    final user = _firebaseAuth.currentUser;
    return _userFromFirebase(user as User);
  }

  @override
  Future<User> createUserWithEmailAndPassword(String email,String password) async{
    final authResult=await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user as User);
  }
  @override
  Future<User> signInWithEmailAndPassword(String email,String password) async{
    final authResult=await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user as User);
  }

//Facebook


  //________________Phone_______________________//


  @override
  Future<void> signOut() async {
    final gsignin= GoogleSignIn();
    await gsignin.signOut();

    await _firebaseAuth.signOut();
  }

  @override
  Future<User> signInGoogle() {
    // TODO: implement signInGoogle
    throw UnimplementedError();
  }

}