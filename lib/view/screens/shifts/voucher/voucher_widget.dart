import 'dart:math';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/model/shifts/intervals_model.dart';
import 'package:turnarix/data/model/shifts/voucher_model.dart';
import 'package:turnarix/provider/saved_shift_provider.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:flutter/material.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/base/custom_text_field.dart';

class VoucherWidget extends StatelessWidget {
  final IntervalModel? interval;
  final bool fromEmployee;
  VoucherWidget({this.interval, this.fromEmployee = false});

  @override
  Widget build(BuildContext context) {
    FocusNode _titleFocus = FocusNode();
    TextEditingController? _nameController = TextEditingController();

    FocusNode _amountFocus = FocusNode();
    TextEditingController? _amountController = TextEditingController();
    return
      Consumer<SavedShiftProvider>(
          builder: (context, shiftProvider, child) {

            List<VoucherModel> _vouchers = shiftProvider.voucherList;

            if(fromEmployee == true){
              _vouchers = interval!.vouchers!;
            }else{
              _vouchers = shiftProvider.voucherList;
            }
            return Column(
              children: [

                const SizedBox(height: 10),

                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // padding: const EdgeInsets.all(0),
                  itemCount: _vouchers.length,

                  itemBuilder: (context, index) {

                    VoucherModel _voucher= _vouchers[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Voucher  ${index + 1}', style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15
                              )),
                              const SizedBox(width: 15),

                              fromEmployee == true? const SizedBox():
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Text('Rimuovere questo elemento?', style:
                                      TextStyle(fontSize: 16, color: Colors.black87)),
                                      actions: [
                                        Row(
                                          children: [
                                            const SizedBox(width: 14),
                                            Expanded(
                                              child: CustomButton(btnTxt: 'No',
                                                  backgroundColor: Colors.black54,
                                                  onTap: (){
                                                    Navigator.pop(context);
                                                  }),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: CustomButton(btnTxt: 'SÌ',
                                                  onTap: (){
                                                    Navigator.pop(context);
                                                    shiftProvider.removeExtraordinary(_voucher.id!);
                                                  }),
                                            ),
                                            const SizedBox(width: 14),
                                          ],
                                        )
                                      ],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                                      ),
                                    ),
                                  );
                                },
                                child: Text('Eliminare', style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15
                                )),
                              ),
                            ],
                          ),

                          const SizedBox(height: 5),

                          Container(
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              color: Theme.of(context).primaryColor.withOpacity(0.3),
                              border: Border.all(width: 1, color: ColorResources.BORDER_COLOR),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),


                                InkWell(
                                  onTap: () async {
                                    if(fromEmployee == false){
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
                                                focusNode: _titleFocus,
                                                controller: _nameController,
                                                // isIcon: true,
                                              )
                                            ],
                                          ),
                                          actions: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                                              child: CustomButton(btnTxt: 'Confermare',
                                                onTap: () {
                                                  if(_nameController.text.trim().isEmpty){
                                                    showCustomSnackBar('il campo è vuoto', context);
                                                  }else{
                                                    Navigator.pop(context);
                                                    shiftProvider.updateVoucherInfo(
                                                        _voucher.id!,
                                                        'name',
                                                        _nameController.text.trim()
                                                    );
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
                                      Text('Nome', style:
                                      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15)),
                                      const Spacer(),
                                      Text('${_voucher.name != null? _voucher.name : fromEmployee == false? 'Aggiungu+' : ''}', style:
                                      TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 15)),
                                      const SizedBox(width: 12),
                                    ],
                                  ),
                                ),

                                const Divider(),

                                Divider(),

                                InkWell(
                                  onTap: () async {
                                    if(fromEmployee == false){
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CustomTextField(
                                                maxLength: 200,
                                                hintText: '€ quantità',
                                                isShowBorder: true,
                                                inputType: TextInputType.number,
                                                inputAction: TextInputAction.next,
                                                focusNode: _amountFocus,
                                                controller: _amountController,
                                                // isIcon: true,
                                              )
                                            ],
                                          ),
                                          actions: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                                              child: CustomButton(btnTxt: 'Confermare',
                                                onTap: () {
                                                  if(_amountController.text.trim().isEmpty){
                                                    showCustomSnackBar('il campo è vuoto', context);
                                                  }else{
                                                    Navigator.pop(context);
                                                    shiftProvider.updateVoucherInfo(
                                                        _voucher.id!,
                                                        'amount',
                                                        double.parse(_amountController.text.trim())
                                                    );
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
                                      const Text('Importo per ora', style:
                                      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15)),
                                      const Spacer(),
                                      Text('€${_voucher.amount != null? _voucher.amount : ''}', style:
                                      const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 15)),
                                      const SizedBox(width: 12),
                                    ],
                                  ),
                                ),

                                Divider(),

                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                fromEmployee == true? const SizedBox() :
                InkWell(
                  onTap: () {
                    final Random random = Random();

                    shiftProvider.addVoucher(
                        VoucherModel(
                            id:  random.nextInt(10000) + 1, /// Temprary ID
                            intervalId: interval!.id,
                        )
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Altro', style: TextStyle(color: Colors.white70, fontSize: 15)),

                      const SizedBox(width: 5),

                      Icon(Icons.add, color: Colors.white70),
                    ],
                  ),
                ),

                const SizedBox(height: 40)
              ],
            );
          });
  }
}
