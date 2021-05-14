import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error ='';
  bool loading = false ;
  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign Up to Brew Crew'),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton.icon(onPressed: (){
            widget.toggleView();
            }, icon: Icon(Icons.arrow_back), label: Text('Sign In'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical:20,horizontal: 50),
        child: Form(
          key: _formkey,
            child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'E-mail address for signing up to BrewCrew',
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue,width: 2.0),
                        )
                    ),
                    validator: (val) => val.isEmpty? 'Enter an E-Mail' : null,
                    onChanged: (val){
                      setState(() {
                        email = val;
                      });
                    },),
                  SizedBox(height: 20,),

                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Enter your Password',
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue,width: 2.0),
                        )
                    ),
                    obscureText: true,
                    validator: (val) => val.length< 6? 'Enter a password more than 6 characters' : null,
                    onChanged: (val){
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  SizedBox(height: 20,),
                  RaisedButton(color: Colors.pink[400],
                    onPressed: () async {
                      if(_formkey.currentState.validate()){
                        setState(() {
                          loading = true;
                        });
                        // dynamic data type because it can either be result or null
                       dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                       if(result == null){
                         setState(()
                           {
                             error = 'Please Enter a Valid E-Mail address' ;
                             loading = true;
                           });
                       }
                      }
                    },child: Text('Register',
                      style: TextStyle(color: Colors.white),),
                  ),
                  SizedBox(height:  12,),
                  Text(error,style: TextStyle(
                    color: Colors.red,
                    fontSize: 14
                  ),)
                ]
            )
        ),
      ),
    );
  }
}
