import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersList extends StatefulWidget {
  const UsersList({ Key? key }) : super(key: key);

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    final users=  Provider.of<QuerySnapshot>(context);
    for (var name in users.docs){
      print(name.data());
    }
    return Container(
      
    );
  }
}