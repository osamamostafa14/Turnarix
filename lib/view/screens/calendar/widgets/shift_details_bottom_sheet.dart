import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/helper/date_converter.dart';
import 'package:turnarix/data/model/shifts/intervals_model.dart';
import 'package:turnarix/provider/calendar_provider.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/utill/images.dart';
import 'package:turnarix/view/screens/shifts/vacations/select_vacation_screen.dart';
import 'package:turnarix/view/screens/shifts/vacations/shift_vacations_screen.dart';

class ShiftDetailsBottomSheet extends StatelessWidget {
  final IntervalModel? interval;
  ShiftDetailsBottomSheet(
      {@required this.interval,
      });


  @override
  Widget build(BuildContext? context) {

    return
      Consumer<CalendarProvider>(
          builder: (context, calendarProvider, child){

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
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(Images.calendar_img), // Replace with your image asset
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  '${calendarProvider.selectedDay.day}',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 24,
                                  ),
                                ),

                                Text(
                                  '${DateConverter.getMonthName(calendarProvider.selectedDay.month)}',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            )),

                          const SizedBox(width: 20),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Turno: ',
                                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.black54)),

                                  Text('${interval!.name}',
                                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500))
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text('Ora di inizio: ',
                                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.black54)),

                                  interval!.services!=null?
                                  Text('${DateConverter.timeOnly(interval!.services![0].startService!)}',
                                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)): const SizedBox()
                                ],
                              )
                            ],
                          ),
                        ],
                      ),

                        const SizedBox(height: 15),

                        Row(
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text('Orario straordinario: ',
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.black54)),
                            ),

                            Text('${calendarProvider.calculateDayExtraOrdinaries(interval!)} ore',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500))
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text('Ferie/Assenze: ',
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.black54)),
                            ),

                            InkWell(
                              onTap: (){
                                showDialog(
                                  context: context, // i want to create another cobtext here
                                  builder: (_) => AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [

                                        InkWell(
                                          onTap:(){
                                            // Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
                                            //     ShiftVacationsScreen(interval: interval)));
                                          },
                                          child: Container(
                                            height: 40,
                                            child: Center(child: Text('Le mie ferie/assenze')),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(width: 1,
                                                  color: Theme.of(context).primaryColor),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 12),

                                        InkWell(
                                          onTap:(){
                                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
                                                SelectVacationScreen(intervalId: interval!.id)));
                                          },
                                          child: Container(
                                            height: 40,
                                            child: Center(child: Text('aggiungere nuova')),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(width: 1,
                                                  color: Theme.of(context).primaryColor),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text('Edit',
                                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500,
                                          color: Theme.of(context).primaryColor)),

                                  const SizedBox(width: 4),

                                  Icon(Icons.edit, color: Theme.of(context).primaryColor, size: 18)
                                ],
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text('Servizio Ordine Pubblico: ',
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.black54)),
                            ),

                            Text('${DateConverter.timeOnly(interval!.services![0].startService!)}',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500))
                          ],
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text('Orario straordinario: ',
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.black54)),
                            ),

                            Text('${DateConverter.timeOnly(interval!.services![0].startService!)}',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500))
                          ],
                        )

                      ],
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

