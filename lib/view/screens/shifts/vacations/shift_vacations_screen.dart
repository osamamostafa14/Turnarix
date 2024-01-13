// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:turnarix/data/model/shifts/intervals_model.dart';
// import 'package:turnarix/data/model/shifts/vacation_model.dart';
// import 'package:turnarix/provider/shifts_provider.dart';
// import 'package:turnarix/utill/dimensions.dart';
// import 'package:turnarix/view/screens/shifts/vacations/update_date_picker_sheet.dart';
//
// class ShiftVacationsScreen extends StatefulWidget {
//   final IntervalModel? interval;
//   ShiftVacationsScreen(
//       {@required this.interval,
//       });
//   @override
//   State<ShiftVacationsScreen> createState() => _ShiftVacationsScreenState();
// }
//
// class _ShiftVacationsScreenState extends State<ShiftVacationsScreen> {
//   ScrollController scrollController =  ScrollController();
//
//   @override
//   Widget build(BuildContext? context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context!).scaffoldBackgroundColor,
//       appBar: AppBar(
//         title: Text('Le mie ferie/assenze',
//             style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal)),
//         centerTitle: true,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         elevation: 0.5,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios),
//           color: Colors.black87,
//           onPressed: () =>  Navigator.pop(context),
//         ),
//       ),
//       body: Consumer<ShiftsProvider>(
//         builder: (context, shiftsProvider, child) {
//           return Column(
//             children: [
//               Expanded(
//                 child: Scrollbar(
//                   child: SingleChildScrollView(
//                     controller: scrollController,
//                     physics: const BouncingScrollPhysics(),
//                     padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//                     child: Center(
//                       child: SizedBox(
//                           width: 1170,
//                           child:
//                           Column(
//                             crossAxisAlignment:
//                             CrossAxisAlignment.start,
//                             children: [
//                               ListView.builder(
//                                 padding: const EdgeInsets.all(6),
//                                 itemCount: widget.interval!.vacations!.length,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 itemBuilder: (context, index) {
//                                   VacationModel _vacation = widget.interval!.vacations![index];
//                                   return
//                                     shiftsProvider.removedVacationsIds.contains(_vacation.id)?
//                                         const SizedBox():
//                                     Stack(
//                                       children: [
//                                         InkWell(
//                                           onTap:(){
//                                             showModalBottomSheet(
//                                               context: context,
//                                               isScrollControlled: true,
//                                               backgroundColor: Colors.transparent,
//                                               builder: (con) {
//                                                 return UpdateDatePickerSheet(
//                                                   vacation: _vacation,
//                                                 );
//                                               },
//                                             );
//                                           },
//                                           child: Container(
//                                             padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//                                             margin: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
//                                             decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               boxShadow: [BoxShadow(
//                                                 color: Colors.grey[300]!,
//                                                 spreadRadius: 1, blurRadius: 5,
//                                               )],
//                                               borderRadius: BorderRadius.circular(5),
//                                             ),
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(8.0),
//                                               child: Row(
//                                                 children: [
//                                                   Text('${_vacation.name}', style: const TextStyle(fontSize: 17)),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     );
//                                 },
//                               ),
//                             ],
//                           )
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 15),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
//
