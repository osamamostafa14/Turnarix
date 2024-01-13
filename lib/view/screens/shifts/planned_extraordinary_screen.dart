import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/model/shifts/intervals_model.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/view/screens/shifts/widgets/new_planned_extraordinary_widget.dart';
import 'package:turnarix/view/screens/shifts/widgets/planned_extraordinary_widget.dart';

class PlannedExtraordinaryScreen extends StatefulWidget {
  final IntervalModel? interval;
  final bool fromEmployee;
  final bool isNew;
  PlannedExtraordinaryScreen({@required this.interval, this.fromEmployee = false, this.isNew = false});

  @override
  State<PlannedExtraordinaryScreen> createState() => _PlannedExtraordinaryScreenState();
}

class _PlannedExtraordinaryScreenState extends State<PlannedExtraordinaryScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext? context) {
    return Scaffold(
      backgroundColor:  ColorResources.BG_SECONDRY,
      appBar: AppBar(
        title: const Text('Straordinario Programmato', style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.normal, fontSize: 17)),
        centerTitle: true,
        backgroundColor: ColorResources.BG_SECONDRY,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () =>  Navigator.pop(context!),
        ),
      ),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: SizedBox(
                width: 1170,
                child:
                widget.isNew?
                NewPlannedExtraordinaryWidget(interval: widget.interval, fromEmployee: widget.fromEmployee):
                PlannedExtraordinaryWidget(interval: widget.interval, fromEmployee: widget.fromEmployee),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

