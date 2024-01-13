// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:turnarix/provider/calendar_provider.dart';
// import 'package:turnarix/view/screens/calendar/calendar_screen.dart';
// import 'package:turnarix/view/screens/shifts/shifts_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   final bool? fromMenu;
//   HomeScreen({@required this.fromMenu});
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   @override
//   void initState() {
//     super.initState();
//
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext? context) {
//
//     return
//       Consumer<CalendarProvider>(
//         builder: (context, calendarProvider, child){
//           return Scaffold(
//             backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
//             // appBar: AppBar(
//             //   backgroundColor: Colors.white,
//             //   elevation: 0.4,
//             //   title: Text('Turnarix', style: TextStyle(color: Colors.black87, fontSize: 18)),
//             //   leading: Padding(
//             //     padding: const EdgeInsets.only(left: 10),
//             //     child: Image.asset(Images.main_logo, color: Theme.of(context).primaryColor),
//             //   ),
//             //   centerTitle: true,
//             // ),
//             body:
//             Center(
//               child: Container(
//                 width: 1170,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//
//                     const SizedBox(height: 60),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         const SizedBox(width: 15),
//                         InkWell(
//                           onTap: (){
//                             calendarProvider.setCalendarType('today');
//                           },
//                           child: Container(
//                             height: 50,
//                             width: 120,
//                             decoration: BoxDecoration(
//                               color: calendarProvider.typeSelected == 'today'? Colors.black87 : Colors.white,
//                               borderRadius: BorderRadius.circular(30),
//                               border: Border.all(color: Colors.black12,
//                                   width: calendarProvider.typeSelected == 'today'? 0 : 1),
//                             ),
//                             child: Center(
//                               child: Text('Today', style: TextStyle(
//                                   color: calendarProvider.typeSelected == 'today'?
//                                   Colors.white : Colors.black87, fontWeight: FontWeight.w500, fontSize: 18)),
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(width: 10),
//
//                         InkWell(
//                           onTap: (){
//                             calendarProvider.initCalendar();
//                             Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
//                                 CalendarScreen()));
//                             calendarProvider.setCalendarType('calendar');
//                           },
//                           child: Container(
//                             height: 50,
//                             width: 120,
//                             decoration: BoxDecoration(
//                               color: calendarProvider.typeSelected == 'calendar'? Colors.black87 : Colors.white,
//                               borderRadius: BorderRadius.circular(30),
//                               border: Border.all(color: Colors.black12,
//                                   width: calendarProvider.typeSelected == 'calendar'? 0 : 1),
//                             ),
//                             child: Center(
//                               child: Text('Calendar', style: TextStyle(
//                                   color: calendarProvider.typeSelected == 'calendar'?
//                                   Colors.white : Colors.black87, fontWeight: FontWeight.w500, fontSize: 18)),
//                             ),
//                           ),
//                         ),
//
//                         const Spacer(),
//
//                         InkWell(
//                           onTap: (){
//                             showDialog(
//                               context: context,
//                               builder: (_) => AlertDialog(
//                                 content: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     InkWell(
//                                       onTap: () {
//                                         Navigator.pop(context);
//                                         Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
//                                             ShiftsScreen()));
//                                       },
//                                       child: Row(
//                                         children: [
//                                           Text('Sezione Turni', style: TextStyle(
//                                             color: Colors.black87,
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w500
//                                           )),
//
//                                           const Spacer(),
//
//                                           Icon(Icons.arrow_forward_ios_rounded, size: 20)
//                                         ],
//                                       ),
//                                     ),
//
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 7, bottom: 7),
//                                       child: Divider(),
//                                     ),
//
//                                     Row(
//                                       children: [
//                                         Text('indennità de servicio', style: TextStyle(
//                                             color: Colors.black87,
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w500
//                                         )),
//
//                                         const Spacer(),
//
//                                         Icon(Icons.arrow_forward_ios_rounded, size: 20)
//                                       ],
//                                     ),
//
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 7, bottom: 7),
//                                       child: Divider(),
//                                     ),
//
//                                     Row(
//                                       children: [
//                                         Text('Allarme Promemoria', style: TextStyle(
//                                             color: Colors.black87,
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w500
//                                         )),
//
//                                         const Spacer(),
//
//                                         Icon(Icons.arrow_forward_ios_rounded, size: 20)
//                                       ],
//                                     ),
//
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 7, bottom: 7),
//                                       child: Divider(),
//                                     ),
//
//                                     Row(
//                                       children: [
//                                         Text('Assenze/Altro', style: TextStyle(
//                                             color: Colors.black87,
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w500
//                                         )),
//
//                                         const Spacer(),
//
//                                         Icon(Icons.arrow_forward_ios_rounded, size: 20)
//                                       ],
//                                     ),
//
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 7, bottom: 7),
//                                       child: Divider(),
//                                     ),
//
//                                     Row(
//                                       children: [
//                                         Text('Buoni Pasto', style: TextStyle(
//                                             color: Colors.black87,
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w500
//                                         )),
//
//                                         const Spacer(),
//
//                                         Icon(Icons.arrow_forward_ios_rounded, size: 20)
//                                       ],
//                                     ),
//
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 7, bottom: 7),
//                                       child: Divider(),
//                                     ),
//
//                                     Row(
//                                       children: [
//                                         Text('Modifica turno di lavaro', style: TextStyle(
//                                             color: Colors.black87,
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w500
//                                         )),
//
//                                         const Spacer(),
//
//                                         Icon(Icons.arrow_forward_ios_rounded, size: 20)
//                                       ],
//                                     ),
//
//                                   ],
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             height: 50,
//                             width: 50,
//                             decoration: BoxDecoration(
//                               color: Theme.of(context).primaryColor.withOpacity(0.4),
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             child: Center(
//                               child: Icon(Icons.add, color: Colors.black87),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                       ],
//                     ),
//
//                     const SizedBox(height: 30),
//
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(40),
//                           topRight: Radius.circular(40),
//                         ),
//                       ),
//                       child: Column(
//                         children: [
//                           const SizedBox(height: 20),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const SizedBox(width: 12),
//                               InkWell(
//                                   onTap: () {
//                                     DateTime firstDayOfNextMonth = DateTime(calendarProvider.selectedDatetime!.year,
//                                         calendarProvider.selectedDatetime!.month - 1, 1);
//                                     calendarProvider.getFirstDayNameOfMonth(firstDayOfNextMonth);
//                                     calendarProvider.getDateInfo(firstDayOfNextMonth);
//                                   },
//                                   child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black54)),
//
//                               const Spacer(),
//
//                               Text('${calendarProvider.monthName} ${calendarProvider.year}',
//                                   style: TextStyle(
//                                       color: Colors.black87, fontSize: 22,
//                                       fontWeight: FontWeight.w500)),
//
//                               const Spacer(),
//
//                               InkWell(
//                                   onTap: () {
//                                     DateTime firstDayOfNextMonth = DateTime(calendarProvider.selectedDatetime!.year,
//                                         calendarProvider.selectedDatetime!.month + 1, 1);
//                                     calendarProvider.getFirstDayNameOfMonth(firstDayOfNextMonth);
//                                     calendarProvider.getDateInfo(firstDayOfNextMonth);
//                                   },
//                                   child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54)),
//                               const SizedBox(width: 12),
//                             ],
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.07,
//                             child:
//                             Center(
//                                 child:
//                                 GridView.extent(
//                                   primary: false,
//                                   crossAxisSpacing: 0,
//                                   mainAxisSpacing: 0,
//                                   maxCrossAxisExtent: 60.0,
//                                   childAspectRatio: (1 / 1.5),
//                                   padding: const EdgeInsets.only(left: 4, right: 4),
//                                   children: <Widget>[
//                                     for(int i = 0; i <  calendarProvider.daysList.length ; i++)
//                                       Container(
//                                         height: 30,
//                                         width: 30,
//                                         child: Center(
//                                           child: Text('${calendarProvider.daysList[i]}',
//                                               style: const TextStyle(fontSize: 20, color: Colors.black54)),
//                                         ),
//                                       ),
//                                   ],
//                                 )
//                             ),
//                           ),
//
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.65,
//                             child:
//                             Center(
//                                 child:
//                                 GridView.extent(
//                                   primary: false,
//                                   crossAxisSpacing: 0,
//                                   mainAxisSpacing: 0,
//                                   maxCrossAxisExtent: 60.0,
//                                   childAspectRatio: (1 / 2),
//                                   padding: const EdgeInsets.only(left: 4, right: 4),
//                                   children: <Widget>[
//                                     for(int i = 0; i <  calendarProvider.monthDaysNumber! ; i++)
//                                       i < 0?
//                                       const SizedBox() :
//
//                                       Container(
//                                           height: 200,
//                                           width: 30,
//                                           decoration: BoxDecoration(
//                                             border: Border.all(color: Colors.black12, width: 0.5),
//                                           ),
//                                           child: SingleChildScrollView(
//                                             child: Column(
//                                               children: [
//                                                 Align(
//                                                     alignment:Alignment.topLeft,
//                                                     child: Padding(
//                                                       padding: const EdgeInsets.only(left: 4),
//                                                       child: Text('${i + 1}',
//                                                           style: TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.8))),
//                                                     )),
//
//                                                 i == 2 || i == 16 || i == 27 ?
//                                                 Container(
//                                                   width: 47,
//                                                   height: 25,
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.blue,
//                                                     borderRadius: BorderRadius.circular(10),
//                                                   ),
//                                                   child: Center(
//                                                     child: Text('Sera',
//                                                         style: TextStyle(fontSize: 15, color: Colors.white)),
//                                                   ),
//                                                 ): SizedBox(),
//
//                                                 const SizedBox(height: 8),
//
//                                                 i == 2 || i == 8 || i == 11 ?
//                                                 Container(
//                                                   width: 47,
//                                                   height: 25,
//                                                   decoration: BoxDecoration(
//                                                     color: Theme.of(context).primaryColor,
//                                                     borderRadius: BorderRadius.circular(10),
//                                                   ),
//                                                   child: Center(
//                                                     child: Icon(Icons.notifications_active, color: Colors.white, size: 20),
//                                                   ),
//                                                 ): SizedBox(),
//
//                                                 const SizedBox(height: 8),
//
//                                                 i == 2 || i == 22 || i == 11 ?
//                                                 Container(
//                                                   width: 47,
//                                                   height: 25,
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.orange,
//                                                     borderRadius: BorderRadius.circular(10),
//                                                   ),
//                                                   child:  Center(
//                                                     child: Text('Stra',
//                                                         style: TextStyle(fontSize: 15, color: Colors.white)),
//                                                   ),
//                                                 ): SizedBox(),
//
//                                                 const SizedBox(height: 8),
//
//                                                 i == 2 || i == 22 || i == 11 ?
//                                                 Container(
//                                                   width: 47,
//                                                   height: 25,
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.green,
//                                                     borderRadius: BorderRadius.circular(10),
//                                                   ),
//                                                   child:  Center(
//                                                     child: Text('Nota',
//                                                         style: TextStyle(fontSize: 15, color: Colors.white)),
//                                                   ),
//                                                 ): SizedBox(),
//                                               ],
//                                             ),
//                                           )
//                                       ),
//                                   ],
//                                 )
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }
// }
