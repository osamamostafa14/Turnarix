import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/utill/images.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/base/custom_text_field.dart';
import 'package:turnarix/view/screens/shifts/allowance_screen.dart';
import 'package:turnarix/view/screens/shifts/widgets/break_times_widget.dart';
import 'package:turnarix/view/screens/shifts/widgets/service_times_widget.dart';


class AddIntervalScreen extends StatefulWidget {
  final Map<String, dynamic>? interval;
  AddIntervalScreen({@required this.interval});

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

  }

  @override
  void dispose() {
    _titleController!.dispose();
    _iconTitleController!.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext? context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('${widget.interval!['name']}',
            style:
            TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 20)),
        centerTitle: true,
        backgroundColor: Theme.of(context!).scaffoldBackgroundColor,
        elevation: 0.2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black54,
          onPressed: () =>  Navigator.pop(context),
        ),
      ),
      body: Consumer<ShiftsProvider>(
        builder: (context, shiftsProvider, child) {



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



          return SafeArea(
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
                                height: shiftsProvider.iconsVisible? 320: 80,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                    color: Theme.of(context).primaryColor.withOpacity(0.3)
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
                                                      shiftsProvider.setShiftName(_titleController!.text);
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
                                          Text('Nome del turno', style:
                                          TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 15)),
                                          Spacer(),
                                          Text('${shiftsProvider.shiftName!=null? '${shiftsProvider.shiftName}' : 'Aggiungi+'}', style:
                                          TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 15)),
                                          const SizedBox(width: 12),
                                        ],
                                      ),
                                    ),

                                    Divider(),

                                    InkWell(
                                      onTap: () {
                                      shiftsProvider.updateIconsVisibility();
                                      },
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 8),
                                          Text('Icono titolo', style:
                                          TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 15)),
                                          Spacer(),
                                          Icon(shiftsProvider.icon!=null? shiftsProvider.icon!['icon']: Icons.sunny,
                                              color: shiftsProvider.iconColor),
                                          const SizedBox(width: 12),
                                        ],
                                      ),
                                    ),

                                    shiftsProvider.iconsVisible?
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
                                                      shiftsProvider.setIcon(_iconsList[i]);
                                                    },
                                                    child: Container(
                                                        height: 80,
                                                        width: 80,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(80),
                                                          border: Border.all(color: shiftsProvider.icon!=null? shiftsProvider.icon!['name'] == _iconsList[i]['name']?
                                                          Theme.of(context).primaryColor : Colors.black54:  Colors.black54, width: 1),
                                                        ),
                                                        child: Center(
                                                          child: Icon(_iconsList[i]['icon'], size: 25,
                                                          color: shiftsProvider.icon!=null? shiftsProvider.icon!['name'] == _iconsList[i]['name']?
                                                          Theme.of(context).primaryColor : Colors.black87:  Colors.black87),
                                                        )
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          )
                                      ),
                                    ): SizedBox(),

                                    shiftsProvider.iconsVisible?
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
                                                          pickerColor: shiftsProvider.iconColor,
                                                          onColorChanged: (Color color){ //on color picked
                                                            shiftsProvider.setIconColor(color);
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
                                        )): SizedBox()

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        ServiceTimesWidget(interval: widget.interval),

                        const SizedBox(height: 15),
                        Divider(),

                        BreakTimesWidget(interval: widget.interval),

                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Divider(),
                        ),

                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                                AllowanceScreen(interval: widget.interval)));
                          },
                          child: Row(
                            children: [
                              Text('Indennità personalizzate', style: TextStyle(fontSize: 16)),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios_outlined, color: Colors.black54, size: 20)
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Divider(),
                        ),

                        Row(
                          children: [
                            Text('Straordinario programmato', style: TextStyle(fontSize: 16)),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios_outlined, color: Colors.black54, size: 20)
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

