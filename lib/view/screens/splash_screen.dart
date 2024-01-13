import 'dart:async';
import 'package:turnarix/data/model/response/response_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:turnarix/provider/auth_provider.dart';
import 'package:turnarix/provider/calendar_provider.dart';
import 'package:turnarix/provider/profile_provider.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:turnarix/provider/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/provider/vacation_provider.dart';
import 'package:turnarix/utill/images.dart';
import 'package:turnarix/view/screens/auth/login_screen.dart';
import 'package:turnarix/view/screens/dashboard/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  StreamSubscription<ConnectivityResult>? _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    bool _firstTime = true;
    // _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    //   if(!_firstTime) {
    //     bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
    //     isNotConnected ? SizedBox() : _globalKey.currentState!.hideCurrentSnackBar();
    //     _globalKey.currentState!.showSnackBar(SnackBar(
    //       backgroundColor: isNotConnected ? Colors.red : Colors.green,
    //       duration: Duration(seconds: isNotConnected ? 6000 : 3),
    //       content: Text(
    //         isNotConnected ? 'No connection' : 'Connected',
    //         textAlign: TextAlign.center,
    //       ),
    //     ));
    //     if(!isNotConnected) {
    //       _route();
    //     }
    //   }
    //
    //
    //   _firstTime = false;
    // });

    _route();

  }

  @override
  void dispose() {
    super.dispose();
  //  _onConnectivityChanged!.cancel();
  }

  void _route() {

    try {
      Provider.of<CalendarProvider>(context, listen: false).getFirstDayNameOfMonth(DateTime.now());

      Provider.of<CalendarProvider>(context, listen: false).initCalendar();
      Provider.of<CalendarProvider>(context, listen: false).getDateInfo(DateTime.now());
      Provider.of<SplashProvider>(context, listen: false).initConfig(_globalKey, context).then((bool isSuccess) async {
        if (isSuccess) {
          Provider.of<AuthProvider>(context, listen: false).checkLoggedIn().then((value) async {
            if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn){
              Provider.of<CalendarProvider>(context, listen: false).getCalendarShifts(context);
              Provider.of<CalendarProvider>(context, listen: false).getShiftIntervals(context);
              Provider.of<ShiftsProvider>(context, listen: false).getShiftslist(context);
              Provider.of<VacationProvider>(context, listen: false).getVacationsList(context, '1');
              ResponseModel _response = await Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
              if(_response.isSuccess){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>
                    DashboardScreen(pageIndex: 0)));
              }else{
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> LoginScreen()));
              }
            }else {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> LoginScreen()));
            }
          });
        }
      });
    } catch(e) {
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> LoginScreen()));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: Color(0xFF1f232f),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(Images.main_logo, height: 120),
            ),

            const SizedBox(height: 25),

            Text('Turnarix', style: TextStyle(color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500, fontSize: 25)),

            // CustomButton(btnTxt: 'SignUp', onTap: () {
            //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> SignupScreen()));
            // })
          ],
        ),
      ),
    );
  }
}
