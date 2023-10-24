import 'package:turnarix/Theme/light_theme.dart';
import 'package:turnarix/provider/auth_provider.dart';
import 'package:turnarix/provider/calendar_provider.dart';
import 'package:turnarix/provider/localization_provider.dart';
import 'package:turnarix/provider/profile_provider.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:turnarix/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'di_container.dart' as di;
import 'package:turnarix/provider/splash_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:turnarix/route/route.dart' as route;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  final applicationDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(applicationDocumentDir.path);
  await Hive.openBox('myBox');


  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CalendarProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ShiftsProvider>()),

    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then((value) {});
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<SplashProvider>(
      builder: (context, splashProvider, child){

        return  MaterialApp(
          onGenerateRoute: route.controller,
          initialRoute: route.splashScreen,
          theme: light,
          title: 'Turnarix',
          debugShowCheckedModeBanner: false,
          navigatorKey: MyApp.navigatorKey,
        );
      },
    );
  }
}
