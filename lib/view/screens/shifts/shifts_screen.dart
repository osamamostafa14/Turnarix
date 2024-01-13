import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/model/response/response_model.dart';
import 'package:turnarix/data/model/shifts/shift_model.dart';
import 'package:turnarix/provider/auth_provider.dart';
import 'package:turnarix/provider/saved_shift_provider.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/utill/images.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/base/custom_text_field.dart';
import 'package:turnarix/view/screens/shifts/add_shift_screen.dart';
import 'package:turnarix/view/screens/shifts/saved_shift/edit_shift_screen.dart';

class ShiftsScreen extends StatefulWidget {

  @override
  State<ShiftsScreen> createState() => _ShiftsScreenState();
}

class _ShiftsScreenState extends State<ShiftsScreen> {
  FocusNode _shiftNameFocus = FocusNode();
  TextEditingController? _shiftNameController;

  @override
  void initState() {
    super.initState();
    _shiftNameController = TextEditingController();
  }


  @override
  Widget build(BuildContext? context) {
    return Scaffold(
      backgroundColor: ColorResources.COLOR_BACKGROUND,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorResources.COLOR_BACKGROUND,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black87,
          onPressed: () =>  Navigator.pop(context!),
        ),
      ),
      body: Consumer<ShiftsProvider>(
        builder: (context, shiftsProvider, child) {
          void _newShift() async {
            ResponseModel _response = await shiftsProvider.addNewShift(context, _shiftNameController!.text.trim());
            if(_response.isSuccess){
              print('success here 2');
              shiftsProvider.setShiftName(_shiftNameController!.text);
              shiftsProvider.getShiftsIntervals(context, shiftsProvider.shiftId!);
              shiftsProvider.initPageOne();

              Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
                  AddShiftScreen(shiftId: shiftsProvider.shiftId, shiftName: _shiftNameController!.text, isNewShift: true)));
            }
          }

          int? shiftsLength;
          int? totalSize;
          if(shiftsProvider.shiftsList != null){
            shiftsLength = shiftsProvider.shiftsList!.length;
            totalSize = shiftsProvider.totalShiftsSize ?? 0;
          }
          return SafeArea(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE),
                  child: Text('Sezione',  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 40,
                      fontWeight: FontWeight.w500
                  )),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE, bottom: Dimensions.PADDING_SIZE_LARGE),
                  child: Text('Turni',  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 40,
                      fontWeight: FontWeight.w500
                  )),
                ),

                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.65,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Center(
                              child: SizedBox(
                                width: 1170,
                                //height:  MediaQuery.of(context).size.height * 0.6,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 60),

                                    ListView.builder(
                                      padding: const EdgeInsets.all(6),
                                      itemCount: shiftsProvider.shiftsList!.length,
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        ShiftModel _shift = shiftsProvider.shiftsList![index];
                                        return
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 8),
                                            child: Row(
                                              children: [
                                                const SizedBox(width: 15),

                                                Image.asset(Images.day_icon, height: 32, color: Theme.of(context).primaryColor),

                                                Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 16, right: 30, bottom: 10),
                                                      child: InkWell(
                                                        onTap:(){
                                                          Provider.of<SavedShiftProvider>(context, listen: false).resetValues();
                                                          Provider.of<SavedShiftProvider>(context, listen: false).setSelectedShift(_shift);
                                                          Provider.of<SavedShiftProvider>(context, listen: false).getIntervalsList(context, _shift.id!, true);
                                                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
                                                              EditShiftScreen(shift: _shift)));
                                                        },
                                                        child: Container(
                                                          height: 98,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(25),
                                                            boxShadow: [BoxShadow(
                                                              color: Colors.grey[200]!,
                                                              blurRadius: 5, spreadRadius: 2,
                                                            )],
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(18.0),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text('${_shift.shiftName}' ,
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: TextStyle(
                                                                        color: Colors.black87,
                                                                        fontSize: 20,
                                                                        fontWeight: FontWeight.w500
                                                                    )),

                                                                const SizedBox(height: 10)
                                                                ,
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    Text('14 Oct 23' ,
                                                                        style: TextStyle(
                                                                            color: Colors.black54,
                                                                            fontSize: 18,
                                                                            fontWeight: FontWeight.normal
                                                                        )),

                                                                    const Spacer(),

                                                                    Icon(CupertinoIcons.heart, size: 25),

                                                                    const SizedBox(width: 18),

                                                                    Icon(Icons.edit, size: 25),

                                                                    const SizedBox(width: 18),

                                                                    Icon(Icons.delete, size: 25)
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                ),
                                              ],
                                            ),
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
                    ),

                    Positioned(
                      right: 30,
                      top: 0,
                      child: InkWell(
                        onTap: (){
                          showDialog(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0), // Adjust the radius as needed
                                    ),
                                    //title: Text("Hint", style: TextStyle(color: Theme.of(context!).primaryColor, fontSize: 15)),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Nome del turno', style: TextStyle(fontSize: 17)),

                                        const SizedBox(height: 8),

                                        CustomTextField(
                                          maxLength: 200,
                                          hintText: 'Nome del turno',
                                          isShowBorder: true,
                                          inputType: TextInputType.text,
                                          inputAction: TextInputAction.next,
                                          focusNode: _shiftNameFocus,
                                          controller: _shiftNameController,
                                          // isIcon: true,
                                        ),

                                        const SizedBox(height: 15),

                                        shiftsProvider.newShiftLoading?
                                        Center(
                                            child: CircularProgressIndicator(
                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                  Theme.of(context).primaryColor),
                                            )):
                                        CustomButton(btnTxt: 'Confirmare',
                                          onTap: () async {
                                            if(_shiftNameController!.text.trim().isEmpty){
                                              showCustomSnackBar('Il campo è vuoto', context);
                                            }else{
                                              _newShift();
                                              Navigator.pop(context);
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

}

