import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/provider/shift_exchange_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/utill/styles.dart';
import 'package:turnarix/view/screens/exchange/exchange_requests_screen.dart';

class MainExchangesScreen extends StatefulWidget {

  @override
  _MainExchangesScreenState createState() => _MainExchangesScreenState();
}

class _MainExchangesScreenState extends State<MainExchangesScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, initialIndex: 0, vsync: this);
    Timer(Duration(seconds: 0), () {
      Provider.of<ShiftExchangeProvider>(context, listen: false).updateRequestsType(false);
    });

    // Add a listener to execute a function when the tab changes
    _tabController!.addListener(() {
      if (_tabController!.indexIsChanging) {
        // This is called when the tab is tapped
        onTabTapped(_tabController!.index);
      }
    });
  }

  // Function to be executed when a tab is tapped
  void onTabTapped(int tabIndex) {
    String userType = Provider.of<ShiftExchangeProvider>(context, listen: false).isEmployeeRequests? 'employee': '';
    Provider.of<ShiftExchangeProvider>(context, listen: false).clearOffset();
    if (tabIndex == 0) {
      _tabIndex = 0;
      Provider.of<ShiftExchangeProvider>(context, listen: false)
          .getExchangeRequests(context,'1', 'pending', userType);
    } else if (tabIndex == 1) {
      _tabIndex = 1;
      Provider.of<ShiftExchangeProvider>(context, listen: false).getExchangeRequests(context,'1', 'accepted', userType);
    }else if (tabIndex == 2) {
      _tabIndex = 2;
      Provider.of<ShiftExchangeProvider>(context, listen: false).getExchangeRequests(context,'1', 'rejected', userType);
    }else if (tabIndex == 3) {
      _tabIndex = 3;
      Provider.of<ShiftExchangeProvider>(context, listen: false).getExchangeRequests(context,'1', 'canceled', userType);
    }
  }

  @override
  Widget build(BuildContext? context) {
    return
      Consumer<ShiftExchangeProvider>(
        builder: (context, shiftExchangeProvider, child){
          return Scaffold(
            backgroundColor: ColorResources.BG_SECONDRY,
            appBar: AppBar(
              backgroundColor: ColorResources.BG_SECONDRY,
              elevation: 0.0,
              title: Text('Richieste di scambio',
                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.normal)),
              // leading: IconButton(
              //   icon: Icon(Icons.arrow_back_ios),
              //   color: Theme.of(context!).primaryColor,
              //   onPressed: () => Navigator.pop(context),
              // ),
              centerTitle: true,
            ),
            body: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: InkWell(
                          onTap: () {
                            shiftExchangeProvider.updateRequestsType(false);
                            String userType = shiftExchangeProvider.isEmployeeRequests? 'employee': '';
                            Provider.of<ShiftExchangeProvider>(context, listen: false).clearOffset();
                            if (_tabIndex == 0) { //Undefined name 'tabIndex
                              Provider.of<ShiftExchangeProvider>(context, listen: false)
                                  .getExchangeRequests(context,'1', 'pending', userType);
                            } else if (_tabIndex == 1) {
                              Provider.of<ShiftExchangeProvider>(context, listen: false).getExchangeRequests(context,'1', 'accepted', userType);
                            }else if (_tabIndex == 2) {
                              Provider.of<ShiftExchangeProvider>(context, listen: false).getExchangeRequests(context,'1', 'rejected', userType);
                            }else if (_tabIndex == 3) {
                              Provider.of<ShiftExchangeProvider>(context, listen: false).getExchangeRequests(context,'1', 'canceled', userType);
                            }
                          },
                          child: Container(
                              height: 35,
                              decoration: BoxDecoration(
                                color: shiftExchangeProvider.isEmployeeRequests == false?
                                Theme.of(context).primaryColor :
                                Theme.of(context).primaryColor.withOpacity(0.2),
                                border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(child: Text('Your requests',
                                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                        )),

                        const SizedBox(width: 10),

                        Expanded(child: InkWell(
                          onTap: () {
                            shiftExchangeProvider.updateRequestsType(true);

                            String userType = shiftExchangeProvider.isEmployeeRequests? 'employee': '';
                            Provider.of<ShiftExchangeProvider>(context, listen: false).clearOffset();
                            if (_tabIndex == 0) { //Undefined name 'tabIndex
                              Provider.of<ShiftExchangeProvider>(context, listen: false)
                                  .getExchangeRequests(context,'1', 'pending', userType);
                            } else if (_tabIndex == 1) {
                              Provider.of<ShiftExchangeProvider>(context, listen: false).getExchangeRequests(context,'1', 'accepted', userType);
                            }else if (_tabIndex == 2) {
                              Provider.of<ShiftExchangeProvider>(context, listen: false).getExchangeRequests(context,'1', 'rejected', userType);
                            }else if (_tabIndex == 3) {
                              Provider.of<ShiftExchangeProvider>(context, listen: false).getExchangeRequests(context,'1', 'canceled', userType);
                            }
                          },
                          child: Container(
                              height: 35,
                              decoration: BoxDecoration(
                                color: shiftExchangeProvider.isEmployeeRequests?
                                Theme.of(context).primaryColor :
                                Theme.of(context).primaryColor.withOpacity(0.2),
                                border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(child: Text('Employee requests',
                                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                        )),

                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 1170,
                      //color: Colors.white,
                      child: Container(
                        color: ColorResources.BG_SECONDRY,
                        child: TabBar(
                          controller: _tabController,
                          labelColor: Colors.white,
                          indicatorColor: Theme.of(context).primaryColor,
                          indicatorWeight: 3,
                          unselectedLabelStyle: rubikRegular.copyWith(color: ColorResources.COLOR_HINT, fontSize: Dimensions.FONT_SIZE_SMALL),
                          labelStyle: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),

                          tabs: [
                            Tab(text: 'Pending'),
                            Tab(text: 'Accepted'),
                            Tab(text: 'Rejected'),
                            Tab(text: 'Canceled'),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Expanded(child: TabBarView(
                    controller: _tabController,
                    children: [
                      ExchangeRequestsScreen(status: 'pending'),
                      ExchangeRequestsScreen(status: 'accepted'),
                      ExchangeRequestsScreen(status: 'rejected'),
                      ExchangeRequestsScreen(status: 'canceled'),
                    ],
                  )),

                ]),
          );
        });

  }
}