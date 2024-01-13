import 'dart:math';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/model/shifts/intervals_model.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:flutter/material.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/view/base/custom_button.dart';

class NewBreakTimesWidget extends StatelessWidget {
  final IntervalModel? interval;
  bool? fromEmployee;
  NewBreakTimesWidget({this.interval, this.fromEmployee = false});

  @override
  Widget build(BuildContext context) {

    return
      Consumer<ShiftsProvider>(
          builder: (context, shiftsProvider, child) {

            List<IntervalBreakModel> _breakList = [];

            if(fromEmployee == true){
              _breakList = interval!.breaks!;
            }else{
              _breakList = shiftsProvider.selectedBreakList;
            }
            return Column(
              children: [

                const SizedBox(height: 10),

                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // padding: const EdgeInsets.all(0),
                  itemCount: _breakList.length,
                  itemBuilder: (context, index) {
                    IntervalBreakModel _break = _breakList[index];

                    DateTime startTimeDate = DateTime.parse(_break.startTime!);
                    TimeOfDay startTime = TimeOfDay(hour: startTimeDate.hour, minute: startTimeDate.minute);

                    DateTime endTimeDate = DateTime.parse(_break.endTime!);
                    TimeOfDay sendTime = TimeOfDay(hour: endTimeDate.hour, minute: endTimeDate.minute);

                    String formattedStartTime = DateFormat('h:mm a').format(
                      DateTime(2023, 1, 1, startTimeDate.hour, startTimeDate.minute),
                    );

                    String formattedEndTime = DateFormat('h:mm a').format(
                      DateTime(2023, 1, 1, endTimeDate.hour, endTimeDate.minute),
                    );


                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Aggiungi pausa ${index + 1}', style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15
                              )),
                              const SizedBox(width: 15),

                              fromEmployee == true? const SizedBox():
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Text('Rimuovere questo elemento?', style:
                                      TextStyle(fontSize: 16, color: Colors.black87)),
                                      actions: [
                                        Row(
                                          children: [
                                            const SizedBox(width: 14),
                                            Expanded(
                                              child: CustomButton(btnTxt: 'No',
                                                  backgroundColor: Colors.black54,
                                                  onTap: (){
                                                    Navigator.pop(context);
                                                  }),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: CustomButton(btnTxt: 'SÌ',
                                                  onTap: (){

                                                    Navigator.pop(context);
                                                    shiftsProvider.removeBreak(_break.id!);
                                                  }),
                                            ),
                                            const SizedBox(width: 14),
                                          ],
                                        )
                                      ],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                                      ),
                                    ),
                                  );
                                },
                                child: Text('Eliminare', style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15
                                )),
                              ),
                            ],
                          ),

                          const SizedBox(height: 5),

                          Container(
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              color: Theme.of(context).primaryColor.withOpacity(0.3),
                              border: Border.all(width: 1, color: ColorResources.BORDER_COLOR),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                InkWell(
                                  onTap: () async {
                                    if(fromEmployee == false) {
                                      TimeOfDay _selectedTime = TimeOfDay(
                                          hour: startTimeDate.hour, minute: startTimeDate.minute);

                                      TimeOfDay? picked = await showTimePicker(
                                        context: context,
                                        initialTime: _selectedTime,
                                        builder: (BuildContext context, Widget? child) {
                                          return MediaQuery(
                                            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                            child: child!,
                                          );
                                        },
                                      );
                                      if (picked != null && picked != _selectedTime) {
                                        shiftsProvider.updateBreak(
                                            _break.id!, picked, 'start'
                                        );
                                      }
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      Text('Inizio della pausa', style:
                                      TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 15)),
                                      Spacer(),
                                      Text('${formattedStartTime}', style:
                                      TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 15)),
                                      const SizedBox(width: 12),
                                    ],
                                  ),
                                ),

                                const Divider(),

                                InkWell(
                                  onTap: () async {
                                    if(fromEmployee == false) {
                                      TimeOfDay _selectedTime = TimeOfDay(hour: endTimeDate.hour, minute: endTimeDate.minute);
                                      TimeOfDay? picked = await showTimePicker(
                                        context: context,
                                        initialTime: _selectedTime,
                                        builder: (BuildContext context, Widget? child) {
                                          return MediaQuery(
                                            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                            child: child!,
                                          );
                                        },
                                      );
                                      if (picked != null && picked != _selectedTime) {
                                        shiftsProvider.updateBreak(
                                            _break.id!, picked, 'end'
                                        );
                                      }
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      Text('fine della pausa', style:
                                      TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 15)),
                                      Spacer(),
                                      Text('${formattedEndTime}', style:
                                      TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 15)),
                                      const SizedBox(width: 12),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                fromEmployee == true? const SizedBox():
                InkWell(
                  onTap: () {
                    DateTime now = DateTime.now();
                    DateTime startTime = DateTime(now.year, now.month, now.day, 9, 0);
                    DateTime endTime = DateTime(now.year, now.month, now.day, 17, 0);
                    final Random random = Random();
                    shiftsProvider.addIntervalBreak(
                        IntervalBreakModel(
                            id: random.nextInt(10000) + 1,
                            intervalId: interval!.id,
                            startTime: startTime.toString(),
                            endTime: endTime.toString()
                        )
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Altro pausa', style: TextStyle(color: Colors.white70, fontSize: 15)),

                      const SizedBox(width: 5),

                      Icon(Icons.add, color: Colors.white70),
                    ],
                  ),
                ),
              ],
            );
          });

  }
}
