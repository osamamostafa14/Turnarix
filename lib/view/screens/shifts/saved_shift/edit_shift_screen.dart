import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/model/response/response_model.dart';
import 'package:turnarix/data/model/shifts/intervals_model.dart';
import 'package:turnarix/data/model/shifts/shift_model.dart';
import 'package:turnarix/provider/saved_shift_provider.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/utill/images.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/base/custom_text_field.dart';
import 'package:turnarix/view/screens/shifts/add_interval_screen.dart';
import 'package:turnarix/view/screens/shifts/saved_shift/edit_interval_screen.dart';

class EditShiftScreen extends StatefulWidget {
  final ShiftModel? shift;
  EditShiftScreen({@required this.shift});
  @override
  State<EditShiftScreen> createState() => _EditShiftScreenState();
}

class _EditShiftScreenState extends State<EditShiftScreen> {

  FocusNode _shiftNameFocus = FocusNode();
  TextEditingController? _shiftNameController;
  bool _hasChanges = false;

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
      Consumer<SavedShiftProvider>(
          builder: (context, shiftProvider, child) {
            if(shiftProvider.shiftName != widget.shift!.shiftName && shiftProvider.shiftName!=null){
              _hasChanges = true;
            }
            if(shiftProvider.selectedDayIntervals!.length > 0){
              _hasChanges = true;
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

            removedSuccess() {
              Provider.of<ShiftsProvider>(context, listen: false).clearOffset();
              Provider.of<ShiftsProvider>(context, listen: false).getShiftslist(context);
            }

            getIntervals() {
              shiftProvider.getIntervalsList(context, widget.shift!.id!, false);
            }

            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text('Modifica turno', style:
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

                            /// SHIFT NAME
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
                                                      onTap: () async {
                                                        if(_shiftNameController!.text.isEmpty){
                                                          showCustomSnackBar('il campo del nome è vuoto', context);
                                                        }else{
                                                          Navigator.pop(context);

                                                         ResponseModel _response = await shiftProvider.updateName(context, _shiftNameController!.text, widget.shift!.id!);

                                                         if(_response.isSuccess){
                                                           shiftProvider.setShiftName(_shiftNameController!.text);
                                                           //Provider.of<ShiftsProvider>(context, listen: false).clearOffset();
                                                           Provider.of<ShiftsProvider>(context, listen: false).getShiftslist(context);
                                                         }else{
                                                           showDialog(
                                                             context: context,
                                                             builder: (_) => AlertDialog(
                                                               title: Text('Qualcosa è andato storto, nome non aggiornato!'),

                                                               shape: RoundedRectangleBorder(
                                                                 borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                                                               ),
                                                             ),
                                                           );
                                                         }
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
                                              const Text('Nome del turno', style:
                                               TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 15)),
                                              const Spacer(),
                                              Text('${shiftProvider.shiftName!=null? '${shiftProvider.shiftName}' : '${widget.shift!.shiftName}'}', style:
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

                            ///INTERVALS NAME
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
                                      for(int i = 0; i <shiftProvider.dayIntervals.length ; i++)
                                        Padding(
                                          padding: const EdgeInsets.only(right: 8, bottom: 8, top: 8),
                                          child: InkWell(
                                            onTap: () {
                                              shiftProvider.addDayInterval(IntervalModel(
                                                  shiftId: widget.shift!.id,
                                                  name: shiftProvider.dayIntervals[i]['name']
                                              ));
                                              // shiftProvider.updateUserDayInterval(shiftProvider.dayIntervals[i]);
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
                                                  child: Text('${shiftProvider.dayIntervals[i]['name']} +',
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
                              itemCount: shiftProvider.mainDayIntervals.length,
                              // reverse: true,
                              itemBuilder: (context, index) {
                                return
                                  shiftProvider.temporaryRemovedIntervals!.contains(shiftProvider.mainDayIntervals[index].id)?
                                  const SizedBox():
                                  Padding(
                                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 5, top: 8),
                                  child:
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          IntervalModel interval = shiftProvider.mainDayIntervals[index];
                                          shiftProvider.initInterval(
                                            interval.title!=null? interval.title!: '',
                                            interval.iconName!=null? interval.iconName!: 'sunny',
                                            interval.iconColor!=null? Color(int.parse(interval.iconColor!)): Colors.blueAccent,
                                            interval.foodStamp == 1? true: false,
                                            interval.services !=null? interval.services! : [],
                                            interval.breaks !=null? interval.breaks! : [],
                                            interval.allowances !=null? interval.allowances! : [],
                                            interval.extraordinaries !=null? interval.extraordinaries! : [],
                                          );
                                          shiftProvider.resetIcon();
                                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
                                              EditIntervalScreen(interval: shiftProvider.mainDayIntervals[index])));
                                        },
                                        child: Row(
                                          children: [
                                            InkWell(
                                                onTap:() {
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext? context) {
                                                      return AlertDialog(
                                                        title: const Text("Remove this item?",
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
                                                                onTap: () async {
                                                                  Navigator.pop(context!);
                                                                  ResponseModel _response = await shiftProvider.removeSavedInterval(context, shiftProvider.mainDayIntervals![index].id!);
                                                                  if(_response.isSuccess){
                                                                    removedSuccess();
                                                                  }else{
                                                                    notRemovedDialog();
                                                                  }
                                                                })),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Icon(Icons.delete, color: Colors.black54)),
                                            const SizedBox(width: 30),
                                            Text('#${index + 1} ${shiftProvider.mainDayIntervals[index].name}',
                                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,
                                                    fontSize: 17)),
                                            Spacer(),
                                            Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54)
                                          ],
                                        ),
                                      ),

                                      const  Padding(
                                        padding:  EdgeInsets.only(top: 8),
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
                              itemCount: shiftProvider.selectedDayIntervals!.length,
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
                                                                  shiftProvider.removeDayInterval(shiftProvider.selectedDayIntervals![index]);
                                                                })),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Icon(Icons.delete, color: Colors.black54)),
                                            const SizedBox(width: 30),
                                            Text('#${shiftProvider.mainDayIntervals.length + (index + 1)} ${shiftProvider.selectedDayIntervals![index].name}',
                                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,
                                                    fontSize: 17)),
                                            Spacer(),
                                             // Image.asset(Images.loading_icon)
                                             Icon(Icons.hourglass_empty, color: Colors.orange)
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

                            shiftProvider.intervalLoading?
                            Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor),
                                )):

                            shiftProvider.selectedDayIntervals!.length> 0?
                            Padding(
                              padding: const EdgeInsets.only(left: 12, right: 12),
                              child: CustomButton(btnTxt: 'Salva nuovi intervalli',
                              onTap: () {
                                shiftProvider.addShiftIntervals(context, shiftProvider.selectedDayIntervals!, widget.shift!.id!).then((value) => {
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

