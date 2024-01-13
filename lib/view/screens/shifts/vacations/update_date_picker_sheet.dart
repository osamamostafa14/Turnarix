import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/helper/date_converter.dart';
import 'package:turnarix/data/model/shifts/vacation_model.dart';
import 'package:turnarix/data/model/vacation_model.dart';
import 'package:turnarix/provider/calendar_provider.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';

class UpdateDatePickerSheet extends StatelessWidget {
  final VacationModel? vacation;
  UpdateDatePickerSheet(
      {
        @required this.vacation,
      });

  @override
  Widget build(BuildContext? context) {

    return
      Consumer<ShiftsProvider>(
          builder: (context, shiftsProvider, child){

            return Stack(
              children: [
                Container(
                  width: 550,
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:  BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),

                          Text('data d\'inizio: ',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black54)),

                          const SizedBox(height: 10),

                          InkWell(
                            onTap: () async {
                              DateTime? dateTime = await showOmniDateTimePicker(
                                context: context,
                                type: OmniDateTimePickerType.dateAndTime,
                                initialDate: shiftsProvider.vacationStartTime!=null? shiftsProvider.vacationStartTime: DateTime.now(),
                                firstDate:
                                DateTime(1600).subtract(const Duration(days: 3652)),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 3652),
                                ),
                                is24HourMode: false,
                                isShowSeconds: false,
                                minutesInterval: 1,
                                secondsInterval: 1,
                                isForce2Digits: true,
                                borderRadius: const BorderRadius.all(Radius.circular(16)),
                                constraints: const BoxConstraints(
                                  maxWidth: 350,
                                  maxHeight: 650,
                                ),
                                transitionBuilder: (context, anim1, anim2, child) {
                                  return FadeTransition(
                                    opacity: anim1.drive(
                                      Tween(
                                        begin: 0,
                                        end: 1,
                                      ),
                                    ),
                                    child: child,
                                  );
                                },
                                transitionDuration: const Duration(milliseconds: 200),
                                barrierDismissible: true,
                                selectableDayPredicate: (dateTime) {
                                  // Disable 25th Feb 2023
                                  if (dateTime.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
                                    return false;
                                  } else {
                                    return true;
                                  }
                                },
                              );
                              shiftsProvider.setVacationStartTime(dateTime!);
                            },
                            child: Text(shiftsProvider.vacationStartTime!=null?
                            '${DateConverter.estimatedDate(shiftsProvider.vacationStartTime!)}':
                            '${DateConverter.monthYear(vacation!.startDate!)}',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal,
                                    color: Theme.of(context).primaryColor)),
                          ),

                          const SizedBox(height: 20),

                          Text('data di fine: ',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black54)),

                          const SizedBox(height: 10),

                          InkWell(
                            onTap: () async {
                              DateTime? dateTime = await showOmniDateTimePicker(
                                context: context,
                                type: OmniDateTimePickerType.dateAndTime,
                                initialDate: shiftsProvider.vacationEndTime!=null? shiftsProvider.vacationEndTime: DateTime.now(),
                                firstDate:
                                DateTime(1600).subtract(const Duration(days: 3652)),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 3652),
                                ),
                                is24HourMode: false,
                                isShowSeconds: false,
                                minutesInterval: 1,
                                secondsInterval: 1,
                                isForce2Digits: true,
                                borderRadius: const BorderRadius.all(Radius.circular(16)),
                                constraints: const BoxConstraints(
                                  maxWidth: 350,
                                  maxHeight: 650,
                                ),
                                transitionBuilder: (context, anim1, anim2, child) {
                                  return FadeTransition(
                                    opacity: anim1.drive(
                                      Tween(
                                        begin: 0,
                                        end: 1,
                                      ),
                                    ),
                                    child: child,
                                  );
                                },
                                transitionDuration: const Duration(milliseconds: 200),
                                barrierDismissible: true,
                                selectableDayPredicate: (dateTime) {
                                  // Disable 25th Feb 2023
                                  if (dateTime.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
                                    return false;
                                  } else {
                                    return true;
                                  }
                                },
                              );
                              shiftsProvider.setVacationEndTime(dateTime!);
                            },
                            child: Text(shiftsProvider.vacationEndTime!=null?
                            '${DateConverter.estimatedDate(shiftsProvider.vacationEndTime!)}':
                            '${DateConverter.monthYear(vacation!.endDate!)}',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal,
                                    color: Theme.of(context).primaryColor)),
                          ),

                          const SizedBox(height: 30),

                          shiftsProvider.vacationLoading?
                          Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor),
                              )):
                          CustomButton(btnTxt: 'aggiornamento',
                              onTap: () async {
                                if(shiftsProvider.vacationStartTime == null){
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Text('Suggerimento'),
                                      content: Text('si prega di aggiungere il campo dell\'ora di inizio'),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                                      ),
                                    ),
                                  );

                                }else if(shiftsProvider.vacationEndTime == null){
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Text('Suggerimento'),
                                      content: Text('aggiungi il campo dell\'ora di fine'),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                                      ),
                                    ),
                                  );
                                } else{
                                  shiftsProvider.updateVacation(
                                      context,
                                      shiftsProvider.vacationStartTime.toString(),
                                      shiftsProvider.vacationEndTime.toString(),
                                      vacation!.id!
                                  ).then((value) {
                                    if(value.isSuccess){
                                      showCustomSnackBar('vacanza aggiunta con successo', context, isError: false);
                                      Navigator.pop(context);
                                    }else{
                                      showCustomSnackBar('qualcosa è andato storto!', context);
                                      Navigator.pop(context);
                                    }

                                  });
                                }

                              }),

                          const SizedBox(height: 12),

                          shiftsProvider.vacationLoading?
                          Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor),
                              )):
                          CustomButton(
                              btnTxt: 'rimuovere',
                              backgroundColor: Colors.black45,
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text('Sei sicuro?'),
                                    content: Text('vuoi rimuovere questo elemento?'),
                                    actions: [
                                      Row(
                                        children: [
                                          const SizedBox(width: 8),
                                          Expanded(
                                              child: CustomButton(btnTxt: 'No',
                                              backgroundColor: Colors.black45,
                                              onTap: (){
                                                Navigator.pop(context);
                                              },
                                              )),
                                          const SizedBox(width: 8),

                                          Expanded(

                                              child: CustomButton(btnTxt: 'SÌ',
                                                onTap:(){
                                                  Navigator.pop(context);
                                                shiftsProvider.removeVacation(context, vacation!.id!).then((value) {
                                                  if(value.isSuccess){
                                                    Provider.of<CalendarProvider>(context, listen: false).getCalendarShifts(context);
                                                    showCustomSnackBar('elemento rimosso!', context, isError: false);
                                                    Navigator.pop(context);

                                                  }else{
                                                    showCustomSnackBar('qualcosa è andato storto!', context);
                                                    Navigator.pop(context);
                                                  }
                                                });
                                                })),
                                          const SizedBox(width: 8),
                                        ],
                                      ),
                                    ],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
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