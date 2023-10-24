import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';

class DateTimePickerScreen extends StatefulWidget {

  @override
  State<DateTimePickerScreen> createState() => _DateTimePickerScreenState();
}

class _DateTimePickerScreenState extends State<DateTimePickerScreen> {

  String _selectedDate = '';
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext? context) {
    return Scaffold(
      backgroundColor: Theme.of(context!).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.close),
          color: Colors.black87,
          onPressed: () =>  Navigator.pop(context),
        ),
      ),
      body: Consumer<ShiftsProvider>(
        builder: (context, shiftsProvider, child) {
          void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
              if (args.value is PickerDateRange) {

                shiftsProvider.setShiftDate(args.value.startDate.toString(), '${args.value.endDate.toString() ?? args.value.startDate.toString()}');

              } else if (args.value is DateTime) {
                _selectedDate = args.value.toString();
                shiftsProvider.setShiftSingleDate(_selectedDate);
              }
              // else if (args.value is List<DateTime>) {
              //   _dateCount = args.value.length.toString();
              // } else {
              //   _rangeCount = args.value.length.toString();
              // }
          }
          return SafeArea(
            child: Scrollbar(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                physics: BouncingScrollPhysics(),
                child: Center(
                  child: SizedBox(
                    width: 1170,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 15),
                            InkWell(
                              onTap: (){
                                shiftsProvider.setIsDateRange(true);
                              },
                              child: Container(
                                height: 50,
                                width: 170,
                                decoration: BoxDecoration(
                                  color: shiftsProvider.isDateRange? Colors.black87 : Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.black12,
                                      width: shiftsProvider.isDateRange? 0 : 1),
                                ),
                                child: Center(
                                  child: Text('Intervallo di date', style: TextStyle(
                                      color: shiftsProvider.isDateRange?
                                      Colors.white : Colors.black87, fontWeight: FontWeight.w500, fontSize: 16)),
                                ),
                              ),
                            ),

                            const SizedBox(width: 10),

                            InkWell(
                              onTap: (){
                                shiftsProvider.setIsDateRange(false);
                              },
                              child: Container(
                                height: 50,
                                width: 170,
                                decoration: BoxDecoration(
                                  color: !shiftsProvider.isDateRange? Colors.black87 : Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.black12,
                                      width: !shiftsProvider.isDateRange? 0 : 1),
                                ),
                                child: Center(
                                  child: Text('Unico giorno', style: TextStyle(
                                      color: !shiftsProvider.isDateRange?
                                      Colors.white : Colors.black87, fontWeight: FontWeight.w500, fontSize: 16)),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Padding(
                        //   padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        //   child: InkWell(
                        //     onTap: () {
                        //       showDialog(
                        //         context: context,
                        //         builder: (BuildContext? context) {
                        //           return AlertDialog(
                        //             //title: Text("Hint", style: TextStyle(color: Theme.of(context!).primaryColor, fontSize: 15)),
                        //             content: Column(
                        //               mainAxisSize: MainAxisSize.min,
                        //               children: [
                        //                   Column(
                        //                     mainAxisAlignment: MainAxisAlignment.center,
                        //                     children: [
                        //                       InkWell(
                        //                           onTap : () {
                        //                             shiftsProvider.setIsDateRange(true);
                        //                             Navigator.pop(context!);
                        //                           },
                        //                           child: Row(
                        //                             crossAxisAlignment: CrossAxisAlignment.center,
                        //                             children: [
                        //                               Expanded(
                        //                                 child: SizedBox(
                        //                                   height: 30,
                        //                                   child: Text("Intervallo di date",
                        //                                       style: TextStyle(color: Colors.black87, fontSize: 16)),
                        //                                 ),
                        //                               ),
                        //                               shiftsProvider.isDateRange?
                        //                               Icon(Icons.check_circle, color: Colors.green): SizedBox()
                        //                             ],
                        //                           )),
                        //                       Padding(
                        //                         padding: const EdgeInsets.only(bottom: 8),
                        //                         child: const Divider(),
                        //                       ),
                        //
                        //                       InkWell(
                        //                           onTap : () {
                        //                             shiftsProvider.setIsDateRange(false);
                        //                             Navigator.pop(context!);
                        //                           },
                        //                           child: Row(
                        //                             crossAxisAlignment: CrossAxisAlignment.center,
                        //                             children: [
                        //                               Expanded(
                        //                                 child: SizedBox(
                        //                                   height: 30,
                        //                                   child: Text("Unico giorno",
                        //                                       style: TextStyle(color: Colors.black87, fontSize: 16)),
                        //                                 ),
                        //                               ),
                        //                               !shiftsProvider.isDateRange?
                        //                               Icon(Icons.check_circle, color: Colors.green): SizedBox()
                        //                             ],
                        //                           )),
                        //                     ],
                        //                   ),
                        //               ],
                        //             ),
                        //           shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(15.0)), //
                        //           );
                        //         },
                        //       );
                        //     },
                        //     child: Container(
                        //       height: 50,
                        //       decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           borderRadius: const BorderRadius.all(Radius.circular(10)),
                        //           border: Border.all(width: 1, color: Colors.blue.withOpacity(0.5))
                        //       ),
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Text('${shiftsProvider.isDateRange? 'Intervallo di date' : 'Unico giorno'}', style: TextStyle(color: Colors.black54, fontSize: 16)),
                        //           const SizedBox(width: 10),
                        //           Transform(
                        //             alignment: Alignment.center,
                        //             transform: Matrix4.rotationZ(-90.0 * (pi / 180.0)),
                        //             child: Icon(Icons.arrow_back_ios_sharp, size: 18, color: Colors.black54),
                        //           ),
                        //           const SizedBox(width: 15),
                        //
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        Positioned(
                          left: 0,
                          top: 80,
                          right: 0,
                          bottom: 0,
                          child: SfDateRangePicker(
                            onSelectionChanged: _onSelectionChanged,
                            selectionMode: shiftsProvider.isDateRange? DateRangePickerSelectionMode.range: DateRangePickerSelectionMode.single,
                            initialSelectedRange: PickerDateRange(
                                DateTime.now().subtract(const Duration(days: 4)),
                                DateTime.now().add(const Duration(days: 3))),
                          ),
                        ),

                        SizedBox(height: 10),

                        /// TIME PICKER
                        Row(
                          children: [
                            Icon(Icons.access_time, color: Theme.of(context).primaryColor, size: 25),
                            SizedBox(width: 5),
                            shiftsProvider.shiftStartTime!=null?
                            Text('Il turno inizia alle:', style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold, fontSize: 16
                            )): SizedBox(),

                            TextButton(
                                child: Text('${shiftsProvider.shiftStartTime!=null? '${shiftsProvider.shiftStartTime!.hour}:${shiftsProvider.shiftStartTime!.minute} ${shiftsProvider.shiftStartTime!.period.name}' : 'Orario di inizio turno'}',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold, fontSize: 16
                                    )),
                                onPressed: () async {
                                  final TimeOfDay? picked = await showTimePicker(
                                    context: context,
                                    initialTime: _selectedTime,
                                  );
                                  if (picked != null && picked != _selectedTime) {
                                    _selectedTime = picked;
                                  }
                                  shiftsProvider.setStartTime(_selectedTime);
                                }
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Icon(Icons.access_time, color: Theme.of(context).primaryColor, size: 25),
                            SizedBox(width: 5),
                            shiftsProvider.shiftEndTime!=null?
                            Text('Il turno termina alle:', style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold, fontSize: 16
                            )): SizedBox(),
                            TextButton(
                                child: Text('${shiftsProvider.shiftEndTime!=null? '${shiftsProvider.shiftEndTime!.hour}:${shiftsProvider.shiftEndTime!.minute} ${shiftsProvider.shiftEndTime!.period.name}' : 'Orario di fine turno'}',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold, fontSize: 16
                                    )),
                                onPressed: () async {
                                  final TimeOfDay? picked = await showTimePicker(
                                    context: context,
                                    initialTime: _selectedTime,
                                  );
                                  if (picked != null && picked != _selectedTime) {
                                    _selectedTime = picked;
                                  }
                                  shiftsProvider.setEndTime(_selectedTime);
                                }
                            ),
                          ],
                        ),

                        const SizedBox(height: 50),

                        CustomButton(btnTxt: 'Confermare', onTap: (){
                          if(shiftsProvider.shiftStartTime == null){
                            showCustomSnackBar('si prega di inserire l\'orario di inizio turno', context);
                          }else if(shiftsProvider.shiftEndTime == null){
                            showCustomSnackBar('si prega di compilare l\'ora di fine turno', context);
                          }else {
                            if(shiftsProvider.isDateRange){
                              shiftsProvider.saveShiftDate(shiftsProvider.startDate!, shiftsProvider.endDate!, true);
                            }else {
                              shiftsProvider.saveShiftDate(shiftsProvider.startDate!, '', false);
                            }
                            Navigator.pop(context);
                          }
                        })
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

