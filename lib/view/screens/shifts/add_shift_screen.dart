import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/model/shifts/intervals_model.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/base/custom_text_field.dart';
import 'package:turnarix/view/screens/shifts/add_interval_screen.dart';
import 'package:turnarix/view/screens/shifts/saved_shift/edit_interval_screen.dart';

class AddShiftScreen extends StatefulWidget {
  final int? shiftId;
  final String? shiftName;
  final bool? isNewShift;
  AddShiftScreen({@required this.shiftId, @required this.shiftName, @required this.isNewShift});
  @override
  State<AddShiftScreen> createState() => _AddShiftScreenState();
}

class _AddShiftScreenState extends State<AddShiftScreen> {

  FocusNode _shiftNameFocus = FocusNode();
  TextEditingController? _shiftNameController;

  @override
  void initState() {
    super.initState();
    _shiftNameController = TextEditingController();
  }

  @override
  void dispose() {
    _shiftNameController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext? context) {
    return
      Consumer<ShiftsProvider>(
        builder: (context, shiftsProvider, child) {
          bool _hasChanges = false;
          if(shiftsProvider.shiftName != widget.shiftName){
            _hasChanges = true;
          }

          if(widget.isNewShift == true){
            if(shiftsProvider.selectedDayIntervals!.length > 0){
              _hasChanges = true;
            }
          }

          void getIntervals() {
            Provider.of<ShiftsProvider>(context, listen: false).getIntervalsList(context, widget.shiftId!, false);
          }
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('${widget.shiftName}', style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 20)),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0.2,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.black54,
                onPressed: () =>  Navigator.pop(context),
              ),
              // actions: [
              //   Center(child: Padding(
              //     padding: const EdgeInsets.only(right: 15),
              //     child: Text('Save', style: TextStyle(fontSize: 19, color: Theme.of(context).primaryColor)),
              //   )),
              // ],
            ),
            // floatingActionButton:
            // _hasChanges == true?
            // FloatingActionButton(
            //   backgroundColor: Theme.of(context).primaryColor,
            //   onPressed: () {
            //     shiftsProvider.addShiftIntervals(context, shiftsProvider.selectedDayIntervals!, widget.shiftId!,
            //         shiftsProvider.shiftName!).then((value) {
            //       shiftsProvider.getShiftsIntervals(context, widget.shiftId!);
            //     });
            //   },
            //   tooltip: 'Salva',
            //   child: const Icon(Icons.check_rounded),
            // ): const SizedBox(),
            body: SafeArea(
              child: Scrollbar(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                  physics: const BouncingScrollPhysics(),
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
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                      color: Theme.of(context).primaryColor.withOpacity(0.3)
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
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
                                                      if(_shiftNameController!.text.isEmpty){
                                                        showCustomSnackBar('il campo del nome è vuoto', context);
                                                      }else{
                                                        Navigator.pop(context);
                                                        shiftsProvider.setShiftName(_shiftNameController!.text);
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
                                            Text('${shiftsProvider.shiftName!=null? '${shiftsProvider.shiftName}' : '${widget.shiftName}'}', style:
                                            TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 15)),
                                            const SizedBox(width: 12),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          const Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Divider(),
                          ),

                          const Text('Intervalli',
                              style: TextStyle(color: Colors.black54, fontSize: 16,
                                  fontWeight: FontWeight.w500)),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.26,
                            child:
                            Center(
                                child:
                                GridView.extent(
                                  padding: const EdgeInsets.all(0),
                                  primary: false,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 0,
                                  maxCrossAxisExtent: 130.0,
                                  childAspectRatio: (2 / 0.9),
                                  children: <Widget>[
                                    for(int i = 0; i <shiftsProvider.dayIntervals.length ; i++)

                                      Padding(
                                        padding: const EdgeInsets.only(right: 8, bottom: 8, top: 8),
                                        child: InkWell(
                                          onTap: () {

                                            shiftsProvider.addDayInterval(IntervalModel(
                                              shiftId: widget.shiftId,
                                              name: shiftsProvider.dayIntervals[i]['name']
                                            ));
                                           // shiftsProvider.updateUserDayInterval(shiftsProvider.dayIntervals[i]);
                                          },
                                          child: Container(
                                              height: 80,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(color: Theme.of(context).primaryColor, width: 1),
                                              ),
                                              child: Center(
                                                child: Text('${shiftsProvider.dayIntervals[i]['name']} +',
                                                    style: const TextStyle(color: Colors.black54, fontSize: 13,
                                                        fontWeight: FontWeight.w500)),
                                              )
                                          ),
                                        ),
                                      ),
                                  ],
                                )
                            ),
                          ),
                         /// SAVED INTERVALS : THAT COMES FROM THE API
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0),
                            itemCount: shiftsProvider.mainDayIntervals!.length,
                            // reverse: true,
                            itemBuilder: (context, index) {

                              return Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 5, top: 8),
                                child:
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // int _count = 0;
                                        // for (int i = 0; i < shiftsProvider.extraServiceTimeList.length; i++) {
                                        //   if(shiftsProvider.extraServiceTimeList[i]['interval_unique_id'] == shiftsProvider.selectedDayIntervals![index]['unique_id']){
                                        //     _count++;
                                        //   }
                                        // }
                                        //
                                        // if(_count == 0){
                                        //   final Random random = Random();
                                        //   shiftsProvider.addExtraServiceTime(
                                        //     {
                                        //       'unique_id': '${DateTime.now().hour.toString()}' '${DateTime.now().minute.toString()}.' '${random.nextInt(10000) + 1}',
                                        //       'start_time': TimeOfDay(hour: 9, minute: 0),
                                        //       'end_time': TimeOfDay(hour: 17, minute: 0),
                                        //     //  'interval_unique_id': shiftsProvider.selectedDayIntervals![index]['unique_id'],
                                        //     },
                                        //   );
                                        // }

                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
                                            EditIntervalScreen(interval: shiftsProvider.mainDayIntervals![index])));
                                      },
                                      child: Row(
                                        children: [
                                          InkWell(
                                              onTap:() {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext? context) {
                                                    return AlertDialog(
                                                      title: Text("Remove this item?",
                                                          style: TextStyle(color: Colors.black87, fontSize: 15)),
                                                      content: Row(
                                                        children: [
                                                          Expanded(child: CustomButton(
                                                              btnTxt: 'No',
                                                              backgroundColor: Colors.black54,
                                                              onTap: () {
                                                                Navigator.pop(context!);
                                                              })),
                                                          const SizedBox(width: 10),
                                                          Expanded(child: CustomButton(btnTxt: 'Yes',
                                                              onTap: () {
                                                                Navigator.pop(context!);
                                                                shiftsProvider.removeDayInterval(shiftsProvider.mainDayIntervals![index]);
                                                              })),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Icon(Icons.delete, color: Colors.black54)),
                                          const SizedBox(width: 30),
                                          Text('#${index + 1}   ${shiftsProvider.mainDayIntervals![index].name}',
                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,
                                                  fontSize: 17)),
                                          Spacer(),
                                          Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54)
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Divider(),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),

                          /// SAVED TEMPORARY
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0),
                            itemCount: shiftsProvider.selectedDayIntervals!.length,
                            // reverse: true,
                            itemBuilder: (context, index) {

                              return Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 5, top: 8),
                                child:
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // int _count = 0;
                                        // for (int i = 0; i < shiftsProvider.extraServiceTimeList.length; i++) {
                                        //   if(shiftsProvider.extraServiceTimeList[i]['interval_unique_id'] == shiftsProvider.selectedDayIntervals![index]['unique_id']){
                                        //     _count++;
                                        //   }
                                        // }
                                        //
                                        // if(_count == 0){
                                        //   final Random random = Random();
                                        //   shiftsProvider.addExtraServiceTime(
                                        //     {
                                        //       'unique_id': '${DateTime.now().hour.toString()}' '${DateTime.now().minute.toString()}.' '${random.nextInt(10000) + 1}',
                                        //       'start_time': TimeOfDay(hour: 9, minute: 0),
                                        //       'end_time': TimeOfDay(hour: 17, minute: 0),
                                        //       'interval_unique_id': shiftsProvider.selectedDayIntervals![index]['unique_id'],
                                        //     },
                                        //   );
                                        // }
                                        //
                                        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
                                        //     AddIntervalScreen(interval: shiftsProvider.selectedDayIntervals![index])));
                                      },
                                      child: Row(
                                        children: [
                                          InkWell(
                                              onTap:() {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext? context) {
                                                    return AlertDialog(
                                                      title: Text("Remove this item?",
                                                          style: TextStyle(color: Colors.black87, fontSize: 15)),
                                                      content: Row(
                                                        children: [
                                                          Expanded(child: CustomButton(
                                                              btnTxt: 'No',
                                                              backgroundColor: Colors.black54,
                                                              onTap: () {
                                                                Navigator.pop(context!);
                                                              })),
                                                          const SizedBox(width: 10),
                                                          Expanded(child: CustomButton(btnTxt: 'Yes',
                                                              onTap: () {
                                                                Navigator.pop(context!);
                                                                shiftsProvider.removeDayInterval(shiftsProvider.selectedDayIntervals![index]);
                                                              })),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Icon(Icons.delete, color: Colors.black54)),
                                          const SizedBox(width: 30),
                                          Text('#${shiftsProvider.mainDayIntervals!.length + (index + 1)}   ${shiftsProvider.selectedDayIntervals![index].name}',
                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,
                                                  fontSize: 17)),
                                          Spacer(),

                                          Icon(Icons.hourglass_empty, color: Colors.orange)
                                         // Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54)
                                        ],
                                      ),
                                    ),

                                    const Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Divider(),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                          shiftsProvider.intervalLoading?
                          Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor),
                              )):
                          shiftsProvider.selectedDayIntervals!.length> 0?
                          Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: CustomButton(btnTxt: 'Salva nuovi intervalli',
                                onTap: () {
                                  shiftsProvider.addShiftIntervals(context, shiftsProvider.selectedDayIntervals!, widget.shiftId!).then((value) => {
                                    getIntervals()
                                  });
                                }),
                          ): const SizedBox(height: 80),
                          const SizedBox(height: 80),
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

