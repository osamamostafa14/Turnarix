import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/model/shifts/exchange_request_model.dart';
import 'package:turnarix/data/model/shifts/intervals_model.dart';
import 'package:turnarix/provider/shift_exchange_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/view/base/border_button.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/screens/calendar/employee/employee_interval_screen.dart';

class UserButtons extends StatelessWidget {
  final ExchangeRequestModel? exchangeRequest;
  String? listStatus;
  UserButtons({this.exchangeRequest, this.listStatus});

  @override
  Widget build(BuildContext context) {
    IntervalModel _userInterval = exchangeRequest!.userShift!.interval!;
    IntervalModel _employeeInterval = exchangeRequest!.employeeShift!.interval!;

    void _cancelExchangeRequest() {
      Provider.of<ShiftExchangeProvider>(context, listen: false).exchangeRequestStatus(context, exchangeRequest!.id!, 'canceled')
          .then((value) {
        Provider.of<ShiftExchangeProvider>(context, listen: false).clearOffset();
        Provider.of<ShiftExchangeProvider>(context, listen: false).getExchangeRequests(context,'1',listStatus! ,'user');
      });
    }
    return Column(
      children: [
        exchangeRequest!.status == 'canceled'
            || exchangeRequest!.status == 'accepted' || exchangeRequest!.status == 'rejected'?
        const SizedBox():
        Row(
          children: [

            Expanded(child: BorderButton(
              borderColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
              btnTxt: 'Your shift',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                    EmployeeIntervalScreen(
                      interval: _userInterval,
                      fromRequestsScreen: true,
                    )));
              },
            )),

            const SizedBox(width: 8),

            Expanded(child: BorderButton(
              borderColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
              btnTxt: 'Requested shift',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                    EmployeeIntervalScreen(
                      interval: _employeeInterval,
                      fromRequestsScreen: true,
                    )));
              },
            )),

          ],
        ),

        const SizedBox(height: 10),

        exchangeRequest!.status == 'canceled'
            || exchangeRequest!.status == 'accepted' || exchangeRequest!.status == 'rejected'?
        const SizedBox():
        Row(
          children: [
            Expanded(child: BorderButton(
              borderColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
              btnTxt: 'Cancel Request',
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
                                      _cancelExchangeRequest();
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
        ),

      ],
    );
  }
}
