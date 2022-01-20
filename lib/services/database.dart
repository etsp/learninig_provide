import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learninig_provide/models/books_model.dart';

class Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<UserModel>?>  userList() =>
      firestore.collection('user').snapshots().map((snap) => snap.docs.map((e) => UserModel.fromJson(e.data())).toList());

  addUser(){
    var addUserData = Map<String,dynamic>();
    addUserData['name'] = "Andrew Holder";
    addUserData['age'] = "31yrs";
    return firestore.collection('user').add(addUserData);
  }
}
