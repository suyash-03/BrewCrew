import 'package:brewcrew/models/brew.dart';
import 'package:brewcrew/screens/home/settings_form.dart';
import 'package:brewcrew/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:brewcrew/services/database.dart';
import 'brew_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
          child: SettingsForm()
        );
      });
    }


    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brewsStream,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton.icon(onPressed: () async
            {
              await _auth.signOut();
            } , icon: Icon(Icons.person), label: Text('Logout')),
            FlatButton.icon(onPressed: (){_showSettingsPanel();}, icon: Icon(Icons.settings), label: Text('Settings'))

          ],

        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
                  fit: BoxFit.cover
            )
          ),
            child: BrewList()),

      ),
    );
  }
}
