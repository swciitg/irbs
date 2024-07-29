import 'package:flutter/material.dart';

String time24to12Format(String time) {
  int h = int.parse(time.split(":").first);
  int m = int.parse(time.split(":").last.split(" ").first);
  String send = "";
  if (h > 12) {
    var temp = h - 12;
    send =
        "$temp:${m.toString().length == 1 ? "0$m" : m.toString()} PM";
  } else if(h == 12){
    send =
    "$h:${m.toString().length == 1 ? "0$m" : m.toString()} PM";
  }
    else {
    send =
        "$h:${m.toString().length == 1 ? "0$m" : m.toString()} AM";
  }

  return send;
}

String formatTimeOfDay(TimeOfDay time){
  return "${time.hour > 12 ? time.hour - 12 : time.hour}:${time.minute < 10 ? "0" : ""}${time.minute} ${time.hour < 12 ? "AM" : "PM"}";
}