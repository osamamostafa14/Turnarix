import 'dart:math';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:flutter/material.dart';
import 'package:turnarix/view/base/custom_button.dart';

class BreakTimesWidget extends StatelessWidget {
  final Map<String, dynamic>? interval;
  BreakTimesWidget({this.interval});

  @override
  Widget build(BuildContext context) {

    return
      Consumer<ShiftsProvider>(
          builder: (context, shiftsProvider, child) {

            List<Map<String, dynamic>> _breakList = [];
            try {
              _breakList = shiftsProvider.breakList
                  .where((item) => item['interval_unique_id'] == interval!['unique_id'])
                  .toList(); // i want to order this list with item['id']

              // Continue with the code to use _translation here
            } catch (e) {
              _breakList = [];
              print("Empty List");
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

                    TimeOfDay _startTime = _breakList[index]['start_time'];
                    TimeOfDay _endTime = _breakList[index]['end_time'];

                    String formattedStartTime = DateFormat('h:mm a').format(
                      DateTime(2023, 1, 1, _startTime.hour, _startTime.minute),
                    );

                    String formattedEndTime = DateFormat('h:mm a').format(
                      DateTime(2023, 1, 1, _endTime.hour, _endTime.minute),
                    );

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Aggiungi pausa ${index + 1}', style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15
                              )),
                              const SizedBox(width: 15),
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
                                                    print('intervalUniqueId 1: ${interval!['unique_id']}');
                                                    Navigator.pop(context);
                                                    shiftsProvider.removeBreak(index, _breakList[index]['unique_id']);
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
                                color: Theme.of(context).primaryColor.withOpacity(0.3)
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                InkWell(
                                  onTap: () async {
                                    TimeOfDay _selectedTime = _startTime;

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
                                        index,
                                        {
                                          'unique_id': _breakList[index]['unique_id'],
                                          'start_time': picked,
                                          'end_time': _endTime,
                                          'interval_unique_id': interval!['unique_id']
                                        },
                                      );
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      Text('Pausa', style:
                                      TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 15)),
                                      Spacer(),
                                      Text('${formattedStartTime}', style:
                                      TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 15)),
                                      const SizedBox(width: 12),
                                    ],
                                  ),
                                ),

                                Divider(),

                                InkWell(
                                  onTap: () async {
                                    TimeOfDay _selectedTime = _endTime;

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
                                        index,
                                        {
                                          'unique_id': _breakList[index]['unique_id'],
                                          'start_time': _startTime,
                                          'end_time': picked,
                                          'interval_unique_id': interval!['unique_id']
                                        },
                                      );
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      Text('Pausa', style:
                                      TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 15)),
                                      Spacer(),
                                      Text('${formattedEndTime}', style:
                                      TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 15)),
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

                InkWell(
                  onTap: () {
                    final Random random = Random();
                    shiftsProvider.addBreak(
                        {
                          'unique_id': '${DateTime.now().hour.toString()}' '${DateTime.now().minute.toString()}.' '${random.nextInt(10000) + 1}',
                          'start_time': TimeOfDay(hour: 9, minute: 0),
                          'end_time': TimeOfDay(hour: 17, minute: 0),
                          'interval_unique_id': interval!['unique_id'],
                        }
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Altro pausa', style: TextStyle(color: Colors.black54, fontSize: 15)),

                      const SizedBox(width: 5),

                      Icon(Icons.add, color: Colors.black54),
                    ],
                  ),
                ),
              ],
            );
          });

  }
}
