import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/model/response/base/api_response.dart';
import 'package:turnarix/provider/splash_provider.dart';

class ConnectionChecker {
  static void checkApi(BuildContext context, ApiResponse apiResponse) {
    if(apiResponse.error is! String && apiResponse.error.errors[0].message == 'Unauthenticated.') {
      Provider.of<SplashProvider>(context, listen: false).removeSharedData();
      //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> LoginScreen()));
    }else {
    }
  }
}