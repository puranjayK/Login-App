import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
final Future<FirebaseApp> _initialisation = Firebase.initializeApp();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
 
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  

  final _fkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final User? user=FirebaseAuth.instance.currentUser;
    final userid=user!.uid;
    print(userid);
    
    return FutureBuilder(
      future:users.doc(userid).get() ,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){


        
        if(snapshot.hasError){
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 180, 192, 240),
            drawer: Drawer(
              child : Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: SizedBox(
                    height: 200,
                    width: 250,
                    child: Container(
                      color: Colors.indigo.shade200,
                    ),
                  ),
                ),
                ListTile(
                title : Text("Sign out",style: TextStyle(fontSize: 20),),
                trailing: Icon(Icons.logout_rounded,size: 25,),
                onTap: (){
                  showDialog(context: context,
               builder: (BuildContext context)=>
               AlertDialog(
                 title:Text("Logout alert!!"),
                 content:Text("Do you really want to logout from the app"),
                 actions: [
                   ElevatedButton(onPressed: ()async{
                      await FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                  Fluttertoast.showToast(msg: "Signing out..."); 
                   }, child: Text("Yes")),
                   ElevatedButton(onPressed:(){
                     Navigator.pop(context);
                     
                   }, child: Text("No"))
                 ],
               )
              );
                 
                },
              )
              ]),
            ),
            appBar: AppBar(
            title: Text("Home"),
            backgroundColor: Colors.indigo.shade300,
           
          ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Oops... Some error occurred",
                style: TextStyle(color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize: 35)),
                ],
              ),
            ),
          );
        }




        if(snapshot.hasData && !snapshot.data!.exists){
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 180, 192, 240),
            drawer: Drawer(
              child : Column(
                
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: SizedBox(
                    height: 200,
                    width: 250,
                    child: Container(
                      color: Colors.indigo.shade200,
                    ),
                  ),
                ),
                ListTile(
                title : Text("Sign out",style: TextStyle(fontSize: 20),),
                trailing: Icon(Icons.logout_rounded,size: 25,),
                onTap: (){
                  showDialog(context: context,
               builder: (BuildContext context)=>
               AlertDialog(
                 title:Text("Logout alert!!"),
                 content:Text("Do you really want to logout from the app"),
                 actions: [
                   ElevatedButton(onPressed: ()async{
                      await FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                  Fluttertoast.showToast(msg: "Signing out..."); 
                   }, child: Text("Yes")),
                   ElevatedButton(onPressed:(){
                     Navigator.pop(context);
                     
                   }, child: Text("No"))
                 ],
               )
              );
                 
                },
              )
              ]),
            ),
            appBar: AppBar(
            title: Text("Home"),
            backgroundColor: Colors.indigo.shade300,
           
          ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/noData.jpg"),
                  Padding(padding: EdgeInsets.only(bottom: 20)),
                  Text("Oops... No Data Found",
                style: TextStyle(color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize: 25)),
                ],
              ),
            ),
          );
        }





        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 180, 192, 240),
          drawer: Drawer(
            child : Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: SizedBox(
                    height: 200,
                    width: 250,
                    child: Container(
                      color: Colors.indigo.shade200
                    ),
                  ),
                ),
              
              ListTile(
                title : Text("Sign out",style: TextStyle(fontSize: 20),),
                trailing: Icon(Icons.logout_rounded,size: 25,),
                onTap: (){
                  showDialog(context: context,
               builder: (BuildContext context)=>
               AlertDialog(
                 title:Text("Logout alert!!"),
                 content:Text("Do you really want to logout from the app"),
                 actions: [
                   ElevatedButton(onPressed: ()async{
                      await FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                  Fluttertoast.showToast(msg: "Signing out..."); 
                   }, child: Text("Yes")),
                   ElevatedButton(onPressed:(){
                     Navigator.pop(context);
                     
                   }, child: Text("No"))
                 ],
               )
              );
                 
                },
              )
              ],)
          ),
          appBar: AppBar(
            title: Text("Home"),
            backgroundColor: Colors.indigo.shade300,
           
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 40)),
                new Image.asset('assets/images/welcome.jpeg'),
                Text("Heyy ${data['username']}",
                style: TextStyle(color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize: 35)),
                Padding(padding: EdgeInsets.only(bottom: 25)),
                Text("Welcome Back :)",
                style: TextStyle(color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize: 35))
                
                
                
              ],
            ),
          ));
        }
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 180, 192, 240),
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              value:null,
              strokeWidth: 7.0,
            )
          ),
        );
      }
     
    );
  }
}