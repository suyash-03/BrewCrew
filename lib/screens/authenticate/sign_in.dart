import 'package:brewcrew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/shared/loading.dart';


class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});
  
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
   String email = '';
   String password = '';
   String error ='';
   final _formkey = GlobalKey<FormState>();
   final AuthService _auth = AuthService();
   bool loading = false;

   @override
  Widget build(BuildContext context) {

     //Checking with Bool loading variable value
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(onPressed: (){
            widget.toggleView();
            }, icon: Icon(Icons.person_add), label: Text('Register'))
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
                  hintText: 'Enter your e-mail address',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,width: 2.0),
                  ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown,width: 2.0),
                    )
                ),
                validator: (val) => val.isEmpty? 'Enter an E-Mail':null,
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
                    borderSide: BorderSide(color: Colors.brown,width: 2.0),
                  )
              ),
          obscureText: true,
            validator: (val) => val.length<6 ? 'Password length should be greater than 6 characters':null,
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
                dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                if(result == null){

                  setState(() => error = 'Could Not Sign with the Credentials');
                  loading = false;
                }
              }
              },child: Text('Sign In',
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
