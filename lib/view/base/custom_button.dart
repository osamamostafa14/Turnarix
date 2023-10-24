import 'package:turnarix/utill/color_resources.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? btnTxt;
  final Color? backgroundColor;
  final Color? textColor;
  CustomButton({this.onTap, @required this.btnTxt, this.backgroundColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onTap == null ? ColorResources.getGreyColor(context) : backgroundColor == null ? Theme.of(context).primaryColor : backgroundColor,
      minimumSize: Size(MediaQuery.of(context).size.width, 50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return TextButton(
      onPressed: onTap,
      style: flatButtonStyle,
      child: Text(btnTxt??"",
          style: Theme.of(context).textTheme.headline3!.copyWith(
              color: textColor!=null? textColor: ColorResources.COLOR_WHITE,
              fontSize: 13, fontWeight: FontWeight.bold)),
    );
  }
}
