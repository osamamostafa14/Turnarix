import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/model/calendar_data_model.dart';
import 'package:turnarix/data/model/shifts/calendar_shift_model.dart';
import 'package:turnarix/data/model/vacation_model.dart';
import 'package:turnarix/provider/calendar_provider.dart';
import 'package:turnarix/provider/vacation_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/view/base/custom_button.dart';

class VacationsListBottomSheet extends StatelessWidget {

  final DateTime? date;
  VacationsListBottomSheet(
      {@required this.date,
      });

  @override
  Widget build(BuildContext? context) {

    return
     Stack(
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
                                Navigator.pop(context!);
                              },
                              child: Icon(Icons.close, color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 10),

                      Consumer<CalendarProvider>(
                          builder: (context, calendarProvider, child){

                            return Container(
                              height: calendarProvider.getSelectedCalendarVacations().length>0?
                              MediaQuery.of(context).size.height * 0.35: MediaQuery.of(context).size.height * 0.15,
                              child:
                              calendarProvider.getSelectedCalendarVacations().length == 0 &&
                                  Provider.of<VacationProvider>(context, listen: false).bottomVacationsVisible == false?
                              Center(child: Text('Non hai ancora aggiunto le vacanze', style: TextStyle(color: Colors.white))):
                              ListView.builder(
                                padding: const EdgeInsets.all(6),
                                itemCount: calendarProvider.getSelectedCalendarVacations().length,
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  //   CalendarShiftModel _calendarShift = calendarProvider.getSelectedCalendarShifts()[index];
                                  CalendarVacationModel calendarVacation =  calendarProvider.getSelectedCalendarVacations()[index];

                                  void _removeVacationFromCalendar(){
                                    int _calendarVacationId = calendarVacation.id!;
                                    calendarProvider.removeVacationFromDay(
                                        date!,
                                        _calendarVacationId);

                                    calendarProvider.removeVacationFromCalendar(context,
                                        _calendarVacationId);
                                  }

                                  return

                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () {

                                          },
                                          child: Row(
                                            children: [

                                              const SizedBox(width: 15),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('${calendarVacation.vacation!.name}', style: TextStyle(
                                                      color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16)),
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
                                                      content: Text('Vuoi rimuovere questa vacanza dal calendario?',style: TextStyle(color: Colors.white)),
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
                                                                        _removeVacationFromCalendar();
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
                            );
                          }),

                    ],
                  ),
                ),

                Consumer<VacationProvider>(
                    builder: (context, vacationProvider, child){
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
                                  height: 60,
                                  //  color: Colors.blueAccent,
                                  child:
                                  vacationProvider.bottomVacationsVisible?
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.77,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: vacationProvider.vacationsLists.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            VacationModel _vacation = vacationProvider.vacationsLists[index];

                                            return Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap:(){
                                                  Provider.of<CalendarProvider>(context, listen: false).updateVacationSelectedDay(
                                                      Provider.of<CalendarProvider>(context, listen: false).selectedDay, _vacation);

                                                  Provider.of<CalendarProvider>(context, listen: false).addVacationToCalendar(context,_vacation.id!,
                                                      Provider.of<CalendarProvider>(context, listen: false).selectedDay);
                                                },
                                                child: Container(
                                                  height: 35,
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                    color: ColorResources.BG_SECONDRY,
                                                    borderRadius: BorderRadius.circular(20),
                                                    boxShadow: [BoxShadow(
                                                      color: Colors.black,
                                                      blurRadius: 5, spreadRadius: 2,
                                                    )],
                                                  ),
                                                  child: Center(child:
                                                  SizedBox(
                                                    width: 45,
                                                    child: Text('${_vacation.name}',
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(color: Colors.white,
                                                            fontWeight: FontWeight.w500, fontSize: 11)),
                                                  )),
                                                ),
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
                                    vacationProvider.updateBottomVacationsVisibility(vacationProvider.bottomVacationsVisible? false: true);
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
                                    vacationProvider.bottomVacationsVisible?
                                    Center(child: Text('-', style: TextStyle(color: Colors.white, fontSize: 35))):
                                    Icon(Icons.add, color: Colors.white),
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      );
                    }),

              ],
            );

  }
}

