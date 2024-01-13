import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/helper/helpers.dart';
import 'package:turnarix/data/model/response/response_model.dart';
import 'package:turnarix/data/model/shifts/intervals_model.dart';
import 'package:turnarix/provider/calendar_provider.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/base/custom_text_field.dart';
import 'package:turnarix/view/screens/shifts/add_shift_screen.dart';

class ShiftsBottomSheet extends StatelessWidget {
  // final DateTime? selected;
  // ShiftsBottomSheet(
  //     {@required this.intervals,
  //     });

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
                    color: Colors.white,
                    borderRadius:  BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(6),
                          itemCount: calendarProvider.intervalList.length,
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
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

                            return
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      calendarProvider.updateSelectedDay(calendarProvider.selectedDay, _interval);
                                      calendarProvider.addShiftIntervalToCalendar(context,_interval.id!, calendarProvider.selectedDay);
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(_icon, color: _color),

                                        const SizedBox(width: 50),

                                        Text('${_interval.name}',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54)),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                                    child: Divider(),
                                  )
                                ],
                              );
                          },
                        ),
                      ),

                      CustomButton(btnTxt: 'Create new', onTap: (){
                        _createShiftDialog();
                      })
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 5,
                  child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close)),
                ),
              ],
            );
          });

  }
}

