import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/provider/auth_provider.dart';
import 'package:turnarix/utill/dimensions.dart';

class LoginBottomSheet extends StatelessWidget {
  
  @override
  Widget build(BuildContext? context) {
    final size = MediaQuery.of(context!).size;

    return Stack(
      children: [
        Container(
          width: 550,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft:
            Radius.circular(20),topRight: Radius.circular(20)),
          ),
          child: Consumer<AuthProvider>(
            builder: (context, authProvider, child) {

              return SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                    ]),
              );
            },
          ),
        ),
      ],
    );
  }
}

