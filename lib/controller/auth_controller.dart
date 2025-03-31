import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> registerNewUser(
      String email, String password, String fullNames) async {
    String res = "Something went wrong";

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection("Buyers").doc(userCredential.user!.uid).set({
        "Fullnames": fullNames,
        "email": email,
        "profileImage": "",
        "uid": userCredential.user!.uid,
        "Pincode": "",
        "locality": "",
        "city": "",
        "state": ""
      });

      res = "Success";
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        res = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        res = 'The account already exists for that email.';
      }
    } catch (e) {
      "Error $e";
    }

    return res;
  }

  //Login User

  Future<String> loginUser(String email, String password) async {
    String res = "Something went wrong";

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      res = "Success";
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        res = 'Wrong password provided for that user.';
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
