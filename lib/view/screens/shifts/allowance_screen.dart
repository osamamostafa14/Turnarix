import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/model/shifts/service_allowance_model.dart';
import 'package:turnarix/provider/auth_provider.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/base/custom_text_field.dart';

class AllowanceScreen extends StatefulWidget {
  final Map<String, dynamic>? interval;
  AllowanceScreen({@required this.interval});

  @override
  State<AllowanceScreen> createState() => _AllowanceScreenState();
}

class _AllowanceScreenState extends State<AllowanceScreen> {
  FocusNode _esternoFocus = FocusNode();
  TextEditingController? _esternoController;

  FocusNode _missionFocus = FocusNode();
  TextEditingController? _missionController;

  FocusNode _changeTurnFocus = FocusNode();
  TextEditingController? _changeTurnController;

  FocusNode _availabilityFocus = FocusNode();
  TextEditingController? _availabilityController;

  FocusNode _territoryControlFocus = FocusNode();
  TextEditingController? _territoryControlController;

  FocusNode _publicOrderServiceFocus = FocusNode();
  TextEditingController? _publicOrderServiceController;

  FocusNode _extraNomeFocus = FocusNode();
  TextEditingController? _extraNomeController;

  FocusNode _extraAmountFocus = FocusNode();
  TextEditingController? _extraAmountController;

  @override
  void initState() {
    super.initState();
    _esternoController = TextEditingController();
    _missionController = TextEditingController();
    _changeTurnController = TextEditingController();
    _availabilityController = TextEditingController();
    _territoryControlController = TextEditingController();
    _publicOrderServiceController = TextEditingController();
    _extraAmountController = TextEditingController();
    _extraNomeController = TextEditingController();
  }

