// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login/screen/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


String _email="",_password="";

Future <void> _checkUser(String _email,String _password)async{
  try {
  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: _email,
    password: _password,
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    Fluttertoast.showToast(msg: "No user found for that email.");
  } else if (e.code == 'wrong-password') {
    Fluttertoast.showToast(msg: "Wrong password provided for that user.");
  }
}


}




  

  final _fkey=GlobalKey<FormState>(),_pkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      // appBar: AppBar(
      //   title: Text("Home"),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Sign In",style:TextStyle(fontSize: 40,color: Colors.white,fontFamily: 'OpenSans')),
            Padding(padding: EdgeInsets.only(bottom: 80)),

            SizedBox(
              height: 60,
              width: 250,
              child: Form(
                  key: _fkey,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    onChanged: (String value){
                      _email=value;
                    },
                    validator: (String? value){
                      if(value!.length<=0){
                        _checkUser(_email, _password);
                         return "Please Input Email ID";
                      }
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
                    prefixIcon: Icon(Icons.mail,color: Colors.white,),
                    labelText: "Enter your Email ID",
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: "Username",
                    hintStyle: TextStyle(color: Colors.blueGrey.shade100),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    focusColor: Colors.white10
                    
                    
                  ),
                  
                  ),
                ),

            ),



            Padding(padding: EdgeInsets.only(bottom:20)),
            SizedBox(
              height: 60,
              width: 250,
              child: Form(
                key: _pkey,
                  child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (value){
                    _password=value;
                  },
                  validator: (value){
                    if(value!.length<=0)
                      return "Please Input Password";
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    prefixIcon: Icon(Icons.lock,color: Colors.white,),
                    labelText: "Enter Password",
                    labelStyle: TextStyle(color:Colors.white),
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.blueGrey.shade100),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:Colors.white,
                      ),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                                              
                      ),
                      focusColor: Colors.white10
                  )

                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top:50)),
            SizedBox(
              width: 250,
              // height: ,
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
                if(_fkey.currentState!.validate() && _pkey.currentState!.validate()){
                    _checkUser(_email, _password);
                  }
    
              }
              , child: Text("Login",style: TextStyle(fontSize:20,color:Color.fromARGB(255, 180, 192, 240) ,fontFamily: 'OpenSans'),)

              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
                Padding(padding: EdgeInsets.all(20)),
                Text("New User? ",style: TextStyle(color: Colors.white),),
              MaterialButton(
                textColor: Colors.white,  
                elevation: 10.0,
                // style: ButtonStyle(
                // shape:MaterialStateProperty.all<RoundedRectangleBorder>(
                //   RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(18)

                //   )
                // ),),
                onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Register();
                }));
              }, child: Text("SIGN UP",style: TextStyle(fontSize: 15,fontFamily: 'OpenSans',fontWeight: FontWeight.bold),)
            ),
              ],
              )

          ],
        ),
      ),
    );
  }
}