import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/helper/helpers.dart';
import 'package:turnarix/data/model/shifts/intervals_model.dart';
import 'package:turnarix/provider/calendar_provider.dart';
import 'package:turnarix/provider/saved_shift_provider.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/utill/images.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/base/custom_text_field.dart';
import 'package:turnarix/view/screens/calendar/calendar_screen.dart';
import 'package:turnarix/view/screens/calendar/employee/request_shift_exchange_screen.dart';
import 'package:turnarix/view/screens/shifts/allowance_screen.dart';
import 'package:turnarix/view/screens/shifts/planned_extraordinary_screen.dart';
import 'package:turnarix/view/screens/shifts/widgets/break_times_widget.dart';
import 'package:turnarix/view/screens/shifts/widgets/service_times_widget.dart';

class EmployeeIntervalScreen extends StatefulWidget {
  final IntervalModel? interval;
  final int? employeeId;
  final int? calendarShiftId;
  final bool fromRequestsScreen;
  EmployeeIntervalScreen({@required this.interval, @required this.employeeId, @required this.calendarShiftId,
   this.fromRequestsScreen = false});

  @override
  State<EmployeeIntervalScreen> createState() => _EmployeeIntervalScreenState();
}

class _EmployeeIntervalScreenState extends State<EmployeeIntervalScreen> {

  FocusNode _titleFocus = FocusNode();
  TextEditingController? _titleController;

  FocusNode _iconTitleFocus = FocusNode();
  TextEditingController? _iconTitleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _iconTitleController = TextEditingController();

