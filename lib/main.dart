import 'package:flutter/material.dart';
import 'package:time_management_app/pages/control_page.dart';
import 'package:time_management_app/pages/home_page.dart';
import 'package:time_management_app/pages/landing_page.dart';
import 'package:time_management_app/quote/quote_model.dart';

import 'quote/quote.dart';
void main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Quotes().getAll();
  runApp(myApp());
}


class HomePage1 extends StatelessWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("home"),
      ),
    );
  }
}

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: landingPage(),
    );
  }

}
