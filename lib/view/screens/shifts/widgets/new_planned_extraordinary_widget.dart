import 'dart:math';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/model/shifts/intervals_model.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:flutter/material.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/base/custom_text_field.dart';

class NewPlannedExtraordinaryWidget extends StatelessWidget {
  final IntervalModel? interval;
  final bool fromEmployee;
  NewPlannedExtraordinaryWidget({this.interval, this.fromEmployee = false});

  @override
  Widget build(BuildContext context) {
    FocusNode _titleFocus = FocusNode();
    TextEditingController? _titleController = TextEditingController();

    FocusNode _amountPerHourFocus = FocusNode();
    TextEditingController? _amountPerHourController = TextEditingController();
    return
      Consumer<ShiftsProvider>(
          builder: (context, shiftProvider, child) {

            List<IntervalExtraordinaryModel> _extraordinaryList = shiftProvider.extraordinaryList;

            if(fromEmployee == true){
              _extraordinaryList = interval!.extraordinaries!;
            }else{
              _extraordinaryList = shiftProvider.extraordinaryList;
            }
            return Column(
              children: [

                const SizedBox(height: 10),

                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // padding: const EdgeInsets.all(0),
                  itemCount: _extraordinaryList.length,

                  itemBuilder: (context, index) {

                    IntervalExtraordinaryModel _extraOrdinary= _extraordinaryList[index];

                    DateTime startTimeDate = DateTime.parse(_extraOrdinary.startTime!);
                    print('parsed ${startTimeDate}');
                    TimeOfDay startTime = TimeOfDay(hour: startTimeDate.hour, minute: startTimeDate.minute);

                    DateTime endTimeDate = DateTime.parse(_extraOrdinary.endTime!);
                    TimeOfDay endTime = TimeOfDay(hour: endTimeDate.hour, minute: endTimeDate.minute);

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
                              Text('Straordinario programmato  ${index + 1}', style: TextStyle(
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
                                                    shiftProvider.removeExtraordinary(_extraordinaryList[index].id!);
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
                            height: 180,
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
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CustomTextField(
                                                maxLength: 200,
                                                hintText: 'Titolo',
                                                isShowBorder: true,
                                                inputType: TextInputType.text,
                                                inputAction: TextInputAction.next,
                                                focusNode: _titleFocus,
                                                controller: _titleController,
                                                // isIcon: true,
                                              )
                                            ],
                                          ),
                                          actions: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                                              child: CustomButton(btnTxt: 'Confermare',
                                                onTap: () {
                                                  if(_titleController.text.trim().isEmpty){
                                                    showCustomSnackBar('il campo è vuoto', context);
                                                  }else{
                                                    Navigator.pop(context);
                                                    shiftProvider.updateExtraordinaryInfo(
                                                        _extraOrdinary.id!,
                                                        'title',
                                                        _titleController.text.trim()
                                                    );
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
                                  },
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      Text('Titolo', style:
                                      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15)),
                                      const Spacer(),
                                      Text('${_extraOrdinary.title != null? _extraOrdinary.title : fromEmployee == false? 'Aggiungu+' : ''}', style:
                                      TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 15)),
                                      const SizedBox(width: 12),
                                    ],
                                  ),
                                ),

                                const Divider(),

                                InkWell(
                                  onTap: () async {
                                    if(fromEmployee == false){
                                      TimeOfDay _selectedTime = TimeOfDay(hour: startTime.hour, minute: startTime.minute);

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
                                        shiftProvider.updateExtraordinaryTimes(_extraOrdinary.id!, picked, 'start_time');
                                      }
                                    }

                                  },
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      Text('Inizio Servizio', style:
                                      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15)),
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
                                        shiftProvider.updateExtraordinaryTimes(_extraOrdinary.id!, picked, 'end_time');
                                      }
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      Text('Fine Servizio ', style:
                                      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15)),
                                      Spacer(),
                                      Text('${formattedEndTime}', style:
                                      TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 15)),
                                      const SizedBox(width: 12),
                                    ],
                                  ),
                                ),

                                Divider(),

                                InkWell(
                                  onTap: () async {
                                    if(fromEmployee == false){
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CustomTextField(
                                                maxLength: 200,
                                                hintText: '€ Importo per ora',
                                                isShowBorder: true,
                                                inputType: TextInputType.number,
                                                inputAction: TextInputAction.next,
                                                focusNode: _titleFocus,
                                                controller: _amountPerHourController,
                                                // isIcon: true,
                                              )
                                            ],
                                          ),
                                          actions: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                                              child: CustomButton(btnTxt: 'Confermare',
                                                onTap: () {
                                                  if(_amountPerHourController.text.trim().isEmpty){
                                                    showCustomSnackBar('il campo è vuoto', context);
                                                  }else{
                                                    Navigator.pop(context);
                                                    shiftProvider.updateExtraordinaryInfo(
                                                        _extraOrdinary.id!,
                                                        'amount',
                                                        double.parse(_amountPerHourController.text.trim())
                                                    );
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

                                  },
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      const Text('Importo per ora', style:
                                      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15)),
                                      const Spacer(),
                                      Text('€${_extraOrdinary.amountPerHour != null? _extraOrdinary.amountPerHour : ''}', style:
                                      const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 15)),
                                      const SizedBox(width: 12),
                                    ],
                                  ),
                                ),

                                Divider(),

                                InkWell(
                                  onTap: () async {
                                    if(fromEmployee == false){
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  shiftProvider.updateExtraordinaryInfo(
                                                      _extraOrdinary.id!,
                                                      'type',
                                                      'Pagamento'
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    const Text('Pagamento', style: TextStyle(fontSize: 15)),

                                                    const Spacer(),

                                                    Icon(_extraOrdinary.type == 'Pagamento'?Icons.check_box: Icons.check_box_outline_blank,
                                                        color: Theme.of(context).primaryColor)
                                                  ],
                                                ),
                                              ),

                                              const Padding(
                                                padding:  EdgeInsets.only(top: 8, bottom: 8),
                                                child: Divider(),
                                              ),

                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  shiftProvider.updateExtraordinaryInfo(
                                                      _extraOrdinary.id!,
                                                      'type',
                                                      'Banca Ore'
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    const  Text('Banca Ore', style: TextStyle(fontSize: 15)),

                                                    const Spacer(),

                                                    Icon(_extraOrdinary.type == 'Banca Ore'?Icons.check_box: Icons.check_box_outline_blank,
                                                        color: Theme.of(context).primaryColor)
                                                  ],
                                                ),
                                              ),

                                              const Padding(
                                                padding:  EdgeInsets.only(top: 8, bottom: 8),
                                                child: Divider(),
                                              ),

                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  shiftProvider.updateExtraordinaryInfo(
                                                      _extraOrdinary.id!,
                                                      'type',
                                                      'Programatto'
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    const  Text('Programatto', style: TextStyle(fontSize: 15)),

                                                    const Spacer(),

                                                    Icon(_extraOrdinary.type == 'Programatto'?Icons.check_box: Icons.check_box_outline_blank,
                                                        color: Theme.of(context).primaryColor)
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
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      const Text('Tipa', style:
                                      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15)),
                                      const Spacer(),
                                      Text('${_extraOrdinary.type != null? _extraOrdinary.type: 'Pagamento'}', style:
                                      const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 15)),
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

                fromEmployee == true? const SizedBox() :
                InkWell(
                  onTap: () {
                    final Random random = Random();

                    DateTime _now  = DateTime.now();
                    String _startDate = DateTime(_now.year, _now.month, _now.day, 9, 0).toString();
                    String _endDate = DateTime(_now.year, _now.month, _now.day, 17, 0).toString();
                    shiftProvider.addExtraordinary(
                        IntervalExtraordinaryModel(
                            id:  random.nextInt(10000) + 1, /// Temprary ID
                            startTime: _startDate,
                            endTime: _endDate,
                            intervalId: interval!.id,
                            type: 'Pagamento'
                        )
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Altro', style: TextStyle(color: Colors.white70, fontSize: 15)),

                      const SizedBox(width: 5),

                      Icon(Icons.add, color: Colors.white70),
                    ],
                  ),
                ),

                const SizedBox(height: 40)
              ],
            );
          });
  }
}
