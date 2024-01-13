import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/helper/date_converter.dart';
import 'package:turnarix/data/helper/helpers.dart';
import 'package:turnarix/data/model/calendar_data_model.dart';
import 'package:turnarix/data/model/response/response_model.dart';
import 'package:turnarix/data/model/shifts/calendar_shift_model.dart';
import 'package:turnarix/data/model/shifts/intervals_model.dart';
import 'package:turnarix/data/model/vacation_model.dart';
import 'package:turnarix/data/model/year_model.dart';
import 'package:turnarix/provider/calendar_provider.dart';
import 'package:turnarix/provider/shift_exchange_provider.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:turnarix/provider/worker_calendar_provider.dart';
import 'package:turnarix/utill/app_constants.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/base/custom_text_field.dart';
import 'package:turnarix/view/screens/calendar/calendar_bottom_sheet.dart';
import 'package:turnarix/view/screens/calendar/shifts_bottom_sheet.dart';
import 'package:turnarix/view/screens/calendar/widgets/shift_details_bottom_sheet.dart';
import 'package:turnarix/view/screens/calendar/widgets/vacations_list_bottom_sheet.dart';
import 'package:turnarix/view/screens/exchange/exchange_requests_screen.dart';
import 'package:turnarix/view/screens/exchange/main_exchanges_screen.dart';
import 'package:turnarix/view/screens/shifts/add_shift_screen.dart';
import 'package:turnarix/view/screens/shifts/interval_list_screen.dart';
import 'package:turnarix/view/screens/shifts/shifts_screen.dart';
import 'package:turnarix/view/screens/vacation/vacations_screen.dart';
import 'package:turnarix/view/screens/vacation/widget/vacation_sheet.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() =>
      _CalendarScreenState();
}

class _CalendarScreenState
    extends State<CalendarScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;
  ScrollController scrollController =  ScrollController();
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      Provider.of<CalendarProvider>(context, listen: false).getShiftIntervals(context);
    });
    // Add a listener to the PageController
    _pageController.addListener(_scrollListener);
  }
  void _scrollListener() {
    // Get the current page based on the controller's offset
    currentPage = _pageController.page?.round() ?? 0;

    // DateTime firstDayOfNextMonth = DateTime(
    //     Provider.of<CalendarProvider>(context, listen: false).selectedDatetime!.year,
    //     Provider.of<CalendarProvider>(context, listen: false).selectedDatetime!.month + 1, 1);
    //
    // Provider.of<CalendarProvider>(context, listen: false).getFirstDayNameOfMonth(firstDayOfNextMonth);
    // Provider.of<CalendarProvider>(context, listen: false).getDateInfo(firstDayOfNextMonth);

    // Execute your desired function after every scroll
    print('Scrolled to page $currentPage');
  }



  @override
  void dispose() {
    // Dispose of the PageController when the widget is no longer used
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarProvider>(
        builder: (context, calendarProvider, child) {

          DateTime today = DateTime.now();
          int initialPageIndex = calendarProvider.dateList!.indexWhere((date) =>
          date.year == today.year && date.month == today.month);

          PageController _pageController = PageController(initialPage: initialPageIndex);

          return Scaffold(
            backgroundColor: ColorResources.BG_SECONDRY,
            appBar: AppBar(
              title: const Text('',
                  style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 20)),
              centerTitle: true,
              backgroundColor: Colors.white.withOpacity(0.0),
              elevation: 0.0,
              leading: IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                color: Colors.black54,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      backgroundColor: ColorResources.BG_SECONDRY,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              // Provider.of<ShiftsProvider>(context, listen: false).clearOffset();
                              Provider.of<ShiftsProvider>(context, listen: false).getShiftslist(context);
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
                                  IntervalListScreen()));
                            },
                            child: const Row(
                              children: [
                                Text('Sezione Turni', style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                )),

                                 Spacer(),

                                Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Colors.white70)
                              ],
                            ),
                          ),

                          const Padding(
                            padding:  EdgeInsets.only(top: 7, bottom: 7),
                            child: Divider(),
                          ),

                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Provider.of<ShiftExchangeProvider>(context, listen: false).clearOffset();
                              Provider.of<ShiftExchangeProvider>(context, listen: false).
                              getExchangeRequests(context,'1', 'pending', 'user');
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
                                  MainExchangesScreen()));
                            },
                            child: const Row(
                              children: [
                                Text('Scambi di turno', style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                )),

                                 Spacer(),

                                Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Colors.white70)
                              ],
                            ),
                          ),

                          const Padding(
                            padding:  EdgeInsets.only(top: 7, bottom: 7),
                            child: Divider(),
                          ),

                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
                                  VacationsScreen()));
                            },
                            child: const Row(
                              children: [
                                Text('vacanze', style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                )),

                                Spacer(),

                                Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Colors.white70)
                              ],
                            ),
                          ),

                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                      ),
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // FloatingActionButton(
                //   backgroundColor: Theme.of(context).primaryColor,
                //   onPressed: () {
                //
                //   },
                //   tooltip: 'Edit',
                //   child: const Icon(Icons.bedtime_off),
                // ),
                //
                // const SizedBox(width: 5),

                // FloatingActionButton(
                //   backgroundColor: Theme.of(context).primaryColor,
                //   onPressed: () {
                //     print('${calendarProvider.monthVacationStats}');
                //   },
                //   tooltip: 'Edit',
                //   child: const Icon(Icons.edit),
                // ),
              ],
            ),
            body: PageView.builder(
              controller: _pageController, // Attach the PageController
              scrollDirection: Axis.vertical,
              itemCount: calendarProvider.monthsShifts.length,
              // onPageChanged: (pageIndex) {
              //   calendarProvider.setCurrentMonthVacations(calendarProvider.monthsShifts[pageIndex].vacationStatistics!);
              // },
              itemBuilder: (BuildContext context, int index) {
                MonthModel _month = calendarProvider.monthsShifts[index];

                return
                  // _calendarInfo == null?
                  // Center(child: Padding(
                  //   padding: const EdgeInsets.only(top: 50),
                  //   child: LoadingAnimationWidget.inkDrop(
                  //     color: Theme.of(context).primaryColor,
                  //     size: 30,
                  //   ),
                  // )):
                  Stack(
                    children: [
                      Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 5),

                       //   Text('${_calendarInfo!.extraordinariesAmountSum}'),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              const SizedBox(width: 12),

                              Text('${_month.name}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22,
                                      fontWeight: FontWeight.w500)),

                              const Spacer(),

                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext? context) {
                                      return AlertDialog(
                                        backgroundColor: ColorResources.BG_SECONDRY,
                                        title: Text("ore di straordinario", style: TextStyle(color: Theme.of(context!).primaryColor, fontSize: 15)),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [

                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(Icons.calendar_month, color: Colors.white60),
                                                      const SizedBox(width: 10),
                                                      Text("${DateConverter.hoursConverter(_month.monthStatistics!.hours!)}",
                                                          style: TextStyle(color: Colors.white, fontSize: 16)),

                                                    ],
                                                  ),
                                                  const Padding(
                                                    padding: const EdgeInsets.only(top: 7, bottom: 7),
                                                    child: Divider(color: Colors.white),
                                                  ),

                                                  Row(
                                                    children: [
                                                      Icon(Icons.money, color: Colors.white60),
                                                      const SizedBox(width: 10),
                                                      Text("${AppConstants.CURRENCY}${_month.monthStatistics!.eurosAmount!}",
                                                          style: TextStyle(color: Colors.white, fontSize: 16)),

                                                    ],
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                    border: Border.all(color: Colors.white24,
                                        width: 0.7),
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 7),
                                      const Icon(Icons.access_time_sharp, color: Colors.white, size: 16),
                                      const SizedBox(width: 5),

                                      _month.monthStatistics!=null?
                                      Text('${DateConverter.hoursConverter(_month.monthStatistics!.hours!)}',
                                          style: TextStyle(color: Colors.white, fontSize: 13)):
                                      const SizedBox(),
                                      // _month.monthStatistics!=null?
                                      // Text('${AppConstants.CURRENCY}${_month.monthStatistics!.eurosAmount!}',
                                      //     style: TextStyle(color: Colors.white, fontSize: 15)):
                                      // const SizedBox(),

                                      const SizedBox(width: 7),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10),

                              InkWell(
                                onTap:(){
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext? context) {
                                      return AlertDialog(
                                        backgroundColor: ColorResources.BG_SECONDRY,
                                        title: Text("ferie/ore di assenza rimanenti", style: TextStyle(color: Theme.of(context!).primaryColor, fontSize: 15)),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if(_month.vacationStatistics!.length >0)
                                            for(int i = 0; i < _month.vacationStatistics!.length ; i++)
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("${_month.vacationStatistics![i]['name']}: ",
                                                          style: TextStyle(color: Colors.white, fontSize: 16)),
                                                      const SizedBox(width: 10),
                                                      Text("${_month.vacationStatistics![i]['count']}",
                                                          style: TextStyle(color: Colors.white, fontSize: 16))
                                                    ],
                                                  ),

                                                  i != _month.vacationStatistics!.length -1?
                                                  const Padding(
                                                    padding: const EdgeInsets.only(top: 7, bottom: 7),
                                                    child: Divider(color: Colors.white),
                                                  ): const SizedBox()
                                                ],
                                              )else
                                              Text("Non hai ferie assenze questo mese",
                                                  style: TextStyle(color: Colors.white, fontSize: 14))
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                    border: Border.all(color: Colors.white24,
                                        width: 0.7),
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 15),
                                      const Icon(Icons.beach_access, color: Colors.white, size: 16),
                                      const SizedBox(width: 15),

                                      // _month.monthStatistics!=null?
                                      // Text('${DateConverter.hoursConverter(_month.monthStatistics!.hours!)}',
                                      //     style: TextStyle(color: Colors.white, fontSize: 13)):
                                      // const SizedBox(),
                                      // // _month.monthStatistics!=null?
                                      // // Text('${AppConstants.CURRENCY}${_month.monthStatistics!.eurosAmount!}',
                                      // //     style: TextStyle(color: Colors.white, fontSize: 15)):
                                      // // const SizedBox(),
                                      //
                                      // const SizedBox(width: 7),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              InkWell(
                                onTap:(){
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext? context) {
                                      return AlertDialog(
                                        backgroundColor: ColorResources.BG_SECONDRY,
                                        title: Text("ore lavorate (in questo mese)",
                                            style: TextStyle(color: Theme.of(context!).primaryColor, fontSize: 15)),
                                        content: Row(
                                          children: [
                                            Icon(Icons.alarm, color: Colors.white60, size: 16),
                                            const SizedBox(width: 8),

                                            _month.monthStatistics!=null?
                                            Text('${_month.workedHours!}',
                                                style: TextStyle(color: Colors.white, fontSize: 13)):
                                            const SizedBox(),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                    border: Border.all(color: Colors.white24,
                                        width: 0.7),
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 15),
                                      const Icon(Icons.alarm, color: Colors.white, size: 16),
                                      const SizedBox(width: 15),

                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                            ],
                          ),

                          const SizedBox(height: 10),

                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20.0))),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  /// DAYS

                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.1,
                                    child: GridView.builder(
                                      padding: const EdgeInsets.only(top: 0),
                                      physics: const NeverScrollableScrollPhysics(),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 7, // 7 items in each row
                                        childAspectRatio: 0.55,
                                        mainAxisSpacing: 0,
                                        crossAxisSpacing: 0,
                                      ),
                                      itemCount: calendarProvider.daysList.length, // Total number of items
                                      itemBuilder: (context, i) {
                                        String _dayName = '';
                                        if(calendarProvider.daysList[i] == 'Sun'){
                                          _dayName = 'D';
                                        }else if(calendarProvider.daysList[i] == 'Mon'){
                                          _dayName = 'L';
                                        }
                                        else if(calendarProvider.daysList[i] == 'Tue'){
                                          _dayName = 'M';
                                        }
                                        else if(calendarProvider.daysList[i] == 'Wed'){
                                          _dayName = 'M';
                                        }
                                        else if(calendarProvider.daysList[i] == 'Thu'){
                                          _dayName = 'G';
                                        }
                                        else if(calendarProvider.daysList[i] == 'Fri'){
                                          _dayName = 'V';
                                        }
                                        else if(calendarProvider.daysList[i] == 'Sat'){
                                          _dayName = 'S';
                                        }
                                        return Container(
                                          // color: Colors.blueAccent,
                                          child: Center(
                                            child: Text('${_dayName}',
                                                style: const TextStyle(fontSize: 20, color: Colors.black54)),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.60,
                                    child: GridView.builder(
                                      padding: const EdgeInsets.only(top: 5),
                                      physics: const NeverScrollableScrollPhysics(),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 7, // 7 items in each row
                                          childAspectRatio: 0.55,
                                        mainAxisSpacing: 0,
                                        crossAxisSpacing: 0,
                                      ),
                                      itemCount: calendarProvider.monthsShifts[index].days!.length, // Total number of items
                                      itemBuilder: (context, i) {
                                        bool _isSelectedDay = false;
                                        if(calendarProvider.selectedDay.year == _month.year!
                                            && calendarProvider.selectedDay.month == DateConverter.getMonthNumber(_month.name!)
                                        && calendarProvider.selectedDay.day ==  i + 1){
                                          _isSelectedDay = true;
                                        }
                                        DayModel _dayInfo = calendarProvider.monthsShifts[index].days![i];
                                        DateTime _currentDayDate = DateTime(
                                            _month.year!,
                                            DateConverter.getMonthNumber(_month.name!),
                                            i + 1,
                                            0,
                                            0
                                        );
                                        return InkWell(
                                          onTap: () async {
                                            DateTime _selectedDate = DateTime(
                                                _month.year!,
                                                DateConverter.getMonthNumber(_month.name!),
                                                i + 1,
                                                0,
                                                0
                                            );
                                             calendarProvider.setSelectedDate(_selectedDate);
                                            calendarProvider.updateBottomIntervalsVisibility(false);

                                            showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                backgroundColor: ColorResources.BG_SECONDRY,
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        showModalBottomSheet(
                                                          context: context,
                                                          isScrollControlled: true,
                                                          backgroundColor: Colors.transparent,
                                                          builder: (con) {
                                                            return CalendarBottomSheet(shifts: _dayInfo.calendarShifts,
                                                                date: _currentDayDate);
                                                          },
                                                        );
                                                      },
                                                      child: const Row(
                                                        children: [
                                                          Text('Shift', style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w500
                                                          )),

                                                          Spacer(),

                                                          Icon(Icons.document_scanner_rounded, size: 20, color: Colors.white70)
                                                        ],
                                                      ),
                                                    ),

                                                    const Padding(
                                                      padding:  EdgeInsets.only(top: 7, bottom: 7),
                                                      child: Divider(),
                                                    ),

                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        showModalBottomSheet(
                                                          context: context,
                                                          isScrollControlled: true,
                                                          backgroundColor: Colors.transparent,
                                                          builder: (con) {
                                                            return VacationsListBottomSheet(date: _currentDayDate);
                                                          },
                                                        );
                                                      },
                                                      child: const Row(
                                                        children: [
                                                          Text('Vacation', style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w500
                                                          )),

                                                          Spacer(),

                                                          Icon(Icons.sports_baseball, size: 20, color: Colors.white70)
                                                        ],
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color:i>27? Colors.white: Colors.black26,
                                                  width: i>27? 0: 0.5,
                                                ),
                                              ),
                                            ),
                                            margin: const EdgeInsets.all(0),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 2, right: 2),
                                                child: Column(
                                                  children: [
                                                    const SizedBox(height: 3),

                                                    !_isSelectedDay?
                                                    Text('${i + 1}', style: const TextStyle(
                                                        color: Colors.black54,
                                                    fontWeight: FontWeight.bold, fontSize: 13)):

                                                    Container(
                                                      width: 35,
                                                      decoration: const BoxDecoration(
                                                        color: Colors.black87,
                                                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                      ),
                                                      child: Center(
                                                        child: Text('${i + 1}', style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold, fontSize: 13)),
                                                      ),
                                                    ),

                                                    const SizedBox(height: 3),

                                                  ListView.builder(
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: _dayInfo.calendarShifts!.length,
                                                      itemBuilder: (context, d) {
                                                        IntervalModel _interval = _dayInfo.calendarShifts![d].interval!;
                                                        Color? _color;
                                                        _color =  _interval.iconColor!=null? Color(int.parse(_interval.iconColor!)): Colors.blueAccent;
                                                        return
                                                          d<3?
                                                          Padding(
                                                          padding: const EdgeInsets.only(top: 2, bottom: 2, left: 1, right: 1),
                                                          child: Container(
                                                              width: 52,
                                                              height: 19,
                                                              decoration: BoxDecoration(
                                                                color: _color,
                                                                borderRadius: BorderRadius.circular(5),
                                                              ),
                                                              child: Center(child: SizedBox(
                                                                  width: 43,
                                                                  child: Text('${_interval.name}',
                                                                    style: TextStyle(color: Colors.white),
                                                                    overflow: TextOverflow.ellipsis,
                                                                    textAlign: TextAlign.center,
                                                                    maxLines: 1,
                                                                  )))),
                                                        ): const SizedBox();
                                                      }),

                                                    ListView.builder(
                                                        physics: const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount: _dayInfo.calendarVacations!.length,
                                                        itemBuilder: (context, e) {
                                                          VacationModel _vacation = _dayInfo.calendarVacations![e].vacation!;

                                                          return
                                                            e<3?
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 2, bottom: 2, left: 1, right: 1),
                                                              child: Container(
                                                                  width: 52,
                                                                  height: 19,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.orange,
                                                                    borderRadius: BorderRadius.circular(5),
                                                                  ),
                                                                  child: Center(child: SizedBox(
                                                                      width: 43,
                                                                      child: Text('${_vacation.name}',
                                                                        style: TextStyle(color: Colors.white),
                                                                        overflow: TextOverflow.ellipsis,
                                                                        textAlign: TextAlign.center,
                                                                        maxLines: 1,
                                                                      )))),
                                                            ): const SizedBox();
                                                        })

                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                ),
                    ],
                  );
              },
            ),
          );
        });
  }
}

class DynamicHeightDialog extends StatelessWidget {
  final List<CalendarShiftModel>? shifts;
  final DateTime? date;
  DynamicHeightDialog({@required this.shifts, @required this.date});
  @override
  Widget build(BuildContext context) {
    FocusNode _shiftNameFocus = FocusNode();
    TextEditingController? _shiftNameController = TextEditingController();

    // void _openShiftScreen()  {
    //   Provider.of<ShiftsProvider>(context, listen: false).setShiftName(_shiftNameController.text);
    //   Provider.of<ShiftsProvider>(context, listen: false).getShiftsIntervals(context, Provider.of<ShiftsProvider>(context, listen: false).shiftId!);
    //   Provider.of<ShiftsProvider>(context, listen: false).initPageOne();
    //
    //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
    //       AddShiftScreen(shiftId: Provider.of<ShiftsProvider>(context!, listen: false).shiftId, shiftName: _shiftNameController.text, isNewShift: true)));
    // }

    void _newShift() async {
      ResponseModel _response = await Provider.of<ShiftsProvider>(context, listen: false).addNewShift(context, _shiftNameController!.text.trim());

     // Navigator.pop(context); // when i add this line to hide dialog after tappin on it error shows  At this point the state of the widget's element tree is no longer stable.
      if(_response.isSuccess){
        Provider.of<ShiftsProvider>(context, listen: false).setShiftName(_shiftNameController.text);
        Provider.of<ShiftsProvider>(context, listen: false).getShiftsIntervals(context, Provider.of<ShiftsProvider>(context, listen: false).shiftId!);
        Provider.of<ShiftsProvider>(context, listen: false).initPageOne();

        Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
            AddShiftScreen(shiftId: Provider.of<ShiftsProvider>(context!, listen: false).shiftId, shiftName: _shiftNameController.text, isNewShift: true)));
      }
    }

    void _createShiftDialog() {

      showDialog(
        context: context, // i want to create another cobtext here
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                maxLength: 200,
                hintText: 'Nome del turno',
                isShowBorder: true,
                inputType: TextInputType.text,
                inputAction: TextInputAction.next,
                focusNode: _shiftNameFocus,
                controller: _shiftNameController,
                // isIcon: true,
              )
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
              child: CustomButton(btnTxt: 'Confermare',
                onTap: () {
                  if(_shiftNameController.text.isEmpty){
                    showCustomSnackBar('il campo del nome è vuoto', context);
                  }else{

                    _newShift();
                  }
                },
              ),
            )
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
          ),
        ),
      );
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child:
      Provider.of<ShiftsProvider>(context, listen: false).shiftsList.isEmpty?
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30),
          const Text('You didn\'t create shifts yet', style: TextStyle(fontSize: 15)),

          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 30),
            child: CustomButton(btnTxt: 'Create new shift +',
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextField(
                            maxLength: 200,
                            hintText: 'Nome del turno',
                            isShowBorder: true,
                            inputType: TextInputType.text,
                            inputAction: TextInputAction.next,
                            focusNode: _shiftNameFocus,
                            controller: _shiftNameController,
                            // isIcon: true,
                          )
                        ],
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                          child: CustomButton(btnTxt: 'Confermare',
                            onTap: () async {
                              if(_shiftNameController.text.isEmpty){
                                showCustomSnackBar('il campo del nome è vuoto', context);
                              }else{
                                ResponseModel _response = await  Provider.of<ShiftsProvider>(context, listen: false).addNewShift(context, _shiftNameController.text.trim());
                                if(_response.isSuccess){
                                  _newShift();
                                }
                              }
                            },
                          ),
                        )
                      ],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                      ),
                    ),
                  );
                }),
          ),
        ],
      ):
      // intervals!.length == 0?
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     const SizedBox(height: 30),
      //     Text('You didn\'t add shift intervals yet', style: TextStyle(fontSize: 15)),
      //
      //     Padding(
      //       padding: const EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 30),
      //       child: CustomButton(btnTxt: 'Add intervals +',
      //           onTap: (){
      //             Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
      //                 ShiftsScreen()));
      //           }),
      //     )
      //   ],
      // ):

      Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Text('Dialog Content'),
            SizedBox(height: 10),
            // Use a function to calculate the total height of the ListView.builder
            Container(
              height: calculateListViewHeight(context, itemCount: shifts!.length),
              child:
              shifts!.length>0?
              ListView.builder(
                shrinkWrap: true,
                itemCount: shifts!.length,
                itemBuilder: (BuildContext context, int index) {
                  IntervalModel interval =  shifts![index].interval!;

                  IconData? _icon;
                  String? _iconName;

                  if(interval.iconName != null){
                    Helpers.iconsList().forEach((element) {
                      if(element['name'] == interval.iconName){
                        _icon = element['icon'];
                        _iconName = element['name'];
                      }
                    });
                  }else {
                    _icon = Icons.sunny;
                    _iconName = 'sunny';
                  }

                  Color? _iconColor;
                  if(interval.iconColor != null){
                    _iconColor = Color(int.parse(interval.iconColor!));
                  }else {
                    _iconColor = const Color(0xFF285bd7);
                  }

                  Color? finalColor;
                  String colorValue = _iconColor.value.toRadixString(16);
                  String colorHex = '0xFF${colorValue.substring(2)}';
                  finalColor = Color(int.parse(colorHex));

                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          // Provider.of<SavedShiftProvider>(context, listen: false).resetValues();
                          //
                          // Provider.of<SavedShiftProvider>(context, listen: false).initInterval(
                          //   interval.title!=null? interval.title!: '',
                          //   interval.iconName!=null? interval.iconName!: 'sunny',
                          //   interval.iconColor!=null? Color(int.parse(interval.iconColor!)): Colors.blueAccent,
                          //   interval.foodStamp == 1? true: false,
                          //   interval.services !=null? interval.services! : [],
                          //   interval.breaks !=null? interval.breaks! : [],
                          //   interval.allowances !=null? interval.allowances! : [],
                          //   interval.extraordinaries !=null? interval.extraordinaries! : [],
                          // );
                          // Provider.of<SavedShiftProvider>(context, listen: false).resetIcon();
                          // Navigator.pop(context);
                          // Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
                          //     EditIntervalScreen(interval: interval)));

                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (con) {
                              return ShiftDetailsBottomSheet(interval: interval);
                            },
                          );

                        },
                        child: Row(
                          children: [
                            Icon(_icon, color: finalColor),
                            const SizedBox(width: 15),
                            Text('${interval.name}', style: TextStyle(
                                color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 18)),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(),
                      ),

                    ],
                  );
                },
              ): const SizedBox(),
            ),

            const SizedBox(height: 10),

            InkWell(
              onTap: () {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (con) {
                    return ShiftsBottomSheet();
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Add Shift +', style: TextStyle(color: Theme.of(context).primaryColor,
                      fontSize: 15, fontWeight: FontWeight.w500)),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  double calculateListViewHeight(BuildContext context, {required int itemCount}) {
    // Calculate the total height of the ListView.builder items
    double itemHeight = 50.0; // Change this to the average height of your items
    double totalHeight = itemHeight * itemCount;

    // Add extra padding or adjust as needed
    double padding = 20.0;

    // Ensure the calculated height is not greater than the screen height
    double screenHeight = MediaQuery.of(context).size.height;
    return totalHeight > screenHeight ? screenHeight - padding : totalHeight + padding;
  }
}

