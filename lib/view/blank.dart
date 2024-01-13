// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:provider/provider.dart';
// import 'package:turnarix/data/helper/helpers.dart';
// import 'package:turnarix/data/model/response/response_model.dart';
// import 'package:turnarix/data/model/shifts/calendar_shift_model.dart';
// import 'package:turnarix/data/model/shifts/intervals_model.dart';
// import 'package:turnarix/data/model/shifts/shift_model.dart';
// import 'package:turnarix/provider/calendar_provider.dart';
// import 'package:turnarix/provider/saved_shift_provider.dart';
// import 'package:turnarix/provider/shifts_provider.dart';
// import 'package:turnarix/view/base/custom_button.dart';
// import 'package:turnarix/view/base/custom_snackbar.dart';
// import 'package:turnarix/view/base/custom_text_field.dart';
// import 'package:turnarix/view/screens/shifts/add_shift_screen.dart';
// import 'package:turnarix/view/screens/shifts/saved_shift/edit_interval_screen.dart';
// import 'package:turnarix/view/screens/shifts/saved_shift/edit_shift_screen.dart';
// import 'package:turnarix/view/screens/shifts/shifts_screen.dart';
//
// class CalendarScreen extends StatefulWidget {
//   @override
//   _CalendarScreenState createState() =>
//       _CalendarScreenState();
// }
//
// class _CalendarScreenState
//     extends State<CalendarScreen> {
//   final PageController _pageController = PageController();
//   int currentPage = 0;
//   ScrollController scrollController =  ScrollController();
//   @override
//   void initState() {
//     super.initState();
//
//     // Add a listener to the PageController
//     _pageController.addListener(_scrollListener);
//   }
//   void _scrollListener() {
//     // Get the current page based on the controller's offset
//     currentPage = _pageController.page?.round() ?? 0;
//
//     // DateTime firstDayOfNextMonth = DateTime(
//     //     Provider.of<CalendarProvider>(context, listen: false).selectedDatetime!.year,
//     //     Provider.of<CalendarProvider>(context, listen: false).selectedDatetime!.month + 1, 1);
//     //
//     // Provider.of<CalendarProvider>(context, listen: false).getFirstDayNameOfMonth(firstDayOfNextMonth);
//     // Provider.of<CalendarProvider>(context, listen: false).getDateInfo(firstDayOfNextMonth);
//
//     // Execute your desired function after every scroll
//     print('Scrolled to page $currentPage');
//   }
//
//
//
//   @override
//   void dispose() {
//     // Dispose of the PageController when the widget is no longer used
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CalendarProvider>(
//         builder: (context, calendarProvider, child) {
//           List<CalendarInfoModel> _calendarInfoList = calendarProvider.calendarInfoModels;
//
//           DateTime today = DateTime.now();
//           int initialPageIndex = calendarProvider.dateList!.indexWhere((date) =>
//           date.year == today.year && date.month == today.month);
//
//           PageController _pageController = PageController(initialPage: initialPageIndex);
//
//           return Scaffold(
//             backgroundColor: Theme.of(context).primaryColor.withOpacity(0.3),
//             appBar: AppBar(
//               title: const Text('',
//                   style:
//                   TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 20)),
//               centerTitle: true,
//               backgroundColor: Colors.white.withOpacity(0.0),
//               elevation: 0.0,
//               leading: IconButton(
//                 icon: const Icon(Icons.menu),
//                 color: Colors.black54,
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (_) => AlertDialog(
//                       content: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               Navigator.pop(context);
//                               // Provider.of<ShiftsProvider>(context, listen: false).clearOffset();
//                               Provider.of<ShiftsProvider>(context, listen: false).getShiftslist(context);
//                               Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
//                                   ShiftsScreen()));
//                             },
//                             child: const Row(
//                               children: [
//                                 Text('Sezione Turni', style: TextStyle(
//                                     color: Colors.black87,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w500
//                                 )),
//
//                                 Spacer(),
//
//                                 Icon(Icons.arrow_forward_ios_rounded, size: 20)
//                               ],
//                             ),
//                           ),
//
//                           const  Padding(
//                             padding:  EdgeInsets.only(top: 7, bottom: 7),
//                             child: Divider(),
//                           ),
//
//                           const  Row(
//                             children: [
//                               Text('indennità de servicio', style: TextStyle(
//                                   color: Colors.black87,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w500
//                               )),
//
//                               Spacer(),
//
//                               Icon(Icons.arrow_forward_ios_rounded, size: 20)
//                             ],
//                           ),
//
//                           const Padding(
//                             padding:  EdgeInsets.only(top: 7, bottom: 7),
//                             child: Divider(),
//                           ),
//
//                           const Row(
//                             children: [
//                               Text('Allarme Promemoria', style: TextStyle(
//                                   color: Colors.black87,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w500
//                               )),
//
//                               Spacer(),
//
//                               Icon(Icons.arrow_forward_ios_rounded, size: 20)
//                             ],
//                           ),
//
//                           const Padding(
//                             padding: EdgeInsets.only(top: 7, bottom: 7),
//                             child: Divider(),
//                           ),
//
//                           const  Row(
//                             children: [
//                               Text('Assenze/Altro', style: TextStyle(
//                                   color: Colors.black87,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w500
//                               )),
//
//                               Spacer(),
//
//                               Icon(Icons.arrow_forward_ios_rounded, size: 20)
//                             ],
//                           ),
//
//                           const Padding(
//                             padding: EdgeInsets.only(top: 7, bottom: 7),
//                             child: Divider(),
//                           ),
//
//                           const Row(
//                             children: [
//                               Text('Buoni Pasto', style: TextStyle(
//                                   color: Colors.black87,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w500
//                               )),
//
//                               Spacer(),
//
//                               Icon(Icons.arrow_forward_ios_rounded, size: 20)
//                             ],
//                           ),
//
//                           const Padding(
//                             padding: EdgeInsets.only(top: 7, bottom: 7),
//                             child: Divider(),
//                           ),
//
//                           const Row(
//                             children: [
//                               Text('Modifica turno di lavaro', style: TextStyle(
//                                   color: Colors.black87,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w500
//                               )),
//
//                               Spacer(),
//
//                               Icon(Icons.arrow_forward_ios_rounded, size: 20)
//                             ],
//                           ),
//
//                         ],
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               actions: [
//
//               ],
//             ),
//             floatingActionButton: FloatingActionButton(
//               backgroundColor: Theme.of(context).primaryColor,
//               onPressed: () {
//
//               },
//               tooltip: 'Edit',
//               child: const Icon(Icons.edit),
//             ),
//             body: PageView.builder(
//               controller: _pageController, // Attach the PageController
//               scrollDirection: Axis.vertical,
//               itemCount: calendarProvider.dateList!.length,
//               itemBuilder: (BuildContext context, int index) {
//
//                 final monthName = DateFormat.MMMM().format(calendarProvider.dateList![index]);
//                 String yearName = DateFormat.y().format(calendarProvider.dateList![index]);
//                 DateTime _currentMonthDate = calendarProvider.dateList![index];
//                 List<IntervalModel> _intervals = [];
//                 List<CalendarShiftModel> _shiftsList = [];
//                 List<String> _dates = [];
//
//                 CalendarInfoModel? _calendarInfo;
//                 _calendarInfoList.forEach((info) {
//                   List<String> parts =  info.month!.split(" ");
//                   String month = parts[0];
//                   String year = parts[1];
//
//                   if(month == monthName && year == yearName){
//                     print('month --> ${month} --- month -->${monthName} -- year -->${year} --- year -->${yearName}');
//                     _calendarInfo = info;
//                     info.calendarShifts!.forEach((item) {
//                       _dates.add(item.selectedDate!);
//                       _intervals.addAll(item.shift!.intervals!);
//                       _shiftsList.add(item);
//                     });
//                     print('interavlssss ---> ${jsonEncode(_dates)}');
//                   }
//                 });
//
//                 //   List<ShiftModel> _temporaryShifts = Provider.of<CalendarProvider>(context, listen: false).temporarySavedCalendarShifts;
//                 // //  List<IntervalModel>? _temporaryIntervals = [];
//                 //   _temporaryShifts.forEach((shift) {
//                 //     _intervals.addAll(shift.intervals!);
//                 //     print('add item here ${jsonEncode(_intervals)}');
//                 //   });
//
//                 return
//                   _calendarInfo == null?
//                   Center(child: Padding(
//                     padding: const EdgeInsets.only(top: 50),
//                     child: LoadingAnimationWidget.inkDrop(
//                       color: Theme.of(context).primaryColor,
//                       size: 30,
//                     ),
//                   )):
//                   Container(
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(40),
//                         topRight: Radius.circular(40),
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 5),
//
//
//                         //   Text('${_calendarInfo!.extraordinariesAmountSum}'),
//
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//
//                             const SizedBox(width: 12),
//
//                             Text('${monthName} ${calendarProvider.dateList![index].year}',
//                                 style: TextStyle(
//                                     color: Colors.black87, fontSize: 22,
//                                     fontWeight: FontWeight.w500)),
//
//                             const Spacer(),
//
//                             Container(
//                               height: 35,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                                 border: Border.all(color: Colors.black12,
//                                     width: 1),
//                               ),
//                               child: Row(
//                                 children: [
//                                   const SizedBox(width: 10),
//                                   Icon(Icons.access_time_sharp, color: Colors.black87),
//                                   const SizedBox(width: 3),
//                                   Text('${_calendarInfo!.extraordinariesAmountSum}',
//                                       style: TextStyle(color: Colors.black54, fontSize: 15)),
//                                   const SizedBox(width: 10),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(width: 15),
//                           ],
//                         ),
//
//                         const SizedBox(height: 10),
//
//                         Container(
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.all(Radius.circular(20.0))),
//                           child: SingleChildScrollView(
//                             child: Column(
//                               children: [
//                                 /// DAYS
//
//                                 SizedBox(
//                                   height: MediaQuery.of(context).size.height * 0.1,
//                                   child: GridView.builder(
//                                     padding: const EdgeInsets.only(top: 0),
//                                     physics: const NeverScrollableScrollPhysics(),
//                                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                       crossAxisCount: 7, // 7 items in each row
//                                       childAspectRatio: 0.55,
//                                       mainAxisSpacing: 0,
//                                       crossAxisSpacing: 0,
//                                     ),
//                                     itemCount: calendarProvider.daysList.length, // Total number of items
//                                     itemBuilder: (context, i) {
//                                       String _dayName = '';
//                                       if(calendarProvider.daysList[i] == 'Sun'){
//                                         _dayName = 'D';
//                                       }else if(calendarProvider.daysList[i] == 'Mon'){
//                                         _dayName = 'L';
//                                       }
//                                       else if(calendarProvider.daysList[i] == 'Tue'){
//                                         _dayName = 'M';
//                                       }
//                                       else if(calendarProvider.daysList[i] == 'Wed'){
//                                         _dayName = 'M';
//                                       }
//                                       else if(calendarProvider.daysList[i] == 'Thu'){
//                                         _dayName = 'G';
//                                       }
//                                       else if(calendarProvider.daysList[i] == 'Fri'){
//                                         _dayName = 'V';
//                                       }
//                                       else if(calendarProvider.daysList[i] == 'Sat'){
//                                         _dayName = 'S';
//                                       }
//                                       return Container(
//                                         // color: Colors.blueAccent,
//                                         child: Center(
//                                           child: Text('${_dayName}',
//                                               style: const TextStyle(fontSize: 20, color: Colors.black54)),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//
//                                 SizedBox(
//                                   height: MediaQuery.of(context).size.height * 0.60,
//                                   child: GridView.builder(
//                                     padding: const EdgeInsets.only(top: 5),
//                                     physics: const NeverScrollableScrollPhysics(),
//                                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                       crossAxisCount: 7, // 7 items in each row
//                                       childAspectRatio: 0.55,
//                                       mainAxisSpacing: 0,
//                                       crossAxisSpacing: 0,
//                                     ),
//                                     itemCount: calendarProvider.monthDaysNumber, // Total number of items
//                                     itemBuilder: (context, index) {
//
//                                       bool _isSelectedDay = false;
//                                       if(calendarProvider.selectedDay!=null){
//                                         _isSelectedDay = (calendarProvider.selectedDay!.day == index +1 &&
//                                             calendarProvider.selectedDay!.month == _currentMonthDate.month &&
//                                             calendarProvider.selectedDay!.year == _currentMonthDate.year)
//                                             ? true: false;
//                                       }
//                                       return InkWell(
//                                         onTap: () async {
//                                           DateTime _selectedDate = DateTime(
//                                               _currentMonthDate.year,
//                                               _currentMonthDate.month,
//                                               index + 1,
//                                               _currentMonthDate.hour,
//                                               _currentMonthDate.minute
//                                           );
//
//                                           calendarProvider.setSelectedDate(_selectedDate);
//
//                                           try {
//                                             CalendarShiftModel _shift = _shiftsList
//                                                 .where((item) => DateTime.parse(item.selectedDate!).day == _selectedDate.day
//                                                 && DateTime.parse(item.selectedDate!).month == _selectedDate.month && DateTime.parse(item.selectedDate!).year == _selectedDate.year)
//                                                 .first;
//
//                                             showDialog(
//                                               context: context,
//                                               builder: (BuildContext context) {
//                                                 return DynamicHeightDialog(intervals: _shift.shift!.intervals,
//                                                     shift: _shift.shift, date: _currentMonthDate);
//                                               },
//                                             );
//                                           } catch (e) {
//                                             showDialog(
//                                               context: context,
//                                               builder: (BuildContext context) {
//                                                 return DynamicHeightDialog(intervals: [], date: _currentMonthDate);
//                                               },
//                                             );
//                                           }
//                                         },
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             border: Border(
//                                               bottom: BorderSide(
//                                                 color:index>27? Colors.white: Colors.black26,
//                                                 width: index>27? 0: 0.5,
//                                               ),
//                                             ),
//                                           ),
//                                           margin: const EdgeInsets.all(0),
//                                           child: Center(
//                                             child: Padding(
//                                               padding: const EdgeInsets.only(left: 2, right: 2),
//                                               child: Column(
//                                                 children: [
//                                                   const SizedBox(height: 3),
//
//                                                   !_isSelectedDay?
//                                                   Text('${index + 1}', style: const TextStyle(
//                                                       color: Colors.black54,
//                                                       fontWeight: FontWeight.bold, fontSize: 13)):
//
//                                                   Container(
//                                                     width: 35,
//                                                     decoration: const BoxDecoration(
//                                                       color: Colors.black87,
//                                                       borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                                                     ),
//                                                     child: Center(
//                                                       child: Text('${index + 1}', style: const TextStyle(
//                                                           color: Colors.white,
//                                                           fontWeight: FontWeight.bold, fontSize: 13)),
//                                                     ),
//                                                   ),
//
//                                                   const SizedBox(height: 3),
//
//                                                   SizedBox(
//                                                     height: 60,
//                                                     child: ListView.builder(
//                                                         physics: const NeverScrollableScrollPhysics(),
//                                                         shrinkWrap: true,
//                                                         itemCount: _calendarInfo!.calendarShifts!.length,
//                                                         itemBuilder: (context, i) {
//                                                           CalendarShiftModel _calendarShift = _calendarInfo!.calendarShifts![i];
//                                                           bool _isCurrentDay = false;
//                                                           if(DateTime.parse(_calendarShift.selectedDate!).day == index + 1){
//                                                             _isCurrentDay = true;
//                                                           }
//                                                           return
//                                                             _isCurrentDay?
//
//                                                             ListView.builder(
//                                                                 physics: const NeverScrollableScrollPhysics(),
//                                                                 shrinkWrap: true,
//                                                                 itemCount: _calendarShift.shift!.intervals!.length,
//                                                                 itemBuilder: (context, d) {
//                                                                   IntervalModel _interval = _calendarShift.shift!.intervals![d];
//                                                                   Color? _color;
//                                                                   _color =  _interval.iconColor!=null? Color(int.parse(_interval.iconColor!)): Colors.blueAccent;
//                                                                   return Padding(
//                                                                     padding: const EdgeInsets.only(top: 2, bottom: 2, left: 1, right: 1),
//                                                                     child: Container(
//                                                                         width: 52,
//                                                                         height: 23,
//                                                                         decoration: BoxDecoration(
//                                                                           color: _color,
//                                                                           borderRadius: BorderRadius.circular(5),
//                                                                         ),
//                                                                         child: Center(child: SizedBox(
//                                                                             width: 43,
//                                                                             child: Text('${_interval.name}',
//                                                                               style: TextStyle(color: Colors.white),
//                                                                               overflow: TextOverflow.ellipsis,
//                                                                               maxLines: 1,
//                                                                             )))),
//                                                                   );
//                                                                 }): const SizedBox();
//
//                                                         }),
//                                                   ),
//
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//               },
//             ),
//           );
//         });
//
//   }
// }
//
// class DynamicHeightDialog extends StatelessWidget {
//   final List<IntervalModel>? intervals;
//   final ShiftModel? shift;
//   final DateTime? date;
//   DynamicHeightDialog({@required this.intervals, @required this.shift, @required this.date});
//   @override
//   Widget build(BuildContext context) {
//     FocusNode _shiftNameFocus = FocusNode();
//     TextEditingController? _shiftNameController = TextEditingController();
//
//     void _openShiftScreen()  {
//       Provider.of<ShiftsProvider>(context, listen: false).setShiftName(_shiftNameController.text);
//       Provider.of<ShiftsProvider>(context, listen: false).getShiftsIntervals(context, Provider.of<ShiftsProvider>(context, listen: false).shiftId!);
//       Provider.of<ShiftsProvider>(context, listen: false).initPageOne();
//
//       Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
//           AddShiftScreen(shiftId: Provider.of<ShiftsProvider>(context!, listen: false).shiftId, shiftName: _shiftNameController.text, isNewShift: true)));
//     }
//
//     void _newShift() async {
//       ResponseModel _response = await  Provider.of<ShiftsProvider>(context, listen: false).addNewShift(context, _shiftNameController.text.trim());
//       if(_response.isSuccess){
//         _openShiftScreen();
//       }
//     }
//
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       child:
//       Provider.of<ShiftsProvider>(context, listen: false).shiftsList.isEmpty?
//       Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const SizedBox(height: 30),
//           const Text('You didn\'t create shifts yet', style: TextStyle(fontSize: 15)),
//
//           Padding(
//             padding: const EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 30),
//             child: CustomButton(btnTxt: 'Create new shift +',
//                 onTap: (){
//
//                   showDialog(
//                     context: context,
//                     builder: (_) => AlertDialog(
//                       content: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           CustomTextField(
//                             maxLength: 200,
//                             hintText: 'Nome del turno',
//                             isShowBorder: true,
//                             inputType: TextInputType.text,
//                             inputAction: TextInputAction.next,
//                             focusNode: _shiftNameFocus,
//                             controller: _shiftNameController,
//                             // isIcon: true,
//                           )
//                         ],
//                       ),
//                       actions: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
//                           child: CustomButton(btnTxt: 'Confermare',
//                             onTap: () async {
//                               if(_shiftNameController.text.isEmpty){
//                                 showCustomSnackBar('il campo del nome è vuoto', context);
//                               }else{
//                                 ResponseModel _response = await  Provider.of<ShiftsProvider>(context, listen: false).addNewShift(context, _shiftNameController.text.trim());
//                                 if(_response.isSuccess){
//                                   _openShiftScreen();
//                                 }
//
//                               }
//                             },
//                           ),
//                         )
//                       ],
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
//                       ),
//                     ),
//                   );
//                 }),
//           ),
//         ],
//       ):
//       // intervals!.length == 0?
//       // Column(
//       //   crossAxisAlignment: CrossAxisAlignment.center,
//       //   mainAxisSize: MainAxisSize.min,
//       //   children: [
//       //     const SizedBox(height: 30),
//       //     Text('You didn\'t add shift intervals yet', style: TextStyle(fontSize: 15)),
//       //
//       //     Padding(
//       //       padding: const EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 30),
//       //       child: CustomButton(btnTxt: 'Add intervals +',
//       //           onTap: (){
//       //             Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
//       //                 ShiftsScreen()));
//       //           }),
//       //     )
//       //   ],
//       // ):
//
//       Container(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             //Text('Dialog Content'),
//             SizedBox(height: 10),
//             // Use a function to calculate the total height of the ListView.builder
//             Container(
//               height: calculateListViewHeight(context, itemCount: intervals!.length),
//               child:
//               intervals!.length>0?
//               ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: intervals!.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   IntervalModel interval =  intervals![index];
//
//                   IconData? _icon;
//                   String? _iconName;
//
//                   if(interval.iconName != null){
//                     Helpers.iconsList().forEach((element) {
//                       if(element['name'] == interval.iconName){
//                         _icon = element['icon'];
//                         _iconName = element['name'];
//                       }
//                     });
//                   }else {
//                     _icon = Icons.sunny;
//                     _iconName = 'sunny';
//                   }
//
//                   Color? _iconColor;
//                   if(interval.iconColor != null){
//                     _iconColor = Color(int.parse(interval.iconColor!));
//                   }else {
//                     _iconColor = const Color(0xFF285bd7);
//                   }
//
//                   Color? finalColor;
//                   String colorValue = _iconColor.value.toRadixString(16);
//                   String colorHex = '0xFF${colorValue.substring(2)}';
//                   finalColor = Color(int.parse(colorHex));
//
//                   return Column(
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Provider.of<SavedShiftProvider>(context, listen: false).resetValues();
//                           Provider.of<SavedShiftProvider>(context, listen: false).setSelectedShift(shift!);
//                           Provider.of<SavedShiftProvider>(context, listen: false).getIntervalsList(context, shift!.id!, true);
//
//                           Provider.of<SavedShiftProvider>(context, listen: false).initInterval(
//                             interval.title!=null? interval.title!: '',
//                             interval.iconName!=null? interval.iconName!: 'sunny',
//                             interval.iconColor!=null? Color(int.parse(interval.iconColor!)): Colors.blueAccent,
//                             interval.foodStamp == 1? true: false,
//                             interval.services !=null? interval.services! : [],
//                             interval.breaks !=null? interval.breaks! : [],
//                             interval.allowances !=null? interval.allowances! : [],
//                             interval.extraordinaries !=null? interval.extraordinaries! : [],
//                           );
//                           Provider.of<SavedShiftProvider>(context, listen: false).resetIcon();
//                           Navigator.pop(context);
//                           print('interval ID-- ${interval.services}');
//                           Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
//                               EditIntervalScreen(interval: interval)));
//                         },
//                         child: Row(
//                           children: [
//                             Icon(_icon, color: finalColor),
//                             const SizedBox(width: 15),
//                             Text('${interval.name}', style: TextStyle(
//                                 color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 18)),
//                           ],
//                         ),
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Divider(),
//                       ),
//
//                     ],
//                   );
//                 },
//               ): const SizedBox(),
//             ),
//
//             SizedBox(height: 10),
//             InkWell(
//               onTap: () {
//                 Navigator.pop(context);
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return DynamicShiftsDialog(date: date!);
//                   },
//                 );
//               },
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Add Shift +', style: TextStyle(color: Theme.of(context).primaryColor,
//                       fontSize: 15, fontWeight: FontWeight.w500))
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//
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
// }
//
// class DynamicShiftsDialog extends StatelessWidget {
//   final DateTime? date;
//   DynamicShiftsDialog({@required this.date});
//   @override
//   Widget build(BuildContext context) {
//     void closeDialog(){
//       Navigator.pop(context);
//     }
//     return Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         child:
//         Consumer<ShiftsProvider>(
//             builder: (context, shiftsProvider, child) {
//
//               return Container(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     //Text('Dialog Content'),
//                     const SizedBox(height: 10),
//                     // Use a function to calculate the total height of the ListView.builder
//                     shiftsProvider.shiftsList.length == 0?
//                     Column(
//                       children: [
//                         Text('Non hai ancora creato turni', style: TextStyle(fontSize: 15)),
//
//                         Padding(
//                           padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
//                           child: CustomButton(btnTxt: 'Crea nuovo turno +',
//                               onTap: (){
//                                 Navigator.pop(context);
//                                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
//                                     ShiftsScreen()));
//                               }),
//                         )
//                       ],
//                     ):
//                     Container(
//                       height: 350,
//                       child: ListView.builder(
//                         itemCount: shiftsProvider.shiftsList.length,
//                         physics: const ScrollPhysics(),
//                         shrinkWrap: true,
//                         itemBuilder: (context, index) {
//                           ShiftModel _shift = shiftsProvider.shiftsList[index];
//                           return
//                             Padding(
//                               padding: EdgeInsets.only(bottom: 8, top: index == 0? 12: 0),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
//                                         child: InkWell(
//                                           onTap:(){
//                                             if(_shift.intervals!.isEmpty){
//                                               showDialog(
//                                                 context: context,
//                                                 builder: (_) => AlertDialog(
//                                                   content: Text('Dovresti prima aggiungere intervalli a questo turno!'),
//                                                   actions: [
//                                                     Padding(
//                                                       padding: const EdgeInsets.only(bottom: 15, right: 30, left: 30),
//                                                       child: CustomButton(btnTxt: 'Aggiungi intervalli +', onTap: () {
//                                                         Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
//                                                             EditShiftScreen(shift: _shift))).then((value) => closeDialog());
//                                                       }),
//                                                     )
//
//                                                   ],
//                                                   shape: RoundedRectangleBorder(
//                                                     borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
//                                                   ),
//                                                 ),
//                                               );
//                                             }else{
//                                               Provider.of<CalendarProvider>(context, listen: false).addLocalCalendarShifts(_shift);
//                                               shiftsProvider.addShiftToCalendar(context, _shift.id!,
//                                                   Provider.of<CalendarProvider>(context, listen: false).selectedDay!.toString()).then((value) {
//                                                 getCalendarShifts(context);
//                                                 Navigator.pop(context);
//                                               });
//                                             }
//
//                                           },
//                                           child: Container(
//                                             height: 60,
//                                             decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius: BorderRadius.circular(12),
//                                               boxShadow: [BoxShadow(
//                                                 color: Colors.grey[200]!,
//                                                 blurRadius: 5, spreadRadius: 2,
//                                               )],
//                                             ),
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(8.0),
//                                               child: Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                 children: [
//
//                                                   Row(
//                                                     children: [
//                                                       Text('${_shift.shiftName}' ,
//                                                           maxLines: 2,
//                                                           overflow: TextOverflow.ellipsis,
//                                                           style: const TextStyle(
//                                                               color: Colors.black87,
//                                                               fontSize: 16,
//                                                               fontWeight: FontWeight.w500
//                                                           )),
//
//                                                       const Spacer(),
//                                                       const Icon(Icons.add, size: 25),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                   ),
//                                 ],
//                               ),
//                             );
//                         },
//                       ),
//                     ),
//                     SizedBox(height: shiftsProvider.shiftsList.length == 0?10: 20)
//                   ],
//                 ),
//               );
//             })
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
//
//
