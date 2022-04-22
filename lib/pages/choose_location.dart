import 'package:flutter/material.dart';
import 'package:locator/pages/loading.dart';
import 'package:locator/services/worldTime.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'dart:convert';
class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key, }) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List timeZones = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getTimeZone();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Location"),
        centerTitle: true,
        backgroundColor: Colors.blue[900],

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: isLoading ?
            const Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            )
            :
            ListView.builder(
            itemCount: timeZones.length,
            itemBuilder: (context, index){
              String timezone = timeZones[index];
              return Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3)
                ),
                margin: EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder:
                            (context)=> Loading(timezone: timezone)));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(timezone),
                        Icon(Icons.chevron_right)
                      ],
                    ),
                  ),
                ),
              );
            }
        )
      ),
    );
  }

  Future<void> getTimeZone() async{
    setState(() {
      isLoading = true;
    });
    try{
      var endpoint = Uri.parse("http://worldtimeapi.org/api/timezone");
      Response response = await get(endpoint);
      var data = jsonDecode(response.body);

      setState(() {
        timeZones = data;
      });

    }
    catch (e){
      print('error $e');
    }

    setState(() {
      isLoading = false;
    });
  }

}
