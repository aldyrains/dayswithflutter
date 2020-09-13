import 'dart:async';

import 'package:day1analogclock/size_config.dart';
import 'package:flutter/material.dart';

class TimeInHour extends StatefulWidget {
  @override
  _TimeInHourState createState() => _TimeInHourState();
}

class _TimeInHourState extends State<TimeInHour> {
  TimeOfDay _timeOfDay = TimeOfDay.now();
  @override
  @override
  void initState() { 
    super.initState();
    Timer.periodic(Duration(seconds: 1),(timer){
      if(_timeOfDay.minute != TimeOfDay.now().minute){
        setState(() {
          _timeOfDay = TimeOfDay.now();
        });
      }
    });
  }
  
  Widget build(BuildContext context) {
    String _period = _timeOfDay.period == DayPeriod.am ? "AM" : "PM";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(
           "${_timeOfDay.hourOfPeriod}:${_timeOfDay.minute}",
           style:Theme.of(context).textTheme.headline1,

         ),
         SizedBox(width:5),
         RotatedBox(
           quarterTurns: 3,
                    child: Text(_period,
           style: TextStyle(fontSize: getProportionateScreenWidth(18)),
           ),
         )
      ],
    );
  }
}