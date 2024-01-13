import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/model/shifts/intervals_model.dart';
import 'package:turnarix/data/model/shifts/service_allowance_model.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/base/custom_text_field.dart';

class NewAllowanceScreen extends StatefulWidget {
  final IntervalModel? interval;
  bool? fromEmployee;
  NewAllowanceScreen({@required this.interval, this.fromEmployee = false});

  @override
  State<NewAllowanceScreen> createState() => _NewAllowanceScreenState();
}

class _NewAllowanceScreenState extends State<NewAllowanceScreen> {

  FocusNode _extraNomeFocus = FocusNode();
  TextEditingController? _extraNomeController;

  FocusNode _extraAmountFocus = FocusNode();
  TextEditingController? _extraAmountController;

  @override
  void initState() {
    super.initState();
    _extraNomeController = TextEditingController();
    _extraAmountController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _extraAmountController!.dispose();
  }

  @override
  Widget build(BuildContext? context) {
    return
      Consumer<ShiftsProvider>(
          builder: (context, shiftProvider, child) {
            List<ServiceAllowanceModel> _allowancesList = [];
            if(widget.fromEmployee == true){
              _allowancesList = widget.interval!.allowances!;
            }else{
              _allowancesList = shiftProvider.extraServiceAllowancesList;
            }
            print('_allowancesList=> ${_allowancesList[0].name}');

            _extraAmountController!.text = shiftProvider.allowanceAmount;
            _extraAmountController!.text = shiftProvider.allowanceName;
            return Scaffold(
              backgroundColor: ColorResources.BG_SECONDRY,
              floatingActionButton:
              widget.fromEmployee == true ? const SizedBox() :
              FloatingActionButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextField(
                            maxLength: 200,
                            hintText: 'Nome',
                            isShowBorder: true,
                            inputType: TextInputType.text,
                            inputAction: TextInputAction.next,
                            focusNode: _extraNomeFocus,
                            controller: _extraNomeController,
                            // isIcon: true,
                          ),

                          const SizedBox(height: 14),

                          CustomTextField(
                            maxLength: 200,
                            hintText: 'Importo',
                            isShowBorder: true,
                            inputType: TextInputType.text,
                            inputAction: TextInputAction.next,
                            focusNode: _extraAmountFocus,
                            controller: _extraAmountController,
                            // isIcon: true,
                          ),
                        ],
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                          child: CustomButton(btnTxt: 'Confermare',
                            onTap: () {
                              final Random random = Random();
                              if(_extraNomeController!.text.isEmpty || _extraAmountController!.text.isEmpty){
                                showCustomSnackBar('Per favore compila tutti i campi', context);
                              }else{
                                Provider.of<ShiftsProvider>(context, listen: false).addAllowance(
                                    ServiceAllowanceModel(
                                      name: _extraNomeController!.text.trim(),
                                      amount: _extraAmountController!.text.trim(),
                                      status: true,
                                      id: random.nextInt(10000) + 1,
                                      // intervalUniqueId: widget.interval!['unique_id']
                                    ));
                                shiftProvider.resetAllowanceTexts();
                                Navigator.pop(context);
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
                tooltip: 'inserisci indennità',
                backgroundColor: Theme.of(context).primaryColor,
                child: const Icon(Icons.add),
              ),
              appBar: AppBar(
                title: Text('Indennità personalizzate', style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.normal, fontSize: 17)),
                centerTitle: true,
                backgroundColor: ColorResources.BG_SECONDRY,
                elevation: 0.5,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () =>  Navigator.pop(context),
                ),
              ),
              body: SafeArea(
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

                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              // padding: const EdgeInsets.all(0),
                              itemCount: _allowancesList.length,
                              itemBuilder: (context, index) {
                                ServiceAllowanceModel _allowance = _allowancesList[index];
                                // _extraAmountController!.text = _allowance.amount ?? '';
                                return Padding(
                                  padding: EdgeInsets.only(bottom: widget.fromEmployee == true && _allowance.amount == 'null'? 0: 12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      widget.fromEmployee == false? const SizedBox():
                                      widget.fromEmployee == true && _allowance.amount == 'null'? const SizedBox() :
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10, bottom: 8),
                                        child: Text('${_allowance.name}',
                                            style: TextStyle(fontSize: 17, color: Colors.white70)),
                                      ),

                                      widget.fromEmployee == true? const SizedBox():
                                      SwitchListTile(
                                        value: _allowance.status!,
                                        onChanged: (bool isActive) {
                                          shiftProvider.updateExtraAllowanceStatus(ServiceAllowanceModel(
                                            name: _allowance.name,
                                            amount: _allowance.amount,
                                            status: _allowance.status == true? false: true,
                                            id: _allowance.id,
                                            // intervalUniqueId: widget.interval!['unique_id']
                                          ));
                                          // shiftProvider.updateAllowance('public_order_service');
                                        },
                                        title: Text('${_allowance.name}',
                                            style: TextStyle(fontSize: 17, color: Colors.white70)),

                                        activeColor: Theme.of(context).primaryColor,
                                        inactiveTrackColor: Colors.grey,
                                      ),

                                      _allowance.status == true?
                                      widget.fromEmployee == true && _allowance.amount == 'null'? const SizedBox() :
                                      Padding(
                                        padding:  EdgeInsets.only(left: 10, right: 12,
                                            bottom: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 35,
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                                    color: Theme.of(context).primaryColor.withOpacity(0.3)
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    if(widget.fromEmployee == false){
                                                      showDialog(
                                                        context: context,
                                                        builder: (_) => AlertDialog(
                                                          content: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              CustomTextField(
                                                                maxLength: 200,
                                                                hintText: 'Giorni',
                                                                isShowBorder: true,
                                                                inputType: TextInputType.number,
                                                                inputAction: TextInputAction.next,
                                                                focusNode: _extraAmountFocus,
                                                                controller: _extraAmountController,
                                                                // isIcon: true,
                                                              )
                                                            ],
                                                          ),
                                                          actions: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                                                              child: CustomButton(btnTxt: 'Confermare',
                                                                onTap: () {
                                                                  if(_extraAmountController!.text.isEmpty){
                                                                    showCustomSnackBar('Il campo è vuoto', context);
                                                                  }else{
                                                                    shiftProvider.updateExtraAllowanceAmount(
                                                                        ServiceAllowanceModel(
                                                                            name: _allowance.name,
                                                                            amount: _extraAmountController!.text.trim(),
                                                                            status: _allowance.status == true? false: true,
                                                                            id: _allowance.id
                                                                        ));
                                                                    shiftProvider.resetAllowanceTexts();
                                                                    Navigator.pop(context);
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
                                                    }

                                                  },
                                                  child: Row(
                                                    children: [
                                                      const SizedBox(width: 8),
                                                      Text('Giorni', style:
                                                      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15)),
                                                      Spacer(),
                                                      _allowance.amount!=null?
                                                      Text('${_allowance.amount!='null'? '\$${_allowance.amount}' : '\$'}',
                                                          style:
                                                          TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15)):
                                                      const SizedBox(),
                                                      const SizedBox(width: 12),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ): const SizedBox(),
                                    ],
                                  ),
                                );
                              },
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

