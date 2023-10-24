import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:turnarix/data/model/shifts/service_allowance_model.dart';
import 'package:turnarix/data/repository/shifts_repo.dart';

class ShiftsProvider with ChangeNotifier {
  final ShiftsRepo? shiftsRepo;
  ShiftsProvider({@required this.shiftsRepo});

  TimeOfDay? _shiftStartTime;
  TimeOfDay? get shiftStartTime => _shiftStartTime;

  TimeOfDay? _shiftEndTime;
  TimeOfDay? get shiftEndTime => _shiftEndTime;


  String? _singleDate;
  String? get singleDate => _singleDate;


  String? _startDate;
  String? get startDate => _startDate;

  String? _endDate;
  String? get endDate => _endDate;

  bool _isDateRange = true;
  bool get isDateRange => _isDateRange;

  String? _finalStartDate;
  String? get finalStartDate => _finalStartDate;

  String? _finalEndDate;
  String? get finalEndDate => _finalEndDate;

  bool _isFinalDateRange = true;
  bool get isFinalDateRange => _isFinalDateRange;

  TimeOfDay _temporaryServiceStartTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay get temporaryServiceStartTime => _temporaryServiceStartTime;

  TimeOfDay _temporaryServiceEndTime =  const TimeOfDay(hour: 17, minute: 0);
  TimeOfDay get temporaryServiceEndTime => _temporaryServiceEndTime;

  bool _temporaryServiceOn = false;
  bool get temporaryServiceOn => _temporaryServiceOn;

  String? _shiftName;
  String? get shiftName => _shiftName;

  Map<String, dynamic>? _icon;
  Map<String, dynamic>? get icon => _icon;

  bool _iconsVisible = false;
  bool get iconsVisible => _iconsVisible;

  Color _iconColor = Color(0xff2196f3);
  Color get iconColor => _iconColor;

  List<Map<String, dynamic>> _dayIntervals = [
    {'id': 1, 'name': 'Sera'},
    {'id': 2, 'name': 'Pomeriggio'},
    {'id': 3, 'name': 'Mattina'},
    {'id': 4, 'name': 'Notte'},
    {'id': 5, 'name': 'Riposo'},
    {'id': 6, 'name': 'Mattina/Pom'},
    {'id': 7, 'name': 'Pom/Sera'},
  ];
  List<Map<String, dynamic>> get dayIntervals => _dayIntervals;

  List<Map<String, dynamic>> _userDayIntervals = [];
  List<Map<String, dynamic>>? get userDayIntervals => _userDayIntervals;

  ///// Intervals: Evening, Morning, etc..
  List<Map<String, dynamic>> _intervalServicesList = [];
  List<Map<String, dynamic>> get intervalServicesList => _intervalServicesList.reversed.toList();

  ///// Intervals: Evening, Morning, etc..
  List<Map<String, dynamic>> _extraServiceTimeList = [];
  List<Map<String, dynamic>> get extraServiceTimeList => _extraServiceTimeList;

  ///// Breaks
  List<Map<String, dynamic>> _breakList = [];
  List<Map<String, dynamic>> get breakList => _breakList;

  void updateUserDayInterval(Map<String, dynamic> interval){
    final Random random = Random();
    Map<String, dynamic> _interval = {
      'unique_id': '${DateTime.now().hour.toString()}' '${DateTime.now().minute.toString()}.' '${random.nextInt(10000) + 1}',
      'name': interval['name']
    };
    _userDayIntervals.add(_interval);
    print('${_userDayIntervals}');
    notifyListeners();
  }

  /// ALLOWANCE
  bool _servicioEstenro = true;
  bool get servicioEstenro => _servicioEstenro;

  bool _missione = true;
  bool get missione => _missione;

  bool _changeTurn = true;
  bool get changeTurn => _changeTurn;

  bool _availability = true;
  bool get availability => _availability;

  bool _territoryControl = true;
  bool get territoryControl => _territoryControl;

  bool _publicOrderService = true;
  bool get publicOrderService => _publicOrderService;

  /// ALLOWANCE AMOUNT
  String? _servicioEstenroAmount;
  String? get servicioEstenroAmount => _servicioEstenroAmount;

  String? _missioneAmount;
  String? get missioneAmount => _missioneAmount;

  String? _changeTurnAmount;
  String? get changeTurnAmount => _changeTurnAmount;

  String? _availabilityAmount;
  String? get availabilityAmount => _availabilityAmount;

  String? _territoryControlAmount;
  String? get territoryControlAmount => _territoryControlAmount;

  String? _publicOrderServiceAmount;
  String? get publicOrderServiceAmount => _publicOrderServiceAmount;

  List<ServiceAllowanceModel> _extraServiceAllowancesList = [];
  List<ServiceAllowanceModel> get extraServiceAllowancesList => _extraServiceAllowancesList;

  void updateAllowance(String type){
    if(type == 'esterno'){
      _servicioEstenro == false? _servicioEstenro = true: _servicioEstenro = false;
    }else if(type == 'mission'){
      _missione == false? _missione = true: _missione = false;
    }else if(type == 'change_turn'){
      _changeTurn == false? _changeTurn = true: _changeTurn = false;
    }else if(type == 'availability'){
      _availability == false? _availability = true: _availability = false;
    }else if(type == 'territory_control'){
      _territoryControl == false? _territoryControl = true: _territoryControl = false;
    }else if(type == 'public_order_service'){
      _publicOrderService == false? _publicOrderService = true: _publicOrderService = false;
    }
    notifyListeners();
  }

  void addAllowance(ServiceAllowanceModel allowance) {
    _extraServiceAllowancesList.add(allowance);
    notifyListeners();
  }

  void updateAllowanceAmount(String type, String amount){
    if(type == 'esterno'){
      _servicioEstenroAmount = amount;
      print('esterno: ${_servicioEstenroAmount}');
    }else if(type == 'mission'){
      _missioneAmount = amount;
    }else if(type == 'change_turn'){
      _changeTurnAmount = amount;
    }else if(type == 'availability'){
      _availabilityAmount = amount;
    }else if(type == 'territory_control'){
      _territoryControlAmount = amount;
    }else if(type == 'public_order_service'){
      _publicOrderServiceAmount = amount;
    }
    notifyListeners();
  }

  void updateExtraAllowanceStatus(ServiceAllowanceModel allowance){

    ServiceAllowanceModel allowanceItem = _extraServiceAllowancesList
        .where((item) => item.uniqueId == allowance.uniqueId)
        .first;

    allowanceItem.status = allowance.status;

    notifyListeners();
  }

  void updateExtraAllowanceAmount(ServiceAllowanceModel allowance){

    print('amount: ${allowance.amount}');
    ServiceAllowanceModel allowanceItem = _extraServiceAllowancesList
        .where((item) => item.uniqueId == allowance.uniqueId)
        .first;

    allowanceItem.amount = allowance.amount;
    notifyListeners();
  }

  void removeDayInterval(Map<String, dynamic> interval){
    _userDayIntervals.remove(interval);
    print('${_userDayIntervals}');
    notifyListeners();
  }

  void setShiftName(String name) {
    _shiftName = name;
    notifyListeners();
  }

  void setServiceStartTime(TimeOfDay time) {
    _temporaryServiceStartTime = time;
    notifyListeners();
  }

  void setServiceEndTime(TimeOfDay time) {
    _temporaryServiceEndTime = time;
    notifyListeners();
  }

  void updateIconsVisibility() {
    if(_iconsVisible == true){
      _iconsVisible = false;
    }else{
      _iconsVisible = true;
    }
    notifyListeners();
  }

  void setIcon(Map<String, dynamic> icon) {
    _icon = icon;
    notifyListeners();
  }

  void setIconColor(Color color) {
    _iconColor = color;
    print('$_iconColor');
    notifyListeners();
  }

  // void addServiceTime(TimeOfDay startTime, TimeOfDay endTime, int intervalId, String intervalName){  // type: start or end
  //   _intervalServicesList.add(
  //       {'start_time': startTime, 'end_time': endTime,
  //         'interval_id': intervalId, 'interval_name': intervalName}
  //   );
  //
  //   print('Interval List Test: ${_intervalServicesList}');
  //   _temporaryServiceOn = false;
  //   _temporaryServiceStartTime = const TimeOfDay(hour: 9, minute: 0);
  //   _temporaryServiceEndTime = const TimeOfDay(hour: 17, minute: 0);
  //
  //   notifyListeners();
  // }

  // void setNewIntervalService(){
  //   _temporaryServiceOn = true;
  //   notifyListeners();
  // }

  // void setTemoraryIntervalServiceTimes(TimeOfDay time, String type){
  //   if(type == 'start'){
  //     _temporaryServiceStartTime = time;
  //   }else {
  //     _temporaryServiceEndTime = time;
  //   }
  //
  //   notifyListeners();
  // }

  void setStartTime(TimeOfDay time){
    _shiftStartTime = time;
    notifyListeners();
  }

  void setEndTime(TimeOfDay time){
    _shiftEndTime = time;
    notifyListeners();
  }

  void setIsDateRange(bool value){
    _isDateRange = value;
    notifyListeners();
  }

  void setShiftDate(String startDate, String endDate){
    _startDate = startDate;
    _endDate = endDate;
    notifyListeners();
  }

  void setShiftSingleDate(String date){
    _singleDate = date;
    notifyListeners();
  }

  void saveShiftDate(String startDate, String endDate, bool isDateRange){
    _finalStartDate = startDate;
    _finalEndDate = endDate;
    _isFinalDateRange = isDateRange;
    notifyListeners();
  }

  void addExtraServiceTime(Map<String, dynamic> extraServiceTime){
    print('test 3: ${extraServiceTime['unique_id']}');
    _extraServiceTimeList.add(extraServiceTime);
    print('test 3: ${_extraServiceTimeList}');
    notifyListeners();
  }

  void addBreak(Map<String, dynamic> extraBreak){
    _breakList.add(extraBreak);
    notifyListeners();
  }

  void updateExtraServiceTime(int index, Map<String, dynamic> extraServiceTime){

    try {
      for (int i=0;i<_extraServiceTimeList.length;i++) {
        if(_extraServiceTimeList[i]['unique_id'] == extraServiceTime['unique_id']){
          print('test 2');
          _extraServiceTimeList[i]['start_time'] = extraServiceTime['start_time'];
          _extraServiceTimeList[i]['end_time'] = extraServiceTime['end_time'];
        }
      }
    } catch (e) {
      // Handle the case where the item was not found
      print('Item not found in the list.');
    }
    notifyListeners();
  }

  void updateBreak(int index, Map<String, dynamic> breakValue){

    try {
      for (int i=0;i<_breakList.length;i++) {
        if(_breakList[i]['unique_id'] == breakValue['unique_id']){
          print('test 3');
          _breakList[i]['start_time'] = breakValue['start_time'];
          _breakList[i]['end_time'] = breakValue['end_time'];
        }
      }
    } catch (e) {
      // Handle the case where the item was not found
      print('Item not found in the list.');
    }
    notifyListeners();
  }

  void removeExtraService(int index, String uniqueId) {

    print('intervalUniqueId: ${uniqueId}');

    _extraServiceTimeList.removeWhere((item) => (item['unique_id'] == uniqueId));

    notifyListeners();
  }

  void removeBreak(int index, String uniqueId) {

    print('intervalUniqueId: ${uniqueId}');

    _breakList.removeWhere((item) => (item['unique_id'] == uniqueId));

    notifyListeners();
  }
}