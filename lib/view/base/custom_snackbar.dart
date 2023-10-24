import 'package:flutter/material.dart';

void showCustomSnackBar(String message, BuildContext context,{bool isError = true, Color? bgColor, int? duration}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: bgColor!=null? bgColor: isError ? Colors.red : Colors.green,
    content: Text(message),
    duration: Duration(seconds: duration !=null? duration : 2),
  ));
}