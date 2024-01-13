import 'dart:async';
import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/helper/date_converter.dart';
import 'package:turnarix/data/helper/helpers.dart';
import 'package:turnarix/data/model/shifts/calendar_shift_model.dart';
import 'package:turnarix/data/model/shifts/intervals_model.dart';
import 'package:turnarix/provider/shift_exchange_provider.dart';
import 'package:turnarix/provider/worker_calendar_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/screens/exchange/exchange_requests_screen.dart';
import 'package:turnarix/view/screens/exchange/main_exchanges_screen.dart';

class RequestShiftExchangeScreen extends StatefulWidget {
  final int? employeeId;
  final int? calendarShiftId;
  final IntervalModel? interval;
  RequestShiftExchangeScreen({@required this.employeeId, @required this.calendarShiftId, @required this.interval});

  @override
  State<RequestShiftExchangeScreen> createState() => _RequestShiftExchangeScreenState();
}

class _RequestShiftExchangeScreenState extends State<RequestShiftExchangeScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 0), () {
      Provider.of<ShiftExchangeProvider>(context, listen: false).resetExchangeDateTime();
      Provider.of<WorkerCalendarProvider>(context, listen: false).resetDayShifts();
    });
  }


  @override
  Widget build(BuildContext? context) {
    return Scaffold(
      backgroundColor: ColorResources.BG_SECONDRY,
      appBar: AppBar(
        title: Text('Richiesta lo scambio a turni',
            style: TextStyle(color: Theme.of(context!).primaryColor, fontWeight: FontWeight.normal)),
        centerTitle: true,
        backgroundColor: ColorResources.BG_SECONDRY,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Theme.of(context).primaryColor,
          onPressed: () =>  Navigator.pop(context),
        ),
      ),
      body: Consumer<ShiftExchangeProvider>(
        builder: (context, shiftExchangeProvider, child) {
          shiftExchangeFunction(int shiftId) {
            shiftExchangeProvider.requestShiftExchange(
                context,
                widget.employeeId!,
                shiftId,
                widget.calendarShiftId!
            ).then((value) {
              if(value.isSuccess){
                showCustomSnackBar('Richiesta inviata con successo', context, isError: false);
                shiftExchangeProvider.getExchangeRequests(context,'1', 'pending', 'user');
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                    MainExchangesScreen()));
              }else{
                showCustomSnackBar('qualcosa è andato storto', context);
              }
            });
          }
          return SafeArea(
            child: Scrollbar(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                physics: BouncingScrollPhysics(),
                child: Center(
                  child: SizedBox(
                    width: 1170,
                    child:
                    shiftExchangeProvider.exchangeRequestsIsLoading?
                    Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        )):
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: const Text('Il giorno del tuo turno con cui vuoi sostituire questo turno',
                                    style: TextStyle(color: Colors.white, fontSize: 16)))
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(child: InkWell(
                                onTap: () async {
                                  DateTime? dateTime = await showOmniDateTimePicker(
                                    context: context,
                                    type: OmniDateTimePickerType.dateAndTime,
                                    initialDate: shiftExchangeProvider.seletedDateShiftExchange!=null?
                                    shiftExchangeProvider.seletedDateShiftExchange : DateTime.now(),
                                    firstDate:
                                    DateTime(1600).subtract(const Duration(days: 3652)),
                                    lastDate: DateTime.now().add(
                                      const Duration(days: 3652),
                                    ),
                                    is24HourMode: false,
                                    isShowSeconds: false,
                                    minutesInterval: 1,
                                    secondsInterval: 1,
                                    isForce2Digits: true,
                                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                                    constraints: const BoxConstraints(
                                      maxWidth: 350,
                                      maxHeight: 650,
                                    ),
                                    transitionBuilder: (context, anim1, anim2, child) {
                                      return FadeTransition(
                                        opacity: anim1.drive(
                                          Tween(
                                            begin: 0,
                                            end: 1,
                                          ),
                                        ),
                                        child: child,
                                      );
                                    },
                                    transitionDuration: const Duration(milliseconds: 200),
                                    barrierDismissible: true,
                                    selectableDayPredicate: (dateTime) {
                                      // Disable 25th Feb 2023
                                      return true;
                                      if (dateTime.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
                                        return false;
                                      } else {
                                        return true;
                                      }
                                    },
                                  );
                                  shiftExchangeProvider.setExchangeDateTime(dateTime!);
                                  Provider.of<WorkerCalendarProvider>(context, listen: false).getDayCalendarShift(dateTime);
                                },
                                child: Container(
                                    height: 40,
                                    decoration:  BoxDecoration(
                                      color: ColorResources.BG_SECONDRY,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                                    ),
                                    child: Center(child: Text(shiftExchangeProvider.seletedDateShiftExchange!=null?
                                    '${DateConverter.formatDayMonthYear(shiftExchangeProvider.seletedDateShiftExchange!)}' :'Select Date', style: TextStyle(color: Theme.of(context).primaryColor)))),
                              ))
                            ],
                          ),
                        ),

                        const SizedBox(height: 50),

                        Provider.of<WorkerCalendarProvider>(context, listen: false).calendarShifts.isEmpty? const SizedBox():
                        Row(
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Text('Seleziona il turno con cui si desidera scambiare',
                                    style: TextStyle(color: Colors.white, fontSize: 16)))
                          ],
                        ),

                        const SizedBox(height: 10),
                        Provider.of<WorkerCalendarProvider>(context, listen: false).calendarShifts.isEmpty? const SizedBox():
                        Container(
                          height: 300,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: Provider.of<WorkerCalendarProvider>(context, listen: false).calendarShifts.length,
                            itemBuilder: (BuildContext context, int index) {
                              CalendarShiftModel _shift = Provider.of<WorkerCalendarProvider>(context, listen: false).calendarShifts[index];

                              IntervalModel _interval = _shift.interval!;
                              Color? _color;
                              _color =  _interval.iconColor!=null? Color(int.parse(_interval.iconColor!)): Colors.blueAccent;

                              IconData? _icon;
                              String? _iconName;

                              if(_interval.iconName != null){
                                Helpers.iconsList().forEach((element) {
                                  if(element['name'] == _interval.iconName){
                                    _icon = element['icon'];
                                    _iconName = element['name'];
                                  }
                                });
                              }else {
                                _icon = Icons.sunny;
                                _iconName = 'sunny';
                              }

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap:(){
                                        showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            backgroundColor: ColorResources.BG_SECONDRY,
                                            title: Text('Vuoi inviare una richiesta di scambio per questo turno?',
                                                style: TextStyle(color: Colors.white)),
                                            actions: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: CustomButton(btnTxt: 'No',
                                                        backgroundColor: Colors.grey,
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                      ),
                                                    ),

                                                    const SizedBox(width: 8),

                                                    Expanded(
                                                      child: CustomButton(btnTxt: 'SÌ',
                                                        onTap: () {
                                                          shiftExchangeFunction(_shift.id!);
                                                          Navigator.pop(context);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                                            ),

                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: ColorResources.BG_SECONDRY,
                                              //   borderRadius: BorderRadius.circular(100),

                                            ),
                                            child: Icon(_icon, color: _color),
                                          ),

                                          const SizedBox(width: 16),
                                          Text('${_interval.name}', style: TextStyle(color: Colors.white)),

                                          const Spacer(),
                                          Text('Selezionare', style: TextStyle(color: Colors.white70)),
                                        ],
                                      ),
                                    ),

                                    const Divider(color: Colors.white),

                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