// class DynamicShiftsDialog extends StatelessWidget {
//   final DateTime? date;
//   DynamicShiftsDialog({@required this.date});
//   @override
//   Widget build(BuildContext context) {
//     void closeDialog(){
//       Navigator.pop(context);
//     }
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       child:
//       Consumer<ShiftsProvider>(
//           builder: (context, shiftsProvider, child) {
//
//             return Container(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   //Text('Dialog Content'),
//                   const SizedBox(height: 10),
//                   // Use a function to calculate the total height of the ListView.builder
//                   shiftsProvider.shiftsList.length == 0?
//                       Column(
//                         children: [
//                           Text('Non hai ancora creato turni', style: TextStyle(fontSize: 15)),
//
//                           Padding(
//                             padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
//                             child: CustomButton(btnTxt: 'Crea nuovo turno +',
//                             onTap: (){
//                               Navigator.pop(context);
//                               Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
//                                   ShiftsScreen()));
//                             }),
//                           )
//                         ],
//                       ):
//                   Container(
//                     height: 350,
//                     child: ListView.builder(
//                       itemCount: shiftsProvider.shiftsList.length,
//                       physics: const ScrollPhysics(),
//                       shrinkWrap: true,
//                       itemBuilder: (context, index) {
//                         ShiftModel _shift = shiftsProvider.shiftsList[index];
//                         return
//                           Padding(
//                             padding: EdgeInsets.only(bottom: 8, top: index == 0? 12: 0),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
//                                       child: InkWell(
//                                         onTap:(){
//                                           if(_shift.intervals!.isEmpty){
//                                             showDialog(
//                                               context: context,
//                                               builder: (_) => AlertDialog(
//                                                 content: Text('Dovresti prima aggiungere intervalli a questo turno!'),
//                                                 actions: [
//                                                   Padding(
//                                                     padding: const EdgeInsets.only(bottom: 15, right: 30, left: 30),
//                                                     child: CustomButton(btnTxt: 'Aggiungi intervalli +', onTap: () {
//                                                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
//                                                           EditShiftScreen(shift: _shift))).then((value) => closeDialog());
//                                                     }),
//                                                   )
//
//                                                 ],
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
//                                                 ),
//                                               ),
//                                             );
//                                           }else{
//                                             Provider.of<CalendarProvider>(context, listen: false).addLocalCalendarShifts(_shift);
//                                             shiftsProvider.addShiftToCalendar(context, _shift.id!,
//                                                 Provider.of<CalendarProvider>(context, listen: false).selectedDay!.toString()).then((value) {
//                                               getCalendarShifts(context);
//                                               Navigator.pop(context);
//                                             });
//                                           }
//
//                                         },
//                                         child: Container(
//                                           height: 60,
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.circular(12),
//                                             boxShadow: [BoxShadow(
//                                               color: Colors.grey[200]!,
//                                               blurRadius: 5, spreadRadius: 2,
//                                             )],
//                                           ),
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               mainAxisAlignment: MainAxisAlignment.center,
//                                               children: [
//
//                                                 Row(
//                                                   children: [
//                                                     Text('${_shift.shiftName}' ,
//                                                         maxLines: 2,
//                                                         overflow: TextOverflow.ellipsis,
//                                                         style: const TextStyle(
//                                                             color: Colors.black87,
//                                                             fontSize: 16,
//                                                             fontWeight: FontWeight.w500
//                                                         )),
//
//                                                     const Spacer(),
//                                                     const Icon(Icons.add, size: 25),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                 ),
//                               ],
//                             ),
//                           );
//                       },
//                     ),
//                   ),
//                    SizedBox(height: shiftsProvider.shiftsList.length == 0?10: 20)
//                 ],
//               ),
//             );
//           })
//     );
//   }
//
//   double calculateListViewHeight(BuildContext context, {required int itemCount}) {
//     // Calculate the total height of the ListView.builder items
//     double itemHeight = 50.0; // Change this to the average height of your items
//     double totalHeight = itemHeight * itemCount;
//
//     // Add extra padding or adjust as needed
//     double padding = 20.0;
//
//     // Ensure the calculated height is not greater than the screen height
//     double screenHeight = MediaQuery.of(context).size.height;
//     return totalHeight > screenHeight ? screenHeight - padding : totalHeight + padding;
//   }
//
//   void getCalendarShifts(BuildContext context){
//     Provider.of<CalendarProvider>(context, listen: false).getCalendarShifts(context);
//   }
// }


