import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/screens/authenticate/authenticate.dart';
import 'package:brewcrew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Provider is used along side of Stream return type
    final user = Provider.of<User>(context);
    if (user == null){
      return Authenticate();
    }
    else {
      return Home();
    }

    //return either home or authenticate widget

  }
}
