import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/helper/date_converter.dart';
import 'package:turnarix/data/helper/helpers.dart';
import 'package:turnarix/data/model/response/response_model.dart';
import 'package:turnarix/data/model/shifts/calendar_shift_model.dart';
import 'package:turnarix/data/model/shifts/intervals_model.dart';
import 'package:turnarix/provider/calendar_provider.dart';
import 'package:turnarix/provider/saved_shift_provider.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/base/custom_text_field.dart';
import 'package:turnarix/view/screens/shifts/add_shift_screen.dart';
import 'package:turnarix/view/screens/shifts/saved_shift/edit_interval_screen.dart';

class CalendarBottomSheet extends StatelessWidget {
  final List<CalendarShiftModel>? shifts;
  final DateTime? date;
  CalendarBottomSheet(
      {@required this.shifts, @required this.date,
      });

  @override
  Widget build(BuildContext? context) {
    FocusNode _shiftNameFocus = FocusNode();
    TextEditingController? _shiftNameController = TextEditingController();

    return
      Consumer<CalendarProvider>(
          builder: (context, calendarProvider, child){

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
                            Navigator.pop(context);
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

            return Stack(
              children: [
                Container(
                  width: 550,
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  decoration: BoxDecoration(
                    color: ColorResources.BG_SECONDRY,
                    borderRadius:  BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap:(){
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.close, color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 10),

                      Container(
                        height: calendarProvider.getSelectedCalendarShifts().length>0?
                        MediaQuery.of(context).size.height * 0.35: MediaQuery.of(context).size.height * 0.15,
                        child:
                        calendarProvider.getSelectedCalendarShifts().length == 0 && calendarProvider.bottomIntervalsVisible == false?
                        Center(child: Text('Non hai ancora aggiunto turni', style: TextStyle(color: Colors.white))):
                        ListView.builder(
                          padding: const EdgeInsets.all(6),
                          itemCount: calendarProvider.getSelectedCalendarShifts().length,
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                         //   CalendarShiftModel _calendarShift = calendarProvider.getSelectedCalendarShifts()[index];
                            IntervalModel interval =  calendarProvider.getSelectedCalendarShifts()[index].interval!;

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

                            _removeShift() {
                              int _calendarShiftId = calendarProvider.getSelectedCalendarShifts()[index].id!;
                              calendarProvider.removeCalendarShiftFromDay(
                                  date!,
                                  _calendarShiftId);

                              calendarProvider.removeShiftFromCalendar(context,
                                  _calendarShiftId);
                            }

                            return
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Provider.of<SavedShiftProvider>(context, listen: false).initInterval(
                                        interval.title!=null? interval.title!: '',
                                        interval.iconName!=null? interval.iconName!: 'sunny',
                                        interval.iconColor!=null? Color(int.parse(interval.iconColor!)): Colors.blueAccent,
                                        interval.foodStamp == 1? true: false,
                                        interval.services !=null? interval.services! : [],
                                        interval.breaks !=null? interval.breaks! : [],
                                        interval.allowances !=null? interval.allowances! : [],
                                        interval.extraordinaries !=null? interval.extraordinaries! : [],
                                      );
                                      Provider.of<SavedShiftProvider>(context, listen: false).resetIcon();

                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
                                          EditIntervalScreen(interval: interval)));
                                    },
                                    child: Row(
                                      children: [
                                        Icon(_icon, color: finalColor),
                                        const SizedBox(width: 15),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('${interval.name}', style: TextStyle(
                                                color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16)),

                                            for(int i = 0; i <  interval.services!.length ; i++)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4),
                                              child: Row(
                                                children: [
                                                  Text('${DateConverter.timeOnly(interval.services![i].startService!)}',
                                                      style: TextStyle(
                                                      color: Colors.white70, fontWeight: FontWeight.normal, fontSize: 13)),

                                                  const SizedBox(width: 10),

                                                  Text('${DateConverter.timeOnly(interval.services![i].endService!)}',
                                                      style: TextStyle(
                                                      color: Colors.white70, fontWeight: FontWeight.normal, fontSize: 13)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                backgroundColor: ColorResources.BG_SECONDRY,
                                                title: Text('Sei sicuro?', style: TextStyle(color: Colors.white)),
                                                content: Text('Vuoi rimuovere questo turno??',style: TextStyle(color: Colors.white)),
                                                actions: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(bottom: 12),
                                                    child: Row(
                                                      children: [
                                                        const SizedBox(width: 8),
                                                        Expanded(
                                                            child: CustomButton(btnTxt: 'No',
                                                              backgroundColor: Colors.grey,
                                                              onTap: (){
                                                                Navigator.pop(context);
                                                              },
                                                            )),
                                                        const SizedBox(width: 8),

                                                        Expanded(
                                                            child: CustomButton(btnTxt: 'SÌ',
                                                                onTap:(){
                                                                  Navigator.pop(context);
                                                                  _removeShift();
                                                                })),
                                                        const SizedBox(width: 8),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15.0),
                                                  // Adjust the radius as needed
                                                ),
                                              ),
                                            );
                                          },
                                          child: Icon(Icons.delete, color: Colors.white70),
                                        ),
                                        const SizedBox(width: 15)
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Divider(color: Colors.white),
                                  ),
                                ],
                              );
                          },
                        ),
                      ),

                    ],
                  ),
                ),


                Consumer<CalendarProvider>(
                    builder: (context, calendarProvider, child) {
                      return Positioned(
                        //left: 10,
                        bottom: 30,
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.81,
                                  height: 100,
                                  //  color: Colors.blueAccent,
                                  child:
                                  calendarProvider.bottomIntervalsVisible?
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.77,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: calendarProvider.intervalList.length,
                                          itemBuilder: (BuildContext context, int index) {

                                            IntervalModel _interval = calendarProvider.intervalList[index];
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
                                                      calendarProvider.updateSelectedDay(calendarProvider.selectedDay, _interval);
                                                      calendarProvider.addShiftIntervalToCalendar(context,_interval.id!, calendarProvider.selectedDay);
                                                    },
                                                    child: Container(
                                                      height: 60,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                        color: ColorResources.BG_SECONDRY,
                                                        borderRadius: BorderRadius.circular(100),
                                                        boxShadow: [BoxShadow(
                                                          color: Colors.black,
                                                          blurRadius: 5, spreadRadius: 2,
                                                        )],
                                                      ),
                                                      child: Icon(_icon, color: _color),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text('${_interval.name}', style: TextStyle(color: Colors.white))
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ): const SizedBox(),
                                ),

                                const SizedBox(width: 14),

                                InkWell(
                                  onTap: (){
                                    calendarProvider.updateBottomIntervalsVisibility(calendarProvider.bottomIntervalsVisible? false: true);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: ColorResources.BG_SECONDRY,
                                      borderRadius: BorderRadius.circular(100),
                                      boxShadow: [BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 5, spreadRadius: 2,
                                      )],
                                    ),
                                    child:
                                    calendarProvider.bottomIntervalsVisible?
                                    Center(child: Text('-', style: TextStyle(color: Colors.white, fontSize: 35))):
                                    Icon(Icons.add, color: Colors.white),
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      );
                    })
              ],
            );
          });
  }
}