  @override
  Widget build(BuildContext? context) {
    return Scaffold(
      backgroundColor: Theme.of(context!).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton(
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

                const SizedBox(height: 8),

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
                            uniqueId: '${DateTime.now().hour.toString()}' '${DateTime.now().minute.toString()}.' '${random.nextInt(10000) + 1}'
                      ));
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
        title: Text('Indennità personalizzate', style: TextStyle(color: Colors.black87,
            fontWeight: FontWeight.normal, fontSize: 17)),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black54,
          onPressed: () =>  Navigator.pop(context),
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
                      SwitchListTile(
                        value: shiftsProvider.servicioEstenro,
                        onChanged: (bool isActive) {
                          shiftsProvider.updateAllowance('esterno');
                        },
                        title: Text('Servizio Esterno',
                            style: TextStyle(fontSize: 17)),
                        activeColor: Theme.of(context).primaryColor,
                      ),

                      shiftsProvider.servicioEstenro?
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 12),
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
                                              focusNode: _esternoFocus,
                                              controller: _esternoController,
                                              // isIcon: true,
                                            )
                                          ],
                                        ),
                                        actions: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                                            child: CustomButton(btnTxt: 'Confermare',
                                              onTap: () {
                                                if(_esternoController!.text.isEmpty){
                                                  showCustomSnackBar('Il campo è vuoto', context);
                                                }else{
                                                  print('test 1 ${ _esternoController!.text}');
                                                  shiftsProvider.updateAllowanceAmount('esterno', _esternoController!.text);
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
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      Text('Giorni', style:
                                      TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 15)),
                                      Spacer(),
                                      Text('${shiftsProvider.servicioEstenroAmount!=null? '\$${shiftsProvider.servicioEstenroAmount}' : '\$'}', style:
                                      TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 15)),
                                      const SizedBox(width: 12),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ): SizedBox(),

                      Divider(),

                      SwitchListTile(
                        value: shiftsProvider.missione,
                        onChanged: (bool isActive) {
                          shiftsProvider.updateAllowance('mission');
                        },
                        title: Text('Missione',
                            style: TextStyle(fontSize: 17)),
                        activeColor: Theme.of(context).primaryColor,
                      ),

                      shiftsProvider.missione?
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 12),
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
                                              focusNode: _missionFocus,
                                              controller: _missionController,
                                              // isIcon: true,
                                            )
                                          ],
                                        ),
                                        actions: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                                            child: CustomButton(btnTxt: 'Confermare',
                                              onTap: () {
                                                if(_missionController!.text.isEmpty){
                                                  showCustomSnackBar('Il campo è vuoto', context);
                                                }else{
                                                  print('test 1 ${ _missionController!.text}');
                                                  shiftsProvider.updateAllowanceAmount('mission', _missionController!.text);
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
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      Text('Giorni', style:
                                      TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 15)),
                                      Spacer(),
                                      Text('${shiftsProvider.missioneAmount!=null? '\$${shiftsProvider.missioneAmount}' : '\$'}',
                                          style:
                                      TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 15)),
                                      const SizedBox(width: 12),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ): SizedBox(),

                      Divider(),

                      // CHANGE TURN
                      SwitchListTile(
                        value: shiftsProvider.changeTurn,
                        onChanged: (bool isActive) {
                          shiftsProvider.updateAllowance('change_turn');
                        },
                        title: Text('Cambio Turno',
                            style: TextStyle(fontSize: 17)),
                        activeColor: Theme.of(context).primaryColor,
                      ),

                      shiftsProvider.changeTurn?
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 12),
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
                                              focusNode: _changeTurnFocus,
                                              controller: _changeTurnController,
                                              // isIcon: true,
                                            )
                                          ],
                                        ),
                                        actions: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                                            child: CustomButton(btnTxt: 'Confermare',
                                              onTap: () {
                                                if(_changeTurnController!.text.isEmpty){
                                                  showCustomSnackBar('Il campo è vuoto', context);
                                                }else{
                                                  shiftsProvider.updateAllowanceAmount('change_turn', _changeTurnController!.text);
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
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      Text('Giorni', style:
                                      TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 15)),
                                      Spacer(),
                                      Text('${shiftsProvider.changeTurnAmount!=null? '\$${shiftsProvider.changeTurnAmount}' : '\$'}',
                                          style:
                                          TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 15)),
                                      const SizedBox(width: 12),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ): SizedBox(),

                      Divider(),

                      // AVAILIBILITY
                      SwitchListTile(
                        value: shiftsProvider.availability,
                        onChanged: (bool isActive) {
                          shiftsProvider.updateAllowance('availability');
                        },
                        title: Text('Reperibilità',
                            style: TextStyle(fontSize: 17)),
                        activeColor: Theme.of(context).primaryColor,
                      ),
                      shiftsProvider.availability?
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 12),
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
                                              focusNode: _availabilityFocus,
                                              controller: _availabilityController,
                                              // isIcon: true,
                                            )
                                          ],
                                        ),
                                        actions: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                                            child: CustomButton(btnTxt: 'Confermare',
                                              onTap: () {
                                                if(_availabilityController!.text.isEmpty){
                                                  showCustomSnackBar('Il campo è vuoto', context);
                                                }else{
                                                  shiftsProvider.updateAllowanceAmount('availability', _availabilityController!.text);
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
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      Text('Giorni', style:
                                      TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 15)),
                                      Spacer(),
                                      Text('${shiftsProvider.availabilityAmount!=null? '\$${shiftsProvider.availabilityAmount}' : '\$'}',
                                          style:
                                          TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 15)),
                                      const SizedBox(width: 12),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ): SizedBox(),

                      Divider(),


                      SwitchListTile(
                        value: shiftsProvider.territoryControl,
                        onChanged: (bool isActive) {
                          shiftsProvider.updateAllowance('territory_control');
                        },
                        title: Text('Controllo del Territorio Serale',
                            style: TextStyle(fontSize: 17)),
                        activeColor: Theme.of(context).primaryColor,
                      ),

                      // AVAILIBILITY
                      shiftsProvider.territoryControl?
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 12),
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
                                              focusNode: _territoryControlFocus,
                                              controller: _territoryControlController,
                                              // isIcon: true,
                                            )
                                          ],
                                        ),
                                        actions: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                                            child: CustomButton(btnTxt: 'Confermare',
                                              onTap: () {
                                                if(_territoryControlController!.text.isEmpty){
                                                  showCustomSnackBar('Il campo è vuoto', context);
                                                }else{
                                                  shiftsProvider.updateAllowanceAmount('territory_control', _territoryControlController!.text);
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
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      Text('Giorni', style:
                                      TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 15)),
                                      Spacer(),
                                      Text('${shiftsProvider.territoryControlAmount!=null? '\$${shiftsProvider.territoryControlAmount}' : '\$'}',
                                          style:
                                          TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 15)),
                                      const SizedBox(width: 12),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ): SizedBox(),

                      Divider(),

                      // PUBLIC SERVICE
                      SwitchListTile(
                        value: shiftsProvider.publicOrderService,
                        onChanged: (bool isActive) {
                          shiftsProvider.updateAllowance('public_order_service');
                        },
                        title: Text('Servizio Ordine Pubblico',
                            style: TextStyle(fontSize: 17)),
                        activeColor: Theme.of(context).primaryColor,
                      ),
                      shiftsProvider.publicOrderService?
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 12),
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
                                              focusNode: _publicOrderServiceFocus,
                                              controller: _publicOrderServiceController,
                                              // isIcon: true,
                                            )
                                          ],
                                        ),
                                        actions: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                                            child: CustomButton(btnTxt: 'Confermare',
                                              onTap: () {
                                                if(_publicOrderServiceController!.text.isEmpty){
                                                  showCustomSnackBar('Il campo è vuoto', context);
                                                }else{
                                                  shiftsProvider.updateAllowanceAmount('public_order_service', _publicOrderServiceController!.text);
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
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      Text('Giorni', style:
                                      TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 15)),
                                      Spacer(),
                                      Text('${shiftsProvider.publicOrderServiceAmount!=null? '\$${shiftsProvider.publicOrderServiceAmount}' : '\$'}',
                                          style:
                                          TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 15)),
                                      const SizedBox(width: 12),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ): SizedBox(),

                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        // padding: const EdgeInsets.all(0),
                        itemCount: shiftsProvider.extraServiceAllowancesList.length,
                        itemBuilder: (context, index) {
                          ServiceAllowanceModel _allowance = shiftsProvider.extraServiceAllowancesList[index];
                          _extraAmountController!.text = _allowance.amount!;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Column(
                              children: [
                                SwitchListTile(
                                  value: _allowance.status!,
                                  onChanged: (bool isActive) {
                                    shiftsProvider.updateExtraAllowanceStatus(ServiceAllowanceModel(
                                      name: _allowance.name,
                                      amount: _allowance.amount,
                                      status: _allowance.status == true? false: true,
                                      uniqueId: _allowance.uniqueId
                                    ));
                                   // shiftsProvider.updateAllowance('public_order_service');
                                  },
                                  title: Text('${_allowance.name}',
                                      style: TextStyle(fontSize: 17)),
                                  activeColor: Theme.of(context).primaryColor,
                                ),
                                _allowance.status == true?
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 12),
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
                                                            shiftsProvider.updateExtraAllowanceAmount(
                                                                ServiceAllowanceModel(
                                                                    name: _allowance.name,
                                                                    amount: _extraAmountController!.text.trim(),
                                                                    status: _allowance.status == true? false: true,
                                                                    uniqueId: _allowance.uniqueId
                                                                ));
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
                                            child: Row(
                                              children: [
                                                const SizedBox(width: 8),
                                                Text('Giorni', style:
                                                TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 15)),
                                                Spacer(),
                                                Text('${_allowance.amount!=null? '\$${_allowance.amount}' : '\$'}',
                                                    style:
                                                    TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 15)),
                                                const SizedBox(width: 12),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ): SizedBox(),
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
      ),
    );
  }
}

