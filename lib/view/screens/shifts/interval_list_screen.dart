import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/helper/helpers.dart';
import 'package:turnarix/data/model/response/response_model.dart';
import 'package:turnarix/data/model/shifts/intervals_model.dart';
import 'package:turnarix/provider/calendar_provider.dart';
import 'package:turnarix/provider/saved_shift_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/screens/shifts/add_interval_screen.dart';
import 'package:turnarix/view/screens/shifts/saved_shift/edit_interval_screen.dart';

class IntervalListScreen extends StatefulWidget {

  @override
  State<IntervalListScreen> createState() => _IntervalListScreenState();
}

class _IntervalListScreenState extends State<IntervalListScreen> {
  FocusNode _shiftNameFocus = FocusNode();
  TextEditingController? _shiftNameController;

  @override
  void initState() {
    super.initState();
    _shiftNameController = TextEditingController();
    Timer(Duration(seconds: 1), () {
      Provider.of<CalendarProvider>(context, listen: false).getShiftIntervals(context);
    });
  }

  @override
  Widget build(BuildContext? context) {
    return Scaffold(
      backgroundColor: ColorResources.BG_SECONDRY,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorResources.BG_SECONDRY,
        elevation: 0.0,
        title: Text('Elenco turni', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () =>  Navigator.pop(context!),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
              AddIntervalScreen()));
        },
        tooltip: 'Add',
        backgroundColor: Theme.of(context!).primaryColor,
        child:  Icon(Icons.add, color: Colors.white),
      ),
      body: Consumer<CalendarProvider>(
        builder: (context, calendarProvider, child) {

          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Center(
                          child: SizedBox(
                            width: 1170,
                            //height:  MediaQuery.of(context).size.height * 0.6,
                            child: Column(
                              children: [
                                const SizedBox(height: 20),

                                ListView.builder(
                                 // padding: const EdgeInsets.all(6),
                                  itemCount: calendarProvider.intervalList.length,
                                  physics: const NeverScrollableScrollPhysics(),
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

                                    notRemovedDialog() {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: Text('Qualcosa è andato storto, Articolo non rimosso!'),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                                          ),
                                        ),
                                      );
                                    }

                                    deleteInterval() async {
                                      Navigator.pop(context);
                                      ResponseModel _response = await  Provider.of<SavedShiftProvider>(context, listen: false)
                                          .removeSavedInterval(context, _interval.id!);
                                      if(_response.isSuccess){
                                        showCustomSnackBar('Deleted successfully', context, isError: false);
                                        calendarProvider.getShiftIntervals(context);
                                      }else{
                                        notRemovedDialog();
                                      }
                                    }
                                    return
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20, right: 20),
                                            child: InkWell(
                                              onTap:(){
                                                showDialog(
                                                  context: context,
                                                  builder: (_) => AlertDialog(
                                                    backgroundColor: ColorResources.BG_SECONDRY,
                                                    content: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(context);
                                                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
                                                                EditIntervalScreen(interval: _interval)));
                                                          },
                                                          child: const Row(
                                                            children: [
                                                              Text('Edit', style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w500
                                                              )),

                                                              Spacer(),

                                                              Icon(Icons.edit, size: 20, color: Colors.white70)
                                                            ],
                                                          ),
                                                        ),

                                                        const Padding(
                                                          padding:  EdgeInsets.only(top: 7, bottom: 7),
                                                          child: Divider(),
                                                        ),

                                                        InkWell(
                                                          onTap: () {
                                                            showDialog(
                                                              context: context,
                                                              builder: (_) => AlertDialog(
                                                                backgroundColor: ColorResources.BG_SECONDRY,
                                                                title: Text('Sei sicuro?', style: TextStyle(color: Colors.white)),
                                                                content: Text('Vuoi annullare la richiesta?',style: TextStyle(color: Colors.white)),
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
                                                                                  deleteInterval();
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
                                                          child: const Row(
                                                            children: [
                                                              Text('Remove', style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w500
                                                              )),

                                                              Spacer(),

                                                              Icon(Icons.delete, size: 20, color: Colors.white70)
                                                            ],
                                                          ),
                                                        ),

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

                                                  Icon(_icon, color:_color),

                                                  const SizedBox(width: 30),

                                                  Text('${_interval.name}',
                                                      style: TextStyle(color: Colors.white, fontSize: 17)),

                                                  const Spacer(),

                                                  Icon(Icons.menu, color: Colors.white70),
                                                ],
                                              ),
                                            ),
                                          ),

                                          const  Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child:  Divider(color: Colors.white),
                                          )
                                        ],
                                      );
                                  },
                                ),
                                const SizedBox(height: 8),

                                // shiftsProvider.bottomShiftsLoading?
                                // Column(
                                //   children: [
                                //     SizedBox(height: 10),
                                //     Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
                                //   ],
                                // ) :
                                // shiftsLength !< totalSize!?
                                // Center(child:
                                // GestureDetector(
                                //     onTap: () {
                                //       String offset = shiftsProvider.shiftsOffset ?? '';
                                //       int offsetInt = int.parse(offset) + 1;
                                //       print('$offset -- $offsetInt');
                                //       shiftsProvider.showBottomServicesLoader();
                                //       shiftsProvider.getShiftslist(context, offsetInt.toString());
                                //     },
                                //     child: Text('Caricare di più',style: TextStyle(color: Theme.of(context).primaryColor,
                                //         fontSize: 16))))
                                //     : const SizedBox(),

                                const SizedBox(height: 20)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

}

