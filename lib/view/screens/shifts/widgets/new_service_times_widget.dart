import 'dart:core';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/model/shifts/intervals_model.dart';
import 'package:flutter/material.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/view/base/custom_button.dart';

class NewServiceTimesWidget extends StatelessWidget {
  final IntervalModel? interval;
  bool? fromEmployee;
  NewServiceTimesWidget({this.interval, this.fromEmployee = false});

  @override
  Widget build(BuildContext context) {

    return
      Consumer<ShiftsProvider>(
          builder: (context, shiftProvider, child) {

            List<IntervalServiceModel> _servicesList = [];


            if(fromEmployee == true){
              _servicesList = interval!.services!;
            }else{
              _servicesList = shiftProvider.selectedServiceTimeList;
            }

            return Column(
              children: [

                const SizedBox(height: 10),

                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // padding: const EdgeInsets.all(0),
                  itemCount: _servicesList.length,
                  itemBuilder: (context, index) {
                    IntervalServiceModel _service = _servicesList[index];

                    DateTime startTimeDate = DateTime.parse(_service.startService!);
                    print('parsed ${startTimeDate}');
                    TimeOfDay startTime = TimeOfDay(hour: startTimeDate.hour, minute: startTimeDate.minute);

                    DateTime endTimeDate = DateTime.parse(_service.endService!);
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
                              Text('Servizio aggiuntivo ${index + 1}', style: TextStyle(
                                  color: Colors.white,
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
                                              child: CustomButton(btnTxt: 'Yes',
                                                  onTap: (){
                                                    Navigator.pop(context);
                                                    shiftProvider.removeServiceTime(_service.id!);
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
                                    if(fromEmployee == false){
                                      TimeOfDay _selectedTime = TimeOfDay(hour: startTimeDate.hour, minute: startTimeDate.minute);

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
                                        shiftProvider.updateServiceTime(_service.id!, picked, 'start');
                                      }
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      Text('Inizio servicio', style:
                                      TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 15)),
                                      Spacer(),
                                      Text('${formattedStartTime}', style:
                                      TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 15)),
                                      const SizedBox(width: 12),
                                    ],
                                  ),
                                ),

                                Divider(),

                                InkWell(
                                  onTap: () async {
                                    if(fromEmployee == false){
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
                                        shiftProvider.updateServiceTime(_service.id!, picked, 'end');
                                      }
                                    }

                                  },
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      Text('Fine servicio', style:
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
                    shiftProvider.addIntervalServiceTime(
                        IntervalServiceModel(
                            id: random.nextInt(10000) + 1,  // Temporary Id
                            intervalId: interval!.id,
                            startService: startTime.toString(),
                            endService: endTime.toString()
                        )
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Altro servizio', style: TextStyle(color: Colors.white70, fontSize: 15)),

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