    _titleController!.text = widget.interval!.title!=null? widget.interval!.title! : '';

  }

  @override
  void dispose() {
    _titleController!.dispose();
    _iconTitleController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext? context) {
    return
      Consumer<SavedShiftProvider>(
          builder: (context, shiftProvider, child) {

            List<Map<String, dynamic>> _iconsList = [
              {
                'id': 1,
                'name': 'sunny',
                'icon': Icons.sunny
              },
              {
                'id': 2,
                'name': 'coffee',
                'icon': Icons.coffee
              },
              {
                'id': 3,
                'name': 'sunny_snowing',
                'icon': Icons.sunny_snowing
              },
              {
                'id': 4,
                'name': 'nightlight_round_outlined',
                'icon': Icons.nightlight_round_outlined
              },
              {
                'id': 5,
                'name': 'home',
                'icon': Icons.home
              },
              {
                'id': 6,
                'name': 'phone',
                'icon': Icons.phone
              },
              {
                'id': 7,
                'name': 'work',
                'icon': Icons.work
              },
              {
                'id': 8,
                'name': 'menu_book_outlined',
                'icon': Icons.menu_book_outlined
              },
              {
                'id': 9,
                'name': 'library_books_rounded',
                'icon': Icons.library_books_rounded
              },
              {
                'id': 10,
                'name': 'access_time_outlined',
                'icon': Icons.access_time_outlined
              },
              {
                'id': 11,
                'name': 'add_box_rounded',
                'icon': Icons.add_box_rounded
              },
              {
                'id': 12,
                'name': 'monetization_on',
                'icon': Icons.monetization_on
              },
              {
                'id': 13,
                'name': 'palette',
                'icon': Icons.palette
              },
              {
                'id': 14,
                'name': 'build',
                'icon': Icons.build
              },
              {
                'id': 15,
                'name': 'sports_volleyball',
                'icon': Icons.sports_volleyball
              },
              {
                'id': 16,
                'name': 'star',
                'icon': Icons.star
              },
              {
                'id': 17,
                'name': 'add_alert',
                'icon': Icons.add_alert
              },
            ];

            String? _title;
            if(shiftProvider.intervalTitle != null){
              _title = shiftProvider.intervalTitle;
            }else{
              if(widget.interval!.title  != null){
                _title = widget.interval!.title;
              }else {
                _title = 'Aggiungi +';
              }
            }

            IconData? _icon;
            String? _iconName;

            if(shiftProvider.icon != null){
              _icon = shiftProvider.icon!['icon'];
              _iconName = shiftProvider.icon!['name'];
            }else{
              if(widget.interval!.iconName != null){
                _iconsList.forEach((element) {
                  if(element['name'] == widget.interval!.iconName){
                    _icon = element['icon'];
                    _iconName = element['name'];
                  }
                });
              }else {
                _icon = Icons.sunny;
                _iconName = 'sunny';
              }
            }

            Color? _iconColor;
            if(shiftProvider.iconColor != null){
              _iconColor = shiftProvider.iconColor;
            }else{
              if(widget.interval!.iconColor != null){
                _iconColor = Color(int.parse(widget.interval!.iconColor!));
              }else {
                _iconColor = const Color(0xFF285bd7);
              }
            }

            Color? _color;
            _color =  widget.interval!.iconColor!=null?
            Color(int.parse(widget.interval!.iconColor!)):
            Colors.blueAccent;

            if(widget.interval!.iconName != null){
              Helpers.iconsList().forEach((element) {
                if(element['name'] == widget.interval!.iconName){
                  _icon = element['icon'];
                  _iconName = element['name'];
                }
              });
            }else {
              _icon = Icons.sunny;
              _iconName = 'sunny';
            }

            Color? finalColor;
            String colorValue = _iconColor!.value.toRadixString(16);
            String colorHex = '0xFF${colorValue.substring(2)}';
            finalColor = Color(int.parse(colorHex));
            // if(shiftProvider.icon != null){
            //   _iconName = shiftProvider.icon!['name'];
            // }else{
            //   if(widget.interval!.iconName  != null){
            //     _iconName = widget.interval!.iconName;
            //   }else {
            //     _iconName = 'sunny';
            //   }
            // }
            void showSuccessSnack() {
              showCustomSnackBar('La sezione dell\'intervallo è stata aggiornata con successo', context, isError:false);
            }

            return Scaffold(
              backgroundColor: ColorResources.BG_SECONDRY,
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(widget.interval!.name!=null? widget.interval!.name! : '',
                        style:
                        const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(width: 12),
                    Icon(_icon,
                        color: _color),
                    const SizedBox(width: 12),
                  ],
                ),
                centerTitle: true,
                backgroundColor: ColorResources.BG_SECONDRY,
                elevation: 0.2,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () =>  Navigator.pop(context),
                ),
              ),
              bottomNavigationBar:
              shiftProvider.intervalLoading?
              Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  )):
                  widget.fromRequestsScreen? const SizedBox() :
              Container(
                height: 70,
                child: Padding(
                  padding: EdgeInsets.only(left: 15, top: 8, right: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                                RequestShiftExchangeScreen(employeeId: widget.employeeId,
                                    interval: widget.interval, calendarShiftId: widget.calendarShiftId)));
                          },
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text('Richiedere turno di cambio', style: TextStyle(color: Colors.white, fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: ColorResources.BG_SECONDRY,
                  border: Border(
                    top: BorderSide(
                      color: Colors.white70,
                      width: 0.7,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // Shadow color
                      blurRadius: 4.0, // Spread of the shadow
                      offset: Offset(0, -2), // Offset in the vertical direction (negative value for top shadow)
                    ),
                  ],
                ),
              ),

              body: SafeArea(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    physics: BouncingScrollPhysics(),
                    child: Center(
                      child: SizedBox(
                        width: 1170,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const SizedBox(height: 20),

                            // const Padding(
                            //   padding:  EdgeInsets.only(top: 15, bottom: 8),
                            //   child: Divider(color: Colors.white60),
                            // ),

                            InkWell(
                              onTap: () {
                                shiftProvider.updateServiceTimesVisibility();
                              },
                              child:  Row(
                                children: [
                                  Text('Service times', style: TextStyle(color: Colors.white, fontSize: 17,
                                      fontWeight: FontWeight.w500)),
                                  Spacer(),

                                  shiftProvider.serviceTimesVisible?
                                  Icon(Icons.arrow_drop_up, color: Colors.white, size: 30):
                                  Icon(Icons.arrow_drop_down, color: Colors.white, size: 30)
                                ],
                              ),
                            ),


                            shiftProvider.serviceTimesVisible?
                            ServiceTimesWidget(interval: widget.interval, fromEmployee: true): const SizedBox(),

                            const Padding(
                              padding:  EdgeInsets.only(top: 8, bottom: 8),
                              child: Divider(color: Colors.white60),
                            ),

                            InkWell(
                              onTap: () {
                                shiftProvider.updateBreaksVisibility();
                              },
                              child: Row(
                                children: [
                                  Text('Break times', style: TextStyle(color: Colors.white, fontSize: 17,
                                      fontWeight: FontWeight.w500)),
                                  Spacer(),

                                  shiftProvider.breaksVisible?
                                  Icon(Icons.arrow_drop_up, color: Colors.white, size: 30):
                                  Icon(Icons.arrow_drop_down, color: Colors.white, size: 30)
                                ],
                              ),
                            ),

                            shiftProvider.breaksVisible?
                            BreakTimesWidget(interval: widget.interval, fromEmployee: true): const SizedBox(),

                            const Padding(
                              padding:  EdgeInsets.only(top: 8, bottom: 8),
                              child: Divider(color: Colors.white60),
                            ),

                            InkWell(
                              onTap: () {
                                if(widget.interval!.allowances != null){
                                  if(widget.interval!.allowances!.length == 0){
                                    shiftProvider.initAllowance(widget.interval!.id!);
                                  }
                                }else {
                                  if(shiftProvider.extraServiceAllowancesList.length == 0){
                                    shiftProvider.initAllowance(widget.interval!.id!);
                                  }
                                }

                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                                    AllowanceScreen(interval: widget.interval, fromEmployee: true)));
                              },
                              child: const Row(
                                children: [
                                  Text('Indennità personalizzate', style: TextStyle(fontSize: 17, color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                                  Spacer(),
                                  Icon(Icons.arrow_forward_ios_outlined, color: Colors.white, size: 20)
                                ],
                              ),
                            ),

                            const Padding(
                              padding: EdgeInsets.only(top: 8, bottom: 8),
                              child: Divider(color: Colors.white),
                            ),

                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                                    PlannedExtraordinaryScreen(interval: widget.interval, fromEmployee: true)));
                              },
                              child: const Row(
                                children: [
                                  Text('Straordinario programmato', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                                  Spacer(),
                                  Icon(Icons.arrow_forward_ios_outlined, color: Colors.white, size: 20)
                                ],
                              ),
                            ),

                            const Padding(
                              padding: EdgeInsets.only(top: 8, bottom: 8),
                              child: Divider(color: Colors.white),
                            ),

                            Row(
                              children: [
                                Text('Buono Pasto',
                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white)),

                                const Spacer(),

                                shiftProvider.foodStamps?
                                Icon(Icons.check_circle, color: Colors.green) : Icon(Icons.close, color: Colors.white70)
                              ],
                            ),

                            // SwitchListTile(
                            //   value: shiftProvider.foodStamps,
                            //   contentPadding: const EdgeInsets.all(0),
                            //   onChanged: (bool isActive) {
                            //     shiftProvider.updateFoodStamps();
                            //   },
                            //   title: const Text('Buono Pasto',
                            //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
                            //   activeColor: Theme.of(context).primaryColor,
                            //   inactiveTrackColor: Colors.grey,
                            // ),

                            const SizedBox(height: 100),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
  }
}

