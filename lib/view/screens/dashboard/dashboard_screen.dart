import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/provider/auth_provider.dart';
import 'package:turnarix/view/screens/calendar/calendar_screen.dart';
import 'package:turnarix/view/screens/home/home_screen.dart';
import 'package:turnarix/view/screens/menu/menu_screen.dart';

class DashboardScreen extends StatefulWidget {
  final int? pageIndex;
  DashboardScreen({@required this.pageIndex});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController? _pageController;
  int _pageIndex = 0;
  List<Widget>? _screens;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();


  @override
  void initState() {
    super.initState();

    _pageIndex = widget.pageIndex!;

    _pageController = PageController(initialPage: widget.pageIndex!);

    _screens = [
      CalendarScreen(),
      MenuScreen(),
      MenuScreen()
    ];
  }

  @override
  Widget build(BuildContext? context) {

    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Theme.of(context!).primaryColor,
          unselectedItemColor: Theme.of(context).textTheme.headline2!.color!.withOpacity(0.6),
          showUnselectedLabels: true,
          currentIndex: _pageIndex,
          selectedFontSize: Theme.of(context).textTheme.bodyText1!.fontSize!,
          unselectedFontSize: Theme.of(context).textTheme.bodyText1!.fontSize!,
          type: BottomNavigationBarType.fixed,

          items: [
            _barItem(Icons.home, '', 0),
            _barItem(Icons.message, '', 1),
            _barItem(Icons.person, '', 2),
            _barItem(Icons.settings, '', 3),
            //_barItem(CupertinoIcons.info, '', 1),
            _barItem(Icons.pie_chart, '', 4),
          ],
          onTap: (int index) {
            _setPage(index);
          },
        ),

      body: PageView.builder(
          controller: _pageController,
          itemCount: _screens!.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens![index];
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _barItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none, children: [
        Icon(icon, color: index == _pageIndex ? Theme.of(context).primaryColor : Theme.of(context).textTheme.headline2!.color!.withOpacity(0.6),
            size: 30),
      ],
      ),
      label: label,
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController!.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
      final bool _isLoggedIn = Provider.of<AuthProvider>(context, listen: false).isLoggedIn;
       if (_pageIndex == 1) {
         if(_isLoggedIn){

         }
      }
    });
  }
}
