import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void showToast(message, color, time) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIos: time,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 25.0,
  );
}
