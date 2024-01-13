import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/helper/helpers.dart';
import 'package:turnarix/data/model/shifts/exchange_request_model.dart';
import 'package:turnarix/data/model/shifts/intervals_model.dart';
import 'package:turnarix/provider/shift_exchange_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/view/base/border_button.dart';
import 'package:turnarix/view/screens/calendar/employee/employee_interval_screen.dart';
import 'package:turnarix/view/screens/exchange/widgets/employee_buttons.dart';
import 'package:turnarix/view/screens/exchange/widgets/user_buttons.dart';

class ExchangeRequestsScreen extends StatefulWidget {
  final String? status;
  ExchangeRequestsScreen({@required this.status});
  @override
  _ExchangeRequestsScreenState createState() => _ExchangeRequestsScreenState();
}

class _ExchangeRequestsScreenState extends State<ExchangeRequestsScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
  GlobalKey<ScaffoldMessengerState>();

  ScrollController scrollController =  ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext? context) {

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorResources.BG_SECONDRY,
        // appBar: AppBar(
        //   title: Text('Richieste di scambio',
        //       style: TextStyle(color: Theme.of(context!).primaryColor, fontWeight: FontWeight.normal)),
        //   centerTitle: true,
        //   backgroundColor: ColorResources.BG_SECONDRY,
        //   elevation: 0.5,
        //   leading: IconButton(
        //     icon: const Icon(Icons.arrow_back_ios),
        //     color: Theme.of(context).primaryColor,
        //     onPressed: () =>  Navigator.pop(context),
        //   ),
        // ),
        body: Consumer<ShiftExchangeProvider>(
          builder: (context, shiftExchangeProvider, child) {
            int? exchangesLength;
            int? totalSize;
            exchangesLength = shiftExchangeProvider.exchangeRequestLists.length;
            totalSize = shiftExchangeProvider.totalExchangeRequestsSize ?? 0;

            return Column(
              children: [
                Expanded(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: Center(
                        child: SizedBox(
                          width: 1170,
                          child: shiftExchangeProvider.exchangeRequestsIsLoading?
                          Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))):

                          shiftExchangeProvider.exchangeRequestLists.isNotEmpty ?
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                padding: const EdgeInsets.all(6),
                                itemCount: shiftExchangeProvider.exchangeRequestLists.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  ExchangeRequestModel _exchangeRequest = shiftExchangeProvider.exchangeRequestLists[index];
                                  IntervalModel _employeeInterval = _exchangeRequest.employeeShift!.interval!;
                                  IntervalModel _userInterval = _exchangeRequest.userShift!.interval!;

                                  Color? _color;
                                  _color =  _employeeInterval.iconColor!=null?
                                  Color(int.parse(_employeeInterval.iconColor!)):
                                  Colors.blueAccent;

                                  IconData? _icon;
                                  String? _iconName;

                                  if(_employeeInterval.iconName != null){
                                    Helpers.iconsList().forEach((element) {
                                      if(element['name'] == _employeeInterval.iconName){
                                        _icon = element['icon'];
                                        _iconName = element['name'];
                                      }
                                    });
                                  }else {
                                    _icon = Icons.sunny;
                                    _iconName = 'sunny';
                                  }

                                  // user
                                  Color? _userColor;
                                  _userColor =  _userInterval.iconColor!=null? Color(int.parse(_userInterval.iconColor!)):
                                  Colors.blueAccent;

                                  IconData? _userIcon;
                                  String? _userIconName;

                                  if(_userInterval.iconName != null){
                                    Helpers.iconsList().forEach((element) {
                                      if(element['name'] == _userInterval.iconName){
                                        _userIcon = element['icon'];
                                        _userIconName = element['name'];
                                      }
                                    });
                                  }else {
                                    _userIcon = Icons.sunny;
                                    _userIconName = 'sunny';
                                  }

                                  Color? _statusColor;
                                  IconData? _statusIcon;

                                  if(_exchangeRequest.status == 'pending'){
                                    _statusColor = Colors.cyan;
                                    _statusIcon = Icons.pending_outlined;
                                  }else if(_exchangeRequest.status == 'accepted'){
                                    _statusColor = Colors.green;
                                    _statusIcon = Icons.check_circle;
                                  }else if(_exchangeRequest.status == 'rejected'){
                                    _statusColor = Colors.red;
                                    _statusIcon = Icons.close;
                                  }else if(_exchangeRequest.status == 'canceled'){
                                    _statusColor = Colors.red;
                                    _statusIcon = Icons.close;
                                  }

                                  // void _cancelExchangeRequest() {
                                  //   shiftExchangeProvider.cancelExchangeRequest(context, _exchangeRequest.id!).then((value) {
                                  //     shiftExchangeProvider.getExchangeRequests(context,'1','pending' ,'user');
                                  //   });
                                  // }

                                  return
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: Container(
                                        decoration: BoxDecoration(
                                        //  color: ColorResources.DARK_BLUE,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(width: 1, color: Theme.of(context).primaryColor.withOpacity(0.5)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              //Text('${_userInterval.services![0].id}', style: TextStyle(color: Colors.white)),

                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width * 0.35,
                                                    child: Text('Employee:', style:
                                                    TextStyle(color: Colors.white70, fontSize: 16)),
                                                  ),

                                                  Text('${_exchangeRequest.employee!.name}',
                                                      style: const TextStyle(color: Colors.white, fontSize: 16)),

                                                ],
                                              ),

                                              const SizedBox(height: 12),

                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width * 0.35,
                                                    child: const Text('Employee Shift:',
                                                        style:  TextStyle(color: Colors.white70, fontSize: 16)),
                                                  ),

                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width * 0.2,
                                                    child: Text('${_exchangeRequest.employeeShift!.interval!.name}',
                                                        style: const TextStyle(color: Colors.white, fontSize: 16)),
                                                  ),

                                                  Icon(_icon, color: _color)
                                                ],
                                              ),

                                              const SizedBox(height: 12),

                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width * 0.35,
                                                    child: Text('Your Shift:', style:
                                                    TextStyle(color: Colors.white70, fontSize: 16)),
                                                  ),

                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width * 0.2,
                                                    child: Text('${_exchangeRequest.userShift!.interval!.name}',
                                                        style: TextStyle(color: Colors.white, fontSize: 16)),
                                                  ),

                                                  Icon(_userIcon, color: _userColor),

                                                ],
                                              ),

                                              const SizedBox(height: 12),

                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width * 0.35,
                                                    child: Text('Status:', style:
                                                    TextStyle(color: Colors.white70, fontSize: 16)),
                                                  ),

                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width * 0.2,
                                                    child: Text('${_exchangeRequest.status}',
                                                        style: const TextStyle(color: Colors.white, fontSize: 16)),
                                                  ),

                                                  Icon(_statusIcon, color: _statusColor)
                                                ],
                                              ),

                                              const SizedBox(height: 10),

                                              // _exchangeRequest.status == 'canceled'
                                              //     || _exchangeRequest.status == 'accepted' || _exchangeRequest.status == 'rejected'?
                                              // const SizedBox():
                                              Row(
                                                children: [

                                                  Expanded(child: BorderButton(
                                                    borderColor: Theme.of(context).primaryColor,
                                                    textColor: Colors.white,
                                                    btnTxt: 'Your shift',
                                                    onTap: () {
                                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                                                          EmployeeIntervalScreen(
                                                            interval: _userInterval,
                                                            fromRequestsScreen: true,
                                                          )));
                                                    },
                                                  )),

                                                  const SizedBox(width: 8),

                                                  Expanded(child: BorderButton(
                                                    borderColor: Theme.of(context).primaryColor,
                                                    textColor: Colors.white,
                                                    btnTxt: 'Requested shift',
                                                    onTap: () {
                                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                                                          EmployeeIntervalScreen(
                                                            interval: _employeeInterval,
                                                            fromRequestsScreen: true,
                                                          )));
                                                    },
                                                  )),

                                                ],
                                              ),

                                              shiftExchangeProvider.isEmployeeRequests?
                                                  Padding(
                                                    padding: EdgeInsets.only(top: shiftExchangeProvider.isEmployeeRequests ? 15: 0),
                                                    child: EmployeeButtons(exchangeRequest: _exchangeRequest, listStatus: widget.status),
                                                  ) : const SizedBox(),

                                              !shiftExchangeProvider.isEmployeeRequests?
                                              Padding(
                                                padding: EdgeInsets.only(top: shiftExchangeProvider.isEmployeeRequests ? 15: 0),
                                                child: UserButtons(exchangeRequest: _exchangeRequest, listStatus: widget.status),
                                              ): const SizedBox(),


                                             // const SizedBox(height: 10)
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                },
                              ),

                              shiftExchangeProvider.bottomExchangeRequestsLoading?
                              Column(
                                children: [
                                  SizedBox(height: 10),
                                  Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
                                ],
                              ) :
                              exchangesLength < totalSize?
                              Center(child:
                              GestureDetector(
                                  onTap: () {
                                    String offset = shiftExchangeProvider.exchangeRequestsOffset ?? '';
                                    int offsetInt = int.parse(offset) + 1;
                                    print('$offset -- $offsetInt');
                                    shiftExchangeProvider.showBottomRunningOrdersLoader();
                                    shiftExchangeProvider.getExchangeRequests(context, offsetInt.toString(), widget.status!, 'user');
                                  },
                                  child: Text('Load more',style:
                                  TextStyle(color: Theme.of(context).primaryColor)))) :

                              const SizedBox(),
                            ],
                          ) :
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Center(child: Text('Nessun oggetto', style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            );
          },
        )
    );
  }
}

