import 'package:hive/hive.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:flutter/material.dart';

class FacebookButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? btnTxt;
  final Color? backgroundColor;
  final Color? textColor;
  FacebookButton({this.onTap, @required this.btnTxt, this.backgroundColor, this.textColor});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){

      },
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text('Facebook'),
      ),
    );
  }
}
