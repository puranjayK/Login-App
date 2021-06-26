import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/Data/DatabaseService.dart';
import 'package:login/screen/home_page.dart';



class Register extends StatefulWidget {
  const Register({ Key? key }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final Future<FirebaseApp> _initialisation = Firebase.initializeApp();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
 
  CollectionReference users = FirebaseFirestore.instance.collection('users');




  Future _createUser(String _email, String _password) async{
  try{
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _email,
      password: _password,
    );
    final User? user=FirebaseAuth.instance.currentUser;
    final userid=user!.uid;
    print(userid);
    
    await DatabaseService(uid:userid).updateUserData(_username);
    Fluttertoast.showToast(msg: "Account created successfully");
    Navigator.pop(context);
  }on FirebaseAuthException catch(e){
    if (e.code == 'weak-password') {
    Fluttertoast.showToast(msg: "Weak Passsword",backgroundColor: Colors.blueAccent);
  } else if (e.code == 'email-already-in-use') {
    Fluttertoast.showToast(msg: "Account for this Email ID already exists",backgroundColor: Colors.blueAccent);
  }else if(e.code=='invalid-email'){
    Fluttertoast.showToast(msg: "Invalid Email ID",backgroundColor: Colors.blueAccent);
  }
    print("FirebaseAuthException $e");
  }catch(e){
    print("Error $e");
  }
}

  
   String _email="",_username="";
   String _password1="",_password2="",_password="";

  final _pkey=GlobalKey<FormState>();
  final _rpkey=GlobalKey<FormState>();
  final _ekey=GlobalKey<FormState>();
  final _ukey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Create New Account",style:TextStyle(fontSize: 40,color: Colors.white,fontFamily: 'OpenSans')),
            Padding(padding: EdgeInsets.only(bottom: 80)),
            SizedBox(
              height: 60,
              width: 300,
              child: Form(
                key: _ukey,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                  onChanged: (value){
                    _username=value;
                  },
                  validator: (value){
                    if(value!.length<=0)
                      return "Please Enter Username";
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    prefixIcon: Icon(Icons.supervised_user_circle_rounded,color: Colors.white,),
                    labelText: "Enter your Username",
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: "Username",
                    hintStyle: TextStyle(color: Colors.blueGrey.shade100),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    focusColor: Colors.white10)
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom:20)),
            SizedBox(
            
              height: 60,
              width: 300,
              child: Form(
                key: _ekey,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                  onChanged: (value){
                    _email=value;
                  },
                  validator: (value){
                    if(value!.length<=0)
                      return "Please Enter Email ID";
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                  
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    prefixIcon: Icon(Icons.mail,color: Colors.white,),
                    labelText: "Enter your Email ID",
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: "Email ID",
                    hintStyle: TextStyle(color: Colors.blueGrey.shade100),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    focusColor: Colors.white10),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom:20)),
             SizedBox(
              height: 60,
              width: 300,
              child: Form(
                key: _pkey,
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (value){
                    _password1=value;
                  },
                  validator: (value){
                    if(value!.length<=0)
                      return "Please Enter Password";
                  },
                  obscureText: true,
                 decoration: InputDecoration(
                  
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    prefixIcon: Icon(Icons.lock,color: Colors.white,),
                    
                    labelText: "Enter your Password",
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.blueGrey.shade100),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    focusColor: Colors.white10),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom:20)),
            SizedBox(
              height: 60,
              width: 300,
              child: Form(
                key: _rpkey,
                  child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (value){
                    _password2=value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                  
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    prefixIcon: Icon(Icons.lock,color: Colors.white,),
                    labelText: "Re-Enter your Password",
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.blueGrey.shade100),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    focusColor: Colors.white10),
                  validator: (String? value){
                      // if(value!.length<=0)
                      if(_password1==_password2){
                        _password=_password2;
                        print("YES");
                        return null;
                      }
                      else {
                        print("NO");
                        return "Passwords do not match.";
                      }
                  },
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom:40.0)),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    // textStyle: MaterialStateProperty.all(TextStyle(z),
                    shape:MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)

                      )
                    ),),
                onPressed: (){
                  // print("$_username + $_password + $_email");
                if( _ukey.currentState!.validate()&&_ekey.currentState!.validate()&&_pkey.currentState!.validate() &&_rpkey.currentState!.validate() ){
                print("$_username + $_password + $_email");
                  _createUser(_email,_password);

                  
                }
                else
                {

                }
                
              },child: Text("Register",style: TextStyle(fontSize:20,color: Color.fromARGB(255, 180, 192, 240),fontFamily: 'OpenSans'),),),
            )
          ],
        ),
      ),
      
    );
  }
}