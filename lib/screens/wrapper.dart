import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_app/models/user.dart';
import 'package:reservation_app/service/auth.dart';
import 'package:reservation_app/utilities/splashScreen.dart';
import 'authenticate/authenticate.dart';
import 'home/Project/homePage.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().newUser,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      )
    );
  }
}


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if (user == null){
      return Authenticate();
    } else {
      return HomePage();
    }

  }
}