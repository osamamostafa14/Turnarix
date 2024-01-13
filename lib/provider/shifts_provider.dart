import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:turnarix/data/model/response/base/api_response.dart';
import 'package:turnarix/data/model/response/base/error_response.dart';
import 'package:turnarix/data/model/response/response_model.dart';
import 'package:turnarix/data/model/shifts/intervals_model.dart';
import 'package:turnarix/data/model/shifts/service_allowance_model.dart';
import 'package:turnarix/data/model/shifts/shift_model.dart';
import 'package:turnarix/data/model/shifts/vacation_model.dart';
import 'package:turnarix/data/model/shifts/voucher_model.dart';
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


  // TimeOfDay _temporaryServiceStartTime = const TimeOfDay(hour: 9, minute: 0);
  // TimeOfDay get temporaryServiceStartTime => _temporaryServiceStartTime;

  List<Map<String, dynamic>> _mainServiceTimesList = [];
  List<Map<String, dynamic>> get mainServiceTimesList => _mainServiceTimesList;

  // TimeOfDay _temporaryServiceEndTime =  const TimeOfDay(hour: 17, minute: 0);
  // TimeOfDay get temporaryServiceEndTime => _temporaryServiceEndTime;

  bool _temporaryServiceOn = false;
  bool get temporaryServiceOn => _temporaryServiceOn;

  String? _shiftName;
  String? get shiftName => _shiftName;

  // Map<String, dynamic>? _icon;
  // Map<String, dynamic>? get icon => _icon;

  bool _iconsVisible = false;
  bool get iconsVisible => _iconsVisible;

  // Color _iconColor = Color(0xff2196f3);
  // Color get iconColor => _iconColor;

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

  /// Breaks
  List<Map<String, dynamic>> _breakList = [];
  List<Map<String, dynamic>> get breakList => _breakList;

  /// ExtraOrdinario


  final Random random = Random();

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

  bool _foodStamps = true;
  bool get foodStamps => _foodStamps;

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


  //Shifts List
  bool _shiftsIsLoading = false;
  bool get shiftsIsLoading => _shiftsIsLoading;

  bool _bottomShiftsLoading = false;
  bool get bottomShiftsLoading => _bottomShiftsLoading;

  List<ShiftModel> _shiftsList = [];
  List<ShiftModel> get shiftsList => _shiftsList;

  String? _shiftsOffset;
  String? get shiftsOffset => _shiftsOffset;

  int? _totalShiftsSize;
  int? get totalShiftsSize => _totalShiftsSize;

  List<String> _shiftsOffsetList = [];

  bool _getIntervalLoading = false;
  bool get getIntervalLoading => _getIntervalLoading;


  // List<VacationModel> _vacations = [];
  // List<VacationModel> get vacations => _vacations;

  List<String> _vacationNames = [
    'Congedo Ordinario',
    'Congedo Straordinario',
    'Legge 937',
    'Recupero Riposo',
    'Banca Ore/Riposo Compensativo',
    'Permessi Orari',
    'L. 104',
    'Donazione Sangue',
    'Aggiungi altre Assenze',
    'Aspettativa',
    'Parentale',
    'Malattia bambino',
    'Permesso Studio',
    'Mandato amministrativo',
    'Visita Medica',
    'Conferma',
  ];
  List<String> get vacationNames => _vacationNames;

  DateTime? _vacationStartTime;
  DateTime? get vacationStartTime => _vacationStartTime;

  DateTime? _vacationEndTime;
  DateTime? get vacationEndTime => _vacationEndTime;

  List<int> _removedVacationsIds = [];
  List<int> get removedVacationsIds => _removedVacationsIds;

  void setVacationStartTime(DateTime date) {
    _vacationStartTime = date;
    notifyListeners();
  }

  void setVacationEndTime(DateTime date) {
    _vacationEndTime = date;
    notifyListeners();
  }

  // void resetVacationDates(){
  //   _vacationStartTime = null;
  //   _vacationEndTime = null;
  //   notifyListeners();
  // }

  //END Shifts List

  // void getShiftslist(BuildContext? context, String offset) async {
  //   print('test 1');
  //   if(offset == '1'){
  //     _shiftsIsLoading = true;
  //   }
  //
  //   if (!_shiftsOffsetList.contains(offset)) {
  //     _shiftsOffsetList.add(offset);
  //     ApiResponse apiResponse = await shiftsRepo!.getShiftslist(offset);
  //
  //     if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
  //       _bottomShiftsLoading = false;
  //       if (offset == '1') {
  //         _shiftsList = [];
  //       }
  //       _totalShiftsSize = ShiftsPaginator.fromJson(apiResponse.response!.data).totalSize;
  //       _shiftsList!.addAll(ShiftsPaginator.fromJson(apiResponse.response!.data).shifts!);
  //       _shiftsOffset = ShiftsPaginator.fromJson(apiResponse.response!.data).offset;
  //       _shiftsIsLoading = false;
  //     } else {
  //       _bottomShiftsLoading = false;
  //       _shiftsIsLoading = false;
  //       ScaffoldMessenger.of(context!).showSnackBar(SnackBar(content: Text(apiResponse.error.toString())));
  //     }
  //   } else {
  //     if(_shiftsIsLoading) {
  //       _bottomShiftsLoading = false;
  //       _shiftsIsLoading = false;
  //       //notifyListeners();
  //     }
  //   }
  //   notifyListeners();
  // }


  void getShiftslist(BuildContext? context) async {
    _shiftsIsLoading = true;
    notifyListeners();

      ApiResponse apiResponse = await shiftsRepo!.getShiftslist();
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _shiftsList = [];
        apiResponse.response!.data.forEach((item) {
          _shiftsList.add(ShiftModel.fromJson(item));
        });

        _shiftsIsLoading = false;
      } else {
        _shiftsIsLoading = false;
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(content: Text(apiResponse.error.toString())));
      }

    notifyListeners();
  }

  void clearOffset() {
    _shiftsList = [];
    _shiftsOffsetList = [];
    notifyListeners();
  }

  void showBottomServicesLoader() {
    _bottomShiftsLoading = true;
    notifyListeners();
  }

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

  void updateFoodStamps(){
    print('testtt');
    _foodStamps == false? _foodStamps = true: _foodStamps = false;
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


  // void initMainServiceTimes(TimeOfDay time, String uniqueId, int intervalId, String type) {
  //   _mainServiceTimesList.add({
  //     'start_time': const TimeOfDay(hour: 9, minute: 0),
  //     'end_time': const TimeOfDay(hour: 9, minute: 0),
  //     'unique_id': uniqueId,s
  //     'interval_id': intervalId,
  //   });
  //   notifyListeners();
  // }

  // void updateMainServiceTimes(TimeOfDay time, String uniqueId, int intervalId, String type) {
  //
  //   try {
  //     for (int i=0;i<_mainServiceTimesList.length;i++) {
  //       if(_mainServiceTimesList[i]['unique_id'] == uniqueId){
  //         if(type == 'start_time'){
  //           _mainServiceTimesList[i]['start_time'] = time;
  //         }else{
  //           _mainServiceTimesList[i]['end_time'] = time;
  //         }
  //
  //       }
  //     }
  //   } catch (e) {
  //     // Handle the case where the item was not found
  //     print('Item not found in the list.');
  //   }
  //
  //   notifyListeners();
  // }

  // void setServiceEndTime(TimeOfDay time) {
  //   _temporaryServiceEndTime = time;
  //   notifyListeners();
  // }

  void updateIconsVisibility() {
    if(_iconsVisible == true){
      _iconsVisible = false;
    }else{
      _iconsVisible = true;
    }
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


  /// NEW
  List<IntervalModel> _selectedDayIntervals = [];
  List<IntervalModel>? get selectedDayIntervals => _selectedDayIntervals;

  List<IntervalModel> _mainDayIntervals = [];
  List<IntervalModel>? get mainDayIntervals => _mainDayIntervals;  // that comes from api

  List<IntervalServiceModel> _selectedServiceTimeList = [];
  List<IntervalServiceModel> get selectedServiceTimeList => _selectedServiceTimeList;

  List<IntervalBreakModel> _selectedBreakList = [];
  List<IntervalBreakModel> get selectedBreakList => _selectedBreakList;

  List<ServiceAllowanceModel> _extraServiceAllowancesList = [];
  List<ServiceAllowanceModel> get extraServiceAllowancesList => _extraServiceAllowancesList;

  /// API
  bool _newShiftLoading = false;
  bool get newShiftLoading => _newShiftLoading;

  int? _shiftId;
  int? get shiftId => _shiftId;

  bool _intervalLoading = false;
  bool get intervalLoading => _intervalLoading;

  // String? _intervalTitle;
  // String? get intervalTitle => _intervalTitle;

  String _allowanceAmount = '';
  String get allowanceAmount => _allowanceAmount;

  String _allowanceName = '';
  String get allowanceName => _allowanceName;

  List<IntervalExtraordinaryModel> _extraordinaryList = [];
  List<IntervalExtraordinaryModel> get extraordinaryList => _extraordinaryList;

  List<VoucherModel> _vouchers = [];
  List<VoucherModel> get vouchers => _vouchers;

  bool _vacationLoading = false;
  bool get vacationLoading => _vacationLoading;

  void addDayInterval(IntervalModel interval){
    print('Test 333 ${interval.name}');
    _selectedDayIntervals.add(interval);
    notifyListeners();
  }

  void removeDayInterval(IntervalModel interval){
    _selectedDayIntervals.remove(interval);
    notifyListeners();
  }

  void setIntervalTitle(int intervalId, String type, String text){
    IntervalModel interval = _mainDayIntervals
        .where((item) => item.id == intervalId)
        .first;

    if(type == 'title'){
      interval.title= text;
    }else if(type == 'icon_name'){
      interval.iconName = text;
    }
    notifyListeners();
  }

  Future<ResponseModel> addNewShift(BuildContext context, String name) async {
    _newShiftLoading = true;
    notifyListeners();
    ResponseModel responseModel;
    ApiResponse apiResponse = await shiftsRepo!.addNewShift(name);
    _newShiftLoading = false;

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel(true, 'success!');
      _shiftId = apiResponse.response!.data['shift_id'];
      print('success here ');
    } else {
      _newShiftLoading = false;
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors![0].message);
        errorMessage = errorResponse.errors![0].message!;

      }
      responseModel = ResponseModel(false, errorMessage);
    }
    notifyListeners();
    return responseModel;
  }

  void getIntervalsList(BuildContext? context, int shiftId, bool fromMainShiftScreen) async {
    _getIntervalLoading = true;
    if(fromMainShiftScreen){
      _mainDayIntervals = [];
    }
    ApiResponse apiResponse = await shiftsRepo!.getIntervalList(shiftId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _mainDayIntervals = [];
      var data = apiResponse.response!.data;
      data.forEach((interval) {
        IntervalModel model = IntervalModel.fromJson(interval);
        _mainDayIntervals.add(model);
      });
      _getIntervalLoading = false;
    } else {
      _getIntervalLoading = false;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(content: Text(apiResponse.error.toString())));
    }
    notifyListeners();
  }

  Future<ResponseModel> addShiftIntervals(BuildContext context, List<IntervalModel> intervals, int shiftId) async {
    _intervalLoading = true;
    notifyListeners();
    ResponseModel responseModel;
    ApiResponse apiResponse = await shiftsRepo!.addShiftIntervals(intervals, shiftId);
    _intervalLoading = false;

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _selectedDayIntervals = [];
      notifyListeners();
      responseModel = ResponseModel(true, 'success!');
    } else {
      _intervalLoading = false;
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors![0].message);
        errorMessage = errorResponse.errors![0].message!;
      }
      responseModel = ResponseModel(false, errorMessage);
    }
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> getShiftsIntervals(BuildContext? context, int shiftId) async {
    _mainDayIntervals=[];
    ResponseModel _responseModel;
    ApiResponse apiResponse = await shiftsRepo!.getShiftsIntervals(shiftId);
    if(apiResponse.response != null){
      if (apiResponse.response!.statusCode == 200) {

        apiResponse.response!.data.forEach((item) {
          IntervalModel intervalModel = IntervalModel.fromJson(item);
          _mainDayIntervals.add(intervalModel);
        });
        _responseModel = ResponseModel(true, 'successful');
      } else {
        notifyListeners();
        String _errorMessage;
        if (apiResponse.error is String) {
          _errorMessage = apiResponse.error.toString();
        } else {
          _errorMessage = apiResponse.error.errors[0].message;
        }
        print(_errorMessage);
        _responseModel = ResponseModel(false, _errorMessage);
        // ApiChecker.checkApi(context, apiResponse);
      }
    }else{
      String _errorMessage;
      if (apiResponse.error is String) {
        _errorMessage = apiResponse.error.toString();
      } else {
        _errorMessage = apiResponse.error.errors[0].message;
      }
      print(_errorMessage);
      _responseModel = ResponseModel(false, _errorMessage);
    }

    notifyListeners();
    return _responseModel;
  }

  void initPageOne(){
    _selectedDayIntervals = [];
    notifyListeners();
  }
  void setShiftName(String name) {
    _shiftName = name;
    notifyListeners();
  }

  void addIntervalServiceTime(IntervalServiceModel serviceTime){
    _selectedServiceTimeList.add(serviceTime);
    notifyListeners();
  }

  void updateServiceTime(int id, TimeOfDay time, String type){
    IntervalServiceModel service = _selectedServiceTimeList
        .where((item) => item.id == id)
        .first;

    DateTime _now = DateTime.now();
    String _time = DateTime(_now.year, _now.month,_now.day, time.hour, time.minute).toString();
    print('Test 1 ${_time}');

    if(type == 'start'){
      service.startService = _time;
      print('Test 1 ${jsonEncode(service)}');
    }else{
      service.endService = _time;
    }
    notifyListeners();
  }

  void removeServiceTime(int id) {
    _selectedServiceTimeList.removeWhere((item) => (item.id == id));
    notifyListeners();
  }

  /// BREAKS
  void addIntervalBreak(IntervalBreakModel breakModel){
    _selectedBreakList.add(breakModel);
    notifyListeners();
  }

  void removeBreak(int id) {
    _selectedBreakList.removeWhere((item) => (item.id == id));
    notifyListeners();
  }

  void updateBreak(int id, TimeOfDay time, String type){
    IntervalBreakModel breakModel = _selectedBreakList
        .where((item) => item.id == id)
        .first;

    DateTime _now = DateTime.now();
    String _time = DateTime(_now.year, _now.month,_now.day, time.hour, time.minute).toString();

    if(type == 'start'){
      breakModel.startTime = _time;
    }else{
      breakModel.endTime = _time;
    }
    notifyListeners();
  }

  void initAllowance(int intervalId) {
    List<String> names = ['Servizio Esterno', 'Missione', 'Cambio Turno', 'Reperibilità', 'Controllo del Territorio Serale',
      'Servizio Ordine Pubblico'];

    print('Test 11');
    names.forEach((name) {
      _extraServiceAllowancesList.add(ServiceAllowanceModel(
        id: random.nextInt(10000) + 1, /// Temprorary Id
          name: name,
          status: true,
          intervalId: intervalId
      ));
      print('Name: $name');
    });
    notifyListeners();
  }

  void updateExtraAllowanceAmount(ServiceAllowanceModel allowance){
    ServiceAllowanceModel allowanceItem = _extraServiceAllowancesList
        .where((item) => item.id == allowance.id)
        .first;

    allowanceItem.amount = allowance.amount;
    notifyListeners();
  }

  void updateExtraAllowanceStatus(ServiceAllowanceModel allowance){
    ServiceAllowanceModel allowanceItem = _extraServiceAllowancesList
        .where((item) => item.id == allowance.id)
        .first;

    allowanceItem.status = allowance.status;
    notifyListeners();
  }

  void resetAllowanceTexts(){
    _allowanceAmount = '';
    _allowanceName = '';
    notifyListeners();
  }

  /// VOUCHERS
  void removeVoucher(int id) {
    _vouchers.removeWhere((item) => (item.id == id));
    notifyListeners();
  }

  void updateVoucherInfo(int id, String type, value){

    VoucherModel voucher = _vouchers
        .where((item) => item.id == id)
        .first;

    if(type == 'name'){
      voucher.name = value;
    }else if(type == 'amount'){
      voucher.amount = value;
    }

    notifyListeners();
  }

  void addVoucher(VoucherModel voucher){
    _vouchers.add(voucher);
    notifyListeners();
  }

  /// EXTRA ORDINARY
  void removeExtraordinary(int id) {
    _extraordinaryList.removeWhere((item) => (item.id == id));
    notifyListeners();
  }

  void updateExtraordinaryTimes(int id, TimeOfDay time, String type){

    IntervalExtraordinaryModel extraordinaryItem = _extraordinaryList
        .where((item) => item.id == id)
        .first;

    DateTime _now = DateTime.now();
    String _time = DateTime(_now.year, _now.month,_now.day, time.hour, time.minute).toString();

    if(type == 'start_time'){
      extraordinaryItem.startTime = _time;
    }else if(type == 'end_time'){
      extraordinaryItem.endTime = _time;
    }

    notifyListeners();
  }

  void updateExtraordinaryInfo(int id, String type, value){

    IntervalExtraordinaryModel extraordinaryItem = _extraordinaryList
        .where((item) => item.id == id)
        .first;

    if(type == 'title'){
      extraordinaryItem.title= value;
    }else if(type == 'amount'){
      extraordinaryItem.amountPerHour= value;
    }else if(type == 'type'){
      extraordinaryItem.type= value;
    }

    notifyListeners();
  }

  void addExtraordinary(IntervalExtraordinaryModel extraordinaryValue){
    _extraordinaryList.add(extraordinaryValue);
    notifyListeners();
  }

  Future<ResponseModel> storeShiftIntervalInfo(BuildContext context,int shiftId, IntervalModel interval) async {
    _intervalLoading = true;
    notifyListeners();
    ResponseModel responseModel;
    ApiResponse apiResponse = await shiftsRepo!.storeShiftIntervalInfo(shiftId, interval);
    _intervalLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _selectedDayIntervals = [];
      notifyListeners();
      responseModel = ResponseModel(true, 'success!');
      print('interval success ${apiResponse.response!.data['message']}');
    } else {
      _intervalLoading = false;
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors![0].message);
        errorMessage = errorResponse.errors![0].message!;
      }
      responseModel = ResponseModel(false, errorMessage);
    }
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> storeNewShiftIntervalInfo(BuildContext context,IntervalModel interval) async {
    _intervalLoading = true;
    notifyListeners();
    ResponseModel responseModel;
    ApiResponse apiResponse = await shiftsRepo!.storeNewShiftIntervalInfo(interval);
    _intervalLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _selectedDayIntervals = [];
      notifyListeners();
      responseModel = ResponseModel(true, 'success!');
      print('interval success ${apiResponse.response!.data['message']}');
    } else {
      _intervalLoading = false;
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors![0].message);
        errorMessage = errorResponse.errors![0].message!;
      }
      responseModel = ResponseModel(false, errorMessage);
    }
    notifyListeners();
    return responseModel;
  }

  void setIcon(Map<String, dynamic> icon, intervalId) {
    IntervalModel interval = _mainDayIntervals
        .where((item) => item.id == intervalId)
        .first;

    interval.iconInfo= icon;

    notifyListeners();
  }

  void setIconColor(Color color, intervalId) {
    IntervalModel interval = _mainDayIntervals
        .where((item) => item.id == intervalId)
        .first;

    interval.localIconColor= color;

    notifyListeners();
  }

  Future<ResponseModel> addShiftToCalendar(BuildContext context,int shiftId, String date) async {

    notifyListeners();
    ResponseModel responseModel;
    ApiResponse apiResponse = await shiftsRepo!.addShiftToCalendar(shiftId, date);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel(true, 'success!');

    } else {

      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors![0].message);
        errorMessage = errorResponse.errors![0].message!;
      }
      responseModel = ResponseModel(false, errorMessage);
    }
    notifyListeners();
    return responseModel;
  }

  ///// neww 2
  Future<ResponseModel> addVacation(BuildContext context,String startTime, String endTime, String name, int intervalId) async {
    _vacationLoading = true;
    notifyListeners();
    ResponseModel responseModel;
    ApiResponse apiResponse = await shiftsRepo!.addShiftVacation(startTime, endTime, name, intervalId);
    _vacationLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

      responseModel = ResponseModel(true, 'success!');
      _vacationStartTime = null;
      _vacationEndTime = null;

    } else {
      _vacationLoading = false;
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors![0].message);
        errorMessage = errorResponse.errors![0].message!;
      }
      responseModel = ResponseModel(false, errorMessage);
    }
    notifyListeners();
    return responseModel;
  }


  Future<ResponseModel> updateVacation(BuildContext context,String startTime, String endTime, int vacationId) async {
    _vacationLoading = true;
    notifyListeners();
    ResponseModel responseModel;
    ApiResponse apiResponse = await shiftsRepo!.updateVacation(startTime, endTime,vacationId);
    _vacationLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

      responseModel = ResponseModel(true, 'success!');
      _vacationStartTime = null;
      _vacationEndTime = null;

    } else {
      _vacationLoading = false;
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors![0].message);
        errorMessage = errorResponse.errors![0].message!;
      }
      responseModel = ResponseModel(false, errorMessage);
    }
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> removeVacation(BuildContext context,int vacationId) async {
   // _vacationLoading = true;
    notifyListeners();
    ResponseModel responseModel;
    ApiResponse apiResponse = await shiftsRepo!.removeVacation(vacationId);
   // _vacationLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _removedVacationsIds.add(vacationId);
      responseModel = ResponseModel(true, 'success!');
      _vacationStartTime = null;
      _vacationEndTime = null;

    } else {
    //  _vacationLoading = false;
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors![0].message);
        errorMessage = errorResponse.errors![0].message!;
      }
      responseModel = ResponseModel(false, errorMessage);
    }
    notifyListeners();
    return responseModel;
  }


  /// create shift
  String? _newIntervalTitle;
  String? get newIntervalTitle => _newIntervalTitle;

  Map<String, dynamic>? _icon;
  Map<String, dynamic>? get icon => _icon;

  Color? _iconColor;
  Color? get iconColor => _iconColor;

  bool _serviceTimesVisible = false;
  bool get serviceTimesVisible => _serviceTimesVisible;

  bool _breaksVisible = false;
  bool get breaksVisible => _breaksVisible;

  void updateServiceTimesVisibility() {
    _serviceTimesVisible = _serviceTimesVisible == false? _serviceTimesVisible = true : _serviceTimesVisible = false;
    notifyListeners();
  }

  void updateBreaksVisibility() {
    _breaksVisible = _breaksVisible == false? _breaksVisible = true : _breaksVisible = false;
    notifyListeners();
  }

  void setNewIntervalTitle(String text){
    _newIntervalTitle= text;
    notifyListeners();
  }

  void setNewIcon(Map<String, dynamic> icon) {
    _icon= icon;
    notifyListeners();
  }

  void setNewIconColor(Color color) {
    _iconColor = color;
    notifyListeners();
  }
}