import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/provider/calendar_provider.dart';
import 'package:turnarix/view/screens/shifts/shifts_screen.dart';



class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() =>
      _CalendarScreenState();
}

class _CalendarScreenState
    extends State<CalendarScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    // Add a listener to the PageController
    _pageController.addListener(_scrollListener);
  }
  void _scrollListener() {
    // Get the current page based on the controller's offset
    currentPage = _pageController.page?.round() ?? 0;

    // DateTime firstDayOfNextMonth = DateTime(
    //     Provider.of<CalendarProvider>(context, listen: false).selectedDatetime!.year,
    //     Provider.of<CalendarProvider>(context, listen: false).selectedDatetime!.month + 1, 1);
    //
    // Provider.of<CalendarProvider>(context, listen: false).getFirstDayNameOfMonth(firstDayOfNextMonth);
    // Provider.of<CalendarProvider>(context, listen: false).getDateInfo(firstDayOfNextMonth);

    // Execute your desired function after every scroll
    print('Scrolled to page $currentPage');
  }



  @override
  void dispose() {
    // Dispose of the PageController when the widget is no longer used
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarProvider>(
        builder: (context, calendarProvider, child) {

          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.3),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {

              },
              tooltip: 'Increment',
              child: const Icon(Icons.edit),
            ),
            body: PageView.builder(
              controller: _pageController, // Attach the PageController
              scrollDirection: Axis.vertical,
              itemCount: calendarProvider.dateList!.length,
              itemBuilder: (BuildContext context, int index) {

                final monthName = DateFormat.MMMM().format(calendarProvider.dateList![index]);

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          const SizedBox(width: 12),

                          Text('${monthName} ${calendarProvider.dateList![index].year}',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 22,
                                  fontWeight: FontWeight.w500)),

                          const Spacer(),

                          Icon(Icons.access_time, size: 30),
                          const SizedBox(width: 15),
                          InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(

                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
                                                ShiftsScreen()));
                                          },
                                          child: Row(
                                            children: [
                                              Text('Sezione Turni', style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500
                                              )),

                                              const Spacer(),

                                              Icon(Icons.arrow_forward_ios_rounded, size: 20)
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(top: 7, bottom: 7),
                                          child: Divider(),
                                        ),

                                        Row(
                                          children: [
                                            Text('indennità de servicio', style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500
                                            )),

                                            const Spacer(),

                                            Icon(Icons.arrow_forward_ios_rounded, size: 20)
                                          ],
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(top: 7, bottom: 7),
                                          child: Divider(),
                                        ),

                                        Row(
                                          children: [
                                            Text('Allarme Promemoria', style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500
                                            )),

                                            const Spacer(),

                                            Icon(Icons.arrow_forward_ios_rounded, size: 20)
                                          ],
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(top: 7, bottom: 7),
                                          child: Divider(),
                                        ),

                                        Row(
                                          children: [
                                            Text('Assenze/Altro', style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500
                                            )),

                                            const Spacer(),

                                            Icon(Icons.arrow_forward_ios_rounded, size: 20)
                                          ],
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(top: 7, bottom: 7),
                                          child: Divider(),
                                        ),

                                        Row(
                                          children: [
                                            Text('Buoni Pasto', style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500
                                            )),

                                            const Spacer(),

                                            Icon(Icons.arrow_forward_ios_rounded, size: 20)
                                          ],
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(top: 7, bottom: 7),
                                          child: Divider(),
                                        ),

                                        Row(
                                          children: [
                                            Text('Modifica turno di lavaro', style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500
                                            )),

                                            const Spacer(),

                                            Icon(Icons.arrow_forward_ios_rounded, size: 20)
                                          ],
                                        ),

                                      ],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                                    ),
                                  ),
                                );
                              },
                              child: Icon(Icons.menu, size: 30)),
                          // InkWell(
                          //     onTap: () {
                          //       DateTime firstDayOfNextMonth = DateTime(calendarProvider.selectedDatetime!.year,
                          //           calendarProvider.selectedDatetime!.month + 1, 1);
                          //       calendarProvider.getFirstDayNameOfMonth(firstDayOfNextMonth);
                          //       calendarProvider.getDateInfo(firstDayOfNextMonth);
                          //     },
                          //     child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54)),
                          const SizedBox(width: 12),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0))),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              /// DAYS
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.05,
                                child:
                                Center(
                                    child:
                                    GridView.extent(
                                      primary: false,
                                      crossAxisSpacing: 0,
                                      mainAxisSpacing: 0,
                                      maxCrossAxisExtent: 60.0,
                                      childAspectRatio: (1.5 / 1.1),
                                      padding: const EdgeInsets.only(left: 4, right: 4),
                                      children: <Widget>[
                                        for(int i = 0; i <  calendarProvider.daysList.length ; i++)
                                          Consumer<CalendarProvider>(
                                              builder: (context, calendarProvider, child) {
                                                String _dayName = '';
                                                if(calendarProvider.daysList[i] == 'Sun'){
                                                  _dayName = 'D';
                                                }else if(calendarProvider.daysList[i] == 'Mon'){
                                                  _dayName = 'L';
                                                }
                                                else if(calendarProvider.daysList[i] == 'Tue'){
                                                  _dayName = 'M';
                                                }
                                                else if(calendarProvider.daysList[i] == 'Wed'){
                                                  _dayName = 'M';
                                                }
                                                else if(calendarProvider.daysList[i] == 'Thu'){
                                                  _dayName = 'G';
                                                }
                                                else if(calendarProvider.daysList[i] == 'Fri'){
                                                  _dayName = 'V';
                                                }
                                                else if(calendarProvider.daysList[i] == 'Sat'){
                                                  _dayName = 'S';
                                                }
                                                return Container(
                                                  // color: Colors.blueAccent,
                                                  child: Center(
                                                    child: Text('${_dayName}',
                                                        style: const TextStyle(fontSize: 20, color: Colors.black54)),
                                                  ),
                                                );
                                              }
                                          ),
                                      ],
                                    )
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.74,
                                child:
                                Center(
                                    child:
                                    GridView.extent(
                                      primary: false,
                                      crossAxisSpacing: 0,
                                      mainAxisSpacing: 0,
                                      maxCrossAxisExtent: 60.0,
                                      childAspectRatio: (1 / 1.9),
                                      padding: const EdgeInsets.only(left: 4, right: 4, top: 0),
                                      children: <Widget>[
                                        for(int i = 0; i <  calendarProvider.monthDaysNumber! ; i++)
                                          i < 0?
                                          const SizedBox() :

                                          Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  top: BorderSide(
                                                    color: Colors.black26, // Define the color of the top border
                                                    width: 0.5, // Define the width of the top border
                                                  ),
                                                  right: BorderSide(
                                                    color: Colors.black26, // Define the color of the top border
                                                    width: 0.5, // Define the width of the top border
                                                  ),
                                                ),
                                              ),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Align(
                                                        alignment:Alignment.topLeft,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 4),
                                                          child: Text('${i + 1}',
                                                              style: TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.8))),
                                                        )),

                                                    i == 2 || i == 16 || i == 27 ?
                                                    Container(
                                                      width: 52,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      child: Center(
                                                        child: Text('Sera',
                                                            style: TextStyle(fontSize: 14, color: Colors.white)),
                                                      ),
                                                    ): SizedBox(),

                                                    const SizedBox(height: 4),

                                                    i == 2 || i == 8 || i == 11 ?
                                                    Container(
                                                      width: 52,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context).primaryColor,
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      child: Center(
                                                        child: Icon(Icons.notifications_active, color: Colors.white, size: 18),
                                                      ),
                                                    ): SizedBox(),

                                                    const SizedBox(height: 4),

                                                    i == 2 || i == 22 || i == 11 ?
                                                    Container(
                                                      width: 52,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                        color: Colors.orange,
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      child:  Center(
                                                        child: Text('Stra',
                                                            style: TextStyle(fontSize: 14, color: Colors.white)),
                                                      ),
                                                    ): SizedBox(),

                                                    const SizedBox(height: 4),

                                                    i == 2 || i == 22 || i == 11 ?
                                                    Container(
                                                      width: 52,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      child:  Center(
                                                        child: Text('Nota',
                                                            style: TextStyle(fontSize: 14, color: Colors.white)),
                                                      ),
                                                    ): SizedBox(),
                                                  ],
                                                ),
                                              )
                                          ),
                                      ],
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        });

  }
}
