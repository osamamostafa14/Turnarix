import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/view/screens/shifts/vacations/date_picker_sheet.dart';

class SelectVacationScreen extends StatefulWidget {
  final int? intervalId;
  SelectVacationScreen(
      {@required this.intervalId,
      });

  @override
  State<SelectVacationScreen> createState() => _SelectVacationScreenState();
}

class _SelectVacationScreenState extends State<SelectVacationScreen> {
  ScrollController scrollController =  ScrollController();
  @override
  Widget build(BuildContext? context) {
    return Scaffold(
      backgroundColor: Theme.of(context!).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Select vacation type',
            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal)),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black87,
          onPressed: () =>  Navigator.pop(context),
        ),
      ),
      body: Consumer<ShiftsProvider>(
        builder: (context, shiftsProvider, child) {
          return Column(
            children: [
              Expanded(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: Center(
                      child: SizedBox(
                        width: 1170,
                        child:
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              padding: const EdgeInsets.all(6),
                              itemCount: shiftsProvider.vacationNames.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                String _name = shiftsProvider.vacationNames[index];
                                return
                                  Stack(
                                    children: [
                                      InkWell(
                                        onTap:(){
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            builder: (con) {
                                              return DatePickerSheet(
                                                vacationName: _name,
                                                intervalId: widget.intervalId,
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                                          margin: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [BoxShadow(
                                              color: Colors.grey[300]!,
                                              spreadRadius: 1, blurRadius: 5,
                                            )],
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            children: [
                                              Text('${_name}', style: const TextStyle(fontSize: 15))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                              },
                            ),
                          ],
                        )
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          );
        },
      ),
    );
  }
}

