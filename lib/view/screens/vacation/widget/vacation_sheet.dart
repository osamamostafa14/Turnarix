import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/model/response/response_model.dart';
import 'package:turnarix/data/model/vacation_model.dart';
import 'package:turnarix/provider/vacation_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/base/custom_text_field.dart';

class VacationBottomSheet extends StatefulWidget {
  final VacationModel? vacation;
  VacationBottomSheet({@required this.vacation});

  @override
  State<VacationBottomSheet> createState() => _VacationBottomSheetState();
}

class _VacationBottomSheetState extends State<VacationBottomSheet> {
  FocusNode _nameFocus = FocusNode();
  TextEditingController? _nameController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();

    if(widget.vacation!=null){
      _nameController!.text  = widget.vacation!.name!;
    }
  }

  @override
  Widget build(BuildContext? context) {

    return
      Consumer<VacationProvider>(
          builder: (context, vacationProvider, child){

            void _newVacation() async {

            }

            return Stack(
              children: [
                Container(
                  width: 550,
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  decoration: BoxDecoration(
                    color: ColorResources.BG_SECONDRY,
                    borderRadius:  BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: SizedBox(
                          width: 1170,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                      onTap:(){
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.close, color: Colors.white)),
                                ],
                              ),
                              const SizedBox(height: 10),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Nome della vacanza',
                                  style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white),
                                ),
                              ),

                              const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                              CustomTextField(
                                isShowBorder: true,
                                inputType: TextInputType.text,
                                inputAction: TextInputAction.next,
                                hintText: 'Nome della vacanza',
                                controller: _nameController,
                                fillColor: ColorResources.BG_SECONDRY,
                                inputColor: Colors.white,
                                focusNode: _nameFocus,
                              ),

                              const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),

                              vacationProvider.storeLoading?
                              Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).primaryColor),
                                  )):
                              CustomButton(btnTxt: 'Confirm',
                               // backgroundColor: Colors.grey,
                                onTap: () async {
                                  if(_nameController!.text.isEmpty){
                                    showCustomSnackBar('Il campo è vuoto', context);
                                  }else{
                                    ResponseModel _response;
                                    if(widget.vacation!=null){
                                      _response = await vacationProvider.updateVacation(context, _nameController!.text, widget.vacation!.id!);
                                    }else{
                                      _response = await vacationProvider.storeVacation(context, _nameController!.text);
                                    }
                                    if(_response.isSuccess){
                                      Navigator.pop(context);
                                      vacationProvider.clearOffset();
                                      vacationProvider.getVacationsList(context, '1');
                                      showCustomSnackBar('Vacanza aggiunta con successo', context, isError:false);
                                    }else{
                                      showCustomSnackBar('qualcosa è andato storto', context);
                                    }

                                  }
                                },
                              )

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
  }
}

