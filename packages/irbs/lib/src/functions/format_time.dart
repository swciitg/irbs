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