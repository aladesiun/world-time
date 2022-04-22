import 'package:flutter/material.dart';
import 'package:locator/services/worldTime.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'dart:convert';



class Loading extends StatefulWidget {
  final String timezone;

  const Loading({Key? key,  required this.timezone}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late  String newUrl;
  late  String currentTime;
  @override
  void initState() {
    // TODO: implement initState
    setupWorldTime();

    super.initState();
    setState(() {
      newUrl =widget.timezone;
    });

  }
  @override

  Widget build(BuildContext context) {
    // String data = ModalRoute.of(context)?.settings.arguments as Map;

    return Scaffold(
      backgroundColor:Colors.blueAccent,
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
            Padding(
              padding: EdgeInsets.fromLTRB(0.0,220.0,0.0,0.0),
              child: SpinKitFoldingCube(
                color: Colors.white,
                size: 50.0,
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  'From',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'KAFFIR',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),


          ],
        ),
      ),

    );
  }
  void setupWorldTime() async{
    try{
      var endpoint = Uri.parse("http://worldtimeapi.org/api/ip");
      Response response = await get(endpoint);
      Map data = jsonDecode(response.body);

      print(data);
      setState(() {
        currentTime=data['timezone'];
      });
    }
    catch (e){
      print('error $e');
    }
    WorldTime instance = WorldTime(location:widget.timezone == '' ? currentTime : widget.timezone, flag:'lagos.png', url:widget.timezone == '' ? currentTime : widget.timezone);
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location':instance.location,
      'flag':instance.flag,
      'time':instance.time,
      'dayTime':instance.dayTime,
    });

  }

}
