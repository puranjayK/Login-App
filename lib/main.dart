

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase, FirebaseApp;
import 'package:login/screen/home_page.dart';
import 'package:login/screen/login_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Color.fromARGB(255, 180, 192, 240),
      ),
      debugShowCheckedModeBanner: false,
      home:LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialisation = Firebase.initializeApp();
 
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialisation,
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Scaffold(
              body:Center(
                  child: Text("Error : ${snapshot.error}")
              ) ,
            );
          }

          if(snapshot.connectionState==ConnectionState.done){
            print("Home");
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(), 
              builder: (context,snapshot) {
                if(snapshot.connectionState==ConnectionState.active){
                  Object? user = snapshot.data;

                  if(user==null){
                    return LoginPage();
                  }else{
                    return HomePage();
                  }

                }
                return Scaffold(
                  body: Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        value: null,
                        strokeWidth:7.0,
                      ),
                    ),
                  ), 
                );
                },
            );
          }

          return Scaffold(
            body: Center(
              child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        value: null,
                        strokeWidth:7.0,
                      ),
                    ),
            ),
          );
        },
    );
  }
}

