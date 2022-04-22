import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String? location;
  String? time;
  String? flag;
  String? url;
  bool? dayTime;

  WorldTime({this.location, this.flag, this.time, this.url});
  Future<void> getTime() async{
    try{
      var endpoint = Uri.parse("http://worldtimeapi.org/api/timezone/$url");
      Response response = await get(endpoint);
      Map data = jsonDecode(response.body);

      //  get property from data

      var datetime = data['datetime'];

      var offset = data['utc_offset'].substring(1,3);

      DateTime now = DateTime.parse(datetime) ;
      now = now.add(Duration(hours: int.parse(offset)));

      //set time property
      time = DateFormat.jm().format(now);
      dayTime = now.hour > 6 && now.hour < 20 ? true : false;
    }
    catch (e){
      print('error $e');
      time = 'Oops!... Failed to get Time';
    }


  }

}
