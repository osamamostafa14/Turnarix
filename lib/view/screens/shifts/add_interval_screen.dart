import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
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
import 'package:turnarix/view/screens/shifts/allowance_screen.dart';
import 'package:turnarix/view/screens/shifts/new_allowance_screen.dart';
import 'package:turnarix/view/screens/shifts/planned_extraordinary_screen.dart';
import 'package:turnarix/view/screens/shifts/voucher/voucher_screen.dart';
import 'package:turnarix/view/screens/shifts/widgets/break_times_widget.dart';
import 'package:turnarix/view/screens/shifts/widgets/new_break_times_widget.dart';
import 'package:turnarix/view/screens/shifts/widgets/new_service_times_widget.dart';
import 'package:turnarix/view/screens/shifts/widgets/service_times_widget.dart';

class AddIntervalScreen extends StatefulWidget {

  @override
  State<AddIntervalScreen> createState() => _AddIntervalScreenState();
}

class _AddIntervalScreenState extends State<AddIntervalScreen> {

  FocusNode _titleFocus = FocusNode();
  TextEditingController? _titleController;

  FocusNode _iconTitleFocus = FocusNode();
  TextEditingController? _iconTitleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _iconTitleController = TextEditingController();

    Timer(Duration(seconds: 0), () {
      Provider.of<ShiftsProvider>(context, listen: false).getShiftslist(context);
    });

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
      Consumer<ShiftsProvider>(
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
            if(shiftProvider.newIntervalTitle != null){
              _title = shiftProvider.newIntervalTitle;
            }else{
              _title = 'Aggiungi +';
            }

            IconData? _icon;
            String? _iconName;

            if(shiftProvider.icon != null){
              _icon = shiftProvider.icon!['icon'];
              _iconName = shiftProvider.icon!['name'];
            }else{
              _icon = Icons.sunny;
              _iconName = 'sunny';
            }

            Color? _iconColor;
            if(shiftProvider.iconColor != null){
              _iconColor = shiftProvider.iconColor;
            }else{
              _iconColor = const Color(0xFF285bd7);
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
              Provider.of<ShiftsProvider>(context, listen: false).getShiftslist(context);
              showCustomSnackBar('La sezione dell\'intervallo è stata aggiornata con successo', context, isError:false);
            }

            IntervalModel _interval = IntervalModel(
              id: 0,
              shiftId: 0,
            );

            return Scaffold(
              backgroundColor: ColorResources.BG_SECONDRY,
              appBar: AppBar(
                title: const Text('Nuovo intervallo',
                    style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 20)),
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
              Container(
                height: 70,
                child: Padding(
                  padding: EdgeInsets.only(left: 15, top: 8, right: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text('non salvare le modifiche?'),
                                actions: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: CustomButton(btnTxt: 'No',
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),

                                        const SizedBox(width: 5),

                                        Expanded(
                                          child: CustomButton(btnTxt: 'SÌ',
                                            onTap: () {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: ColorResources.BACK_BUTTON,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text('Indietro', style: TextStyle(color: Colors.white, fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Expanded(
                        child: InkWell(
                          onTap: (){
                            if(_titleController!.text.isEmpty){
                              showCustomSnackBar('il campo del titolo è obbligatorio', context);
                            }else{
                              shiftProvider.storeNewShiftIntervalInfo(context,
                                  IntervalModel(
                                      title: _titleController!.text.trim(),
                                      iconName: _iconName,
                                      iconColor: colorHex.toString(),
                                      foodStamp: shiftProvider.foodStamps? 1 : 0,
                                      services: shiftProvider.selectedServiceTimeList,
                                      breaks: shiftProvider.selectedBreakList,
                                      allowances: shiftProvider.extraServiceAllowancesList,
                                      extraordinaries: shiftProvider.extraordinaryList,
                                    vouchers: shiftProvider.vouchers
                                  )).then((value) {
                                shiftProvider.getIntervalsList(context, 0, false);
                                Provider.of<CalendarProvider>(context, listen: false).getCalendarShifts(context).then((value) {
                                  //  print('success calendars 2: ${Provider.of<CalendarProvider>(context, listen: false).calendarInfoModels[6].calendarShifts![0].shift!.intervals![0].title}');
                                  Navigator.pop(context);
                                });
                                showSuccessSnack();
                              });
                            }
                          },
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text('Salva', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
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
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: shiftProvider.iconsVisible? 320: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                      color: ColorResources.BORDER_COLOR.withOpacity(0.3),
                                      border: Border.all(width: 1, color: ColorResources.BORDER_COLOR),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(height: 10),

                                        InkWell(
                                          onTap: () {
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
                                                        if(_titleController!.text.isEmpty){
                                                          showCustomSnackBar('il campo del titolo è obbligatorio', context);
                                                        }else{
                                                          Navigator.pop(context);
                                                          shiftProvider.setNewIntervalTitle(_titleController!.text);
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
                                          },
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 8),
                                              const Text('Titolo', style:
                                              TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 15)),
                                              const Spacer(),
                                              Text('${_title}', style:
                                              const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500,
                                                  fontSize: 15)),
                                              const SizedBox(width: 12),
                                            ],
                                          ),
                                        ),

                                        const Divider(),

                                        InkWell(
                                          onTap: () {
                                            shiftProvider.updateIconsVisibility();
                                          },
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 8),
                                              const Text('Icono titolo', style:
                                              TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 15)),
                                              const Spacer(),
                                              Icon(_icon,
                                                  color: finalColor),
                                              const SizedBox(width: 12),
                                            ],
                                          ),
                                        ),

                                        shiftProvider.iconsVisible?
                                        SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.23,
                                          child:
                                          Center(
                                              child:
                                              GridView.extent(
                                                padding: const EdgeInsets.all(14),
                                                primary: false,
                                                crossAxisSpacing: 0,
                                                mainAxisSpacing: 0,
                                                maxCrossAxisExtent: 50.0,
                                                childAspectRatio: (1 / 1.15),
                                                children: <Widget>[
                                                  for(int i = 0; i < _iconsList.length ; i++)
                                                    Padding(
                                                      padding: const EdgeInsets.only(right: 8, bottom: 8, top: 8),
                                                      child: InkWell(
                                                        onTap: () {
                                                          shiftProvider.setNewIcon(_iconsList[i]);
                                                        },
                                                        child: Container(
                                                            height: 80,
                                                            width: 80,
                                                            decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(80),
                                                              border: Border.all(color: _iconName == _iconsList[i]['name']?
                                                              Theme.of(context).primaryColor : Colors.black54, width: 1),
                                                            ),
                                                            child: Center(
                                                              child: Icon(_iconsList[i]['icon'], size: 25,
                                                                  color: _iconName == _iconsList[i]['name']?
                                                                  Theme.of(context).primaryColor : Colors.black87),
                                                            )
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              )
                                          ),
                                        ): SizedBox(),

                                        shiftProvider.iconsVisible?
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 14),
                                              child: InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (_) => AlertDialog(
                                                        content: Container(
                                                          height: 220,
                                                          width: 220,
                                                          child: Container(
                                                            height: 150,
                                                            width: 150,
                                                            child: BlockPicker(
                                                              pickerColor: finalColor!,
                                                              onColorChanged: (Color color){ //on color picked
                                                                shiftProvider.setNewIconColor(color);
                                                              },
                                                              // colorHistory: colorHistory,
                                                            ),
                                                          ),
                                                        ),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Image.asset(Images.color_picker_icon, height: 50)),
                                            )): const SizedBox()

                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 15),

                            const Padding(
                              padding:  EdgeInsets.only(top: 8, bottom: 8),
                              child: Divider(color: Colors.white60),
                            ),

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
                            NewServiceTimesWidget(interval: _interval): const SizedBox(),

                            const Padding(
                              padding:  EdgeInsets.only(top: 8, bottom: 8),
                              child: Divider(color: Colors.white60),
                            ),

                            InkWell(
                              onTap: () {
                                shiftProvider.updateBreaksVisibility();
                              },
                              child:  Row(
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
                            NewBreakTimesWidget(interval: _interval): const SizedBox(),

                            const Padding(
                              padding:  EdgeInsets.only(top: 8, bottom: 8),
                              child: Divider(color: Colors.white60),
                            ),

                            InkWell(
                              onTap: () {
                                print('test 1');
                                if(shiftProvider.extraServiceAllowancesList.length == 0){
                                  print('test 2');
                                  shiftProvider.initAllowance(0);
                                }
                                print('test 3 ${shiftProvider.extraServiceAllowancesList[0].name}');
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                                    NewAllowanceScreen(interval: _interval)));
                              },
                              child: const Row(
                                children: [
                                  Text('Indennità personalizzate', style: TextStyle(fontSize: 16, color: Colors.white,
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
                                    PlannedExtraordinaryScreen(interval: _interval, isNew: true)));
                              },
                              child: const Row(
                                children: [
                                  Text('Straordinario programmato', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,
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

                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                                    VoucherScreen(interval: _interval, isNew: true)));
                              },
                              child: const Row(
                                children: [
                                  Text('Buono Pasto', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,
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

                            SwitchListTile(
                              value: shiftProvider.foodStamps,
                              contentPadding: const EdgeInsets.all(0),
                              onChanged: (bool isActive) {
                                shiftProvider.updateFoodStamps();
                              },
                              title: const Text('Buono Pasto',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
                              activeColor: Theme.of(context).primaryColor,
                              inactiveTrackColor: Colors.grey,
                            ),

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

