import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/model/shifts/exchange_request_model.dart';
import 'package:turnarix/provider/calendar_provider.dart';
import 'package:turnarix/provider/shift_exchange_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/view/base/border_button.dart';
import 'package:turnarix/view/base/custom_button.dart';

class EmployeeButtons extends StatelessWidget {
  final ExchangeRequestModel? exchangeRequest;
  String? listStatus;
  EmployeeButtons({this.exchangeRequest, this.listStatus});

  @override
  Widget build(BuildContext context) {

    void _acceptRejectRequest(String status){
      Provider.of<ShiftExchangeProvider>(context, listen: false).exchangeRequestStatus(context, exchangeRequest!.id!, status).then((value) {
        Provider.of<ShiftExchangeProvider>(context, listen: false).clearOffset();
        Provider.of<ShiftExchangeProvider>(context, listen: false).getExchangeRequests(context,'1',listStatus! ,'employee');

        if(status == 'accepted'){
          Provider.of<CalendarProvider>(context, listen: false).getCalendarShifts(context);
          Provider.of<CalendarProvider>(context, listen: false).getShiftIntervals(context);
        }
      });
    }

    return
      exchangeRequest!.status == 'canceled'
          || exchangeRequest!.status == 'accepted' || exchangeRequest!.status == 'rejected'?
      const SizedBox():
      Row(
      children: [
        Expanded(child: BorderButton(
          borderColor: Colors.red,
          textColor: Colors.white,
          btnTxt: 'Reject',
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
                                  _acceptRejectRequest('rejected');
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
        )),

        const SizedBox(width: 8),

        Expanded(child: BorderButton(
          borderColor: Colors.green,
          textColor: Colors.white,
          btnTxt: 'Accept',
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                backgroundColor: ColorResources.BG_SECONDRY,
                title: Text('Sei sicuro?', style: TextStyle(color: Colors.white)),
                content: Text('Vuoi accettare la richiesta?',style: TextStyle(color: Colors.white)),
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
                                  _acceptRejectRequest('accepted');
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
        )),

      ],
    );
  }
}
