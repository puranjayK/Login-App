import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
class DatabaseService{
  final uid;
  DatabaseService({this.uid});

  // final Future<FirebaseApp> _initialisation = Firebase.initializeApp();
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference userCollection= FirebaseFirestore.instance.collection("users");
  Future updateUserData(String _username) async{
    return await userCollection.doc(uid).set({
      'username':_username
    });
  }


  Stream<QuerySnapshot> get users{
    return userCollection.snapshots();
  }
}