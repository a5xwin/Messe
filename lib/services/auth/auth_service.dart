import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {

  
  //create instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser(){   //fetches the current logged in user
    return _auth.currentUser;
  }


  //login
  Future<UserCredential> signInWithEmailPassword(String email,password) async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      //save user info if it doesnt already exist
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid':userCredential.user!.uid,
          'email':email
        },
      );



      return userCredential;
    }

    on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }

  //sign up
  Future<UserCredential> signUpWithEmailPassword(String email,password) async{
    try{
      //create user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);  



      //save user info in a seperate doc
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid':userCredential.user!.uid,
          'email':email
        },
      );




      return userCredential;
    }

    on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }


  //sign out
  Future<void> signOut() async{
    return await _auth.signOut();
  }


  //errors

}