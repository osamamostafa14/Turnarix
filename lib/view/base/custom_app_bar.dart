import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBackButtonExist;
  final Function? onBackPressed;
  CustomAppBar({@required this.title, this.isBackButtonExist = true, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title!, style: rubikMedium.copyWith(fontSize: 14, color: ColorResources.TEXT_COLOR)),
      centerTitle: true,
      leading: isBackButtonExist ? IconButton(
        icon: Icon(Icons.arrow_back_ios),
        color: Colors.white,
        onPressed: () => onBackPressed != null ? onBackPressed!() : Navigator.pop(context),
      ) : SizedBox(),
      backgroundColor: ColorResources.BG_GREY,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, kIsWeb ? 80 : 50);
}
