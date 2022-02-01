import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location = ""; // location name for the UI
  String time = ""; // the time in that location
  String? flag; // url to an asset flag icon;
  String? url; // location url for api endpoint;
  bool isDaytime = true; // true or false if date time or not

  WorldTime({ required this.location, this.flag, this.url, });

  Future<void> getTime() async {
    try{
      // make a request
      Response response = await get(Uri.parse('http://www.worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      // print(data);
      // get properties from data
      String datetime = data['datetime'];
      // print(data['utc_offset']);
      String offset = data['utc_offset'].substring(1, 3);

      // print("The datetime is: $datetime");
      // print("Offset: $offset");

      // create Datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      // print(now);
      isDaytime = now.hour>6 && now.hour < 20;
      // or isDaytime = now.hour>6 && now.hour < 20 ? true : false;
      // set time property
      time = DateFormat.jm().format(now);
    }

    catch(e) {
      print('Caught error: $e');
      time = 'Could not get time data';
    }

  }

}