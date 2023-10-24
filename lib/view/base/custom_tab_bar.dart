import 'package:turnarix/utill/color_resources.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text;
  final int? index;
  final int? selectedIndex;
  CustomTabBar({this.onTap, @required this.text, @required this.index, @required this.selectedIndex});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 50,
      width: 80,
      decoration: BoxDecoration(
        color: index == selectedIndex? Colors.white: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: Text(text!)),
    );
  }
}
