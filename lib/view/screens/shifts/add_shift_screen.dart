import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/helper/date_converter.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/base/custom_text_field.dart';
import 'package:turnarix/view/screens/shifts/add_interval_screen.dart';
import 'package:turnarix/view/screens/shifts/date_time_picker.dart';

class AddShiftScreen extends StatefulWidget {

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Nuovo turno', style:
        TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 20)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black54,
          onPressed: () =>  Navigator.pop(context!),
        ),
      ),
      body: Consumer<ShiftsProvider>(
        builder: (context, shiftsProvider, child) => SafeArea(
          child: Scrollbar(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
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
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                                        Text('${shiftsProvider.shiftName!=null? '${shiftsProvider.shiftName}' : 'Aggiungi+'}', style:
                                        TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 15)),
                                        const SizedBox(width: 12),
                                      ],
                                    ),
                                  ),

                                  // Divider(),
                                  //
                                  // InkWell(
                                  //   onTap: () {
                                  //     shiftsProvider.setShiftSingleDate(DateTime.now().toString());
                                  //     shiftsProvider.setShiftDate(DateTime.now().subtract(const Duration(days: 4)).toString(),
                                  //         DateTime.now().add(const Duration(days: 3)).toString());
                                  //     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                                  //         DateTimePickerScreen()));
                                  //   },
                                  //   child: Row(
                                  //     children: [
                                  //       const SizedBox(width: 8),
                                  //       Text('Data del turno', style:
                                  //       TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 15)),
                                  //       Spacer(),
                                  //       Icon(Icons.calendar_month, size: 24, color: Colors.black54),
                                  //       const SizedBox(width: 4),
                                  //       if(shiftsProvider.isFinalDateRange)
                                  //         Text('${shiftsProvider.finalStartDate!= null? '${DateConverter.formatDayMonthYear(DateTime.parse(shiftsProvider.finalStartDate!))} - ${DateConverter.formatDayMonthYear(DateTime.parse(shiftsProvider.finalEndDate!))}' : '- / - / -'}',
                                  //             style: TextStyle(color: Colors.black54, fontSize: 15))
                                  //       else
                                  //         Text('${shiftsProvider.singleDate!= null?'${DateConverter.formatDayMonthYear(DateTime.parse(shiftsProvider.singleDate!))}': ''}',
                                  //             style: TextStyle(color: Colors.black54, fontSize: 15)),
                                  //       const SizedBox(width: 8),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                    const SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Divider(),
                      ),

                      Text('Intervalli',
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
                                        shiftsProvider.updateUserDayInterval(shiftsProvider.dayIntervals[i]);
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
                                                style: TextStyle(color: Colors.black54, fontSize: 13,
                                            fontWeight: FontWeight.w500)),
                                          )
                                      ),
                                    ),
                                  ),
                              ],
                            )
                        ),
                      ),

                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0),
                        itemCount: shiftsProvider.userDayIntervals!.length,
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
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
                                        AddIntervalScreen(interval: shiftsProvider.userDayIntervals![index])));
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
                                                        shiftsProvider.removeDayInterval(shiftsProvider.userDayIntervals![index]);
                                                      })),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Icon(Icons.delete, color: Colors.black54)),
                                      const SizedBox(width: 30),
                                      Text('#${index + 1}   ${shiftsProvider.userDayIntervals![index]['name']}',
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

