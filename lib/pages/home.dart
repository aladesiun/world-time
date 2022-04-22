import 'package:flutter/material.dart';
import 'package:locator/pages/choose_location.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map;
    String bgImage = data['dayTime'] ? "day.png" : "night.png";
    // Color bgColor = data['dayTime'] ? Colors.blue : Colors.indigo;
    return Scaffold(
      body:  SafeArea(
        child: Container(
          decoration:  BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 120.0, 0.0,0.0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                    onPressed: (){
                      Navigator.push(context, 
                          MaterialPageRoute(builder:
                              (context)=> ChooseLocation()));
                    },
                    icon: Icon(
                        Icons.edit_location,
                      color: Colors.grey[300],
                    ),
                  label:Text(
                      "Edit Location",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ) ,

                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        data['location'],
                        style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 23.0),
                Text(
                    data['time'],
                    style:TextStyle(
                      fontSize: 60.0,
                      color: Colors.white
                    ),
                ),
                SizedBox(height: 23.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
