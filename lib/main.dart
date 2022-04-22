import 'package:flutter/material.dart';
import 'package:locator/pages/choose_location.dart';
import 'package:locator/pages/home.dart';
import 'package:locator/pages/loading.dart';


void main() {
  runApp( MaterialApp(
    // home: Home(),
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/':(context )=>Loading(timezone: '',),
      '/home':(context)=> Home(),
      '/location':(context)=>ChooseLocation(),
    },
  ));
}
// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('hello from here'),
//       ),
//     );
//   }
// }
