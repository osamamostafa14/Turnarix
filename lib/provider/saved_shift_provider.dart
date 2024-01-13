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
import 'package:turnarix/data/model/shifts/voucher_model.dart';
import 'package:turnarix/data/repository/saved_shift_repo.dart';
import 'package:turnarix/data/repository/shifts_repo.dart';

class SavedShiftProvider with ChangeNotifier {
  final SavedShiftsRepo? shiftRepo;
  SavedShiftProvider({@required this.shiftRepo});

  String? _shiftName;
  String? get shiftName => _shiftName;

  bool? _updateNameLoading;
  bool? get updateNameLoading => _updateNameLoading;

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

  List<IntervalModel> _selectedDayIntervals = [];
  List<IntervalModel>? get selectedDayIntervals => _selectedDayIntervals;

  List<int> _temporaryRemovedIntervals = [];
  List<int>? get temporaryRemovedIntervals => _temporaryRemovedIntervals;

  List<IntervalModel> _mainDayIntervals = [];  /// that com from api
  List<IntervalModel> get mainDayIntervals => _mainDayIntervals;

  ShiftModel? _selectedShift;
  ShiftModel? get selectedShift => _selectedShift;

  bool _intervalLoading = false;
  bool get intervalLoading => _intervalLoading;

  bool _getIntervalLoading = false;
  bool get getIntervalLoading => _getIntervalLoading;

  bool _iconsVisible = false;
  bool get iconsVisible => _iconsVisible;

  String? _intervalTitle;
  String? get intervalTitle => _intervalTitle;

  Map<String, dynamic>? _icon;
  Map<String, dynamic>? get icon => _icon;

  Color? _iconColor;
  Color? get iconColor => _iconColor;

  bool _foodStamps = true;
  bool get foodStamps => _foodStamps;

  List<ServiceAllowanceModel> _extraServiceAllowancesList = [];
  List<ServiceAllowanceModel> get extraServiceAllowancesList => _extraServiceAllowancesList;

  String _allowanceAmount = '';
  String get allowanceAmount => _allowanceAmount;

  String _allowanceName = '';
  String get allowanceName => _allowanceName;

  List<IntervalServiceModel> _selectedServiceTimeList = [];
  List<IntervalServiceModel> get selectedServiceTimeList => _selectedServiceTimeList;

  List<IntervalBreakModel> _selectedBreakList = [];
  List<IntervalBreakModel> get selectedBreakList => _selectedBreakList;

  List<IntervalExtraordinaryModel> _extraordinaryList = [];
  List<IntervalExtraordinaryModel> get extraordinaryList => _extraordinaryList;

  List<VoucherModel> _voucherList = [];
  List<VoucherModel> get voucherList => _voucherList;

  final Random random = Random();

  void initInterval(String title, String iconName, Color iconColor, bool foodStamp, List<IntervalServiceModel> services,
      List<IntervalBreakModel> breaks,List<ServiceAllowanceModel> allowances,List<IntervalExtraordinaryModel> extraordinaries ){
    _intervalTitle = title;
    _icon = {
      'name': iconName,
    };
    _icon!['name'] = iconName;
    _iconColor = iconColor;
    _foodStamps = foodStamp;
    _selectedServiceTimeList = services;
    _selectedBreakList = breaks;
    _extraServiceAllowancesList = allowances;
    _extraordinaryList = extraordinaries;

    notifyListeners();
  }
  void setShiftName(String name) {
    _shiftName = name;
    notifyListeners();
  }

  void addDayInterval(IntervalModel interval){
    _selectedDayIntervals.add(interval);
    notifyListeners();
  }

  void removeDayInterval(IntervalModel interval){
    _selectedDayIntervals.remove(interval);
    notifyListeners();
  }

  void setSelectedShift(ShiftModel shift){
    _selectedShift = shift;
    notifyListeners();
  }

  void resetValues(){
    _shiftName = null;
    _selectedDayIntervals = [];
    _temporaryRemovedIntervals = [];
    notifyListeners();
  }

  void resetIcon(){
    _icon = null;
    notifyListeners();
  }

  Future<ResponseModel> updateName(BuildContext context, String name, int shiftId) async {
    _updateNameLoading = true;
    notifyListeners();
    ResponseModel responseModel;
    ApiResponse apiResponse = await shiftRepo!.updateShiftName(name, shiftId);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel(true, 'success!');
      print('success here ');
    } else {
      _shiftName = null;
      _updateNameLoading = false;
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

  Future<ResponseModel> removeSavedInterval(BuildContext context, int intervalId) async {
    _updateNameLoading = true;
    _temporaryRemovedIntervals.add(intervalId);
    notifyListeners();
    ResponseModel responseModel;
    ApiResponse apiResponse = await shiftRepo!.removeSavedInterval(intervalId);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel(true, 'success!');
    } else {
      _temporaryRemovedIntervals.remove(intervalId);
      _shiftName = null;
      _updateNameLoading = false;
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

  Future<ResponseModel> addShiftIntervals(BuildContext context, List<IntervalModel> intervals, int shiftId) async {
    _intervalLoading = true;
    notifyListeners();
    ResponseModel responseModel;
    ApiResponse apiResponse = await shiftRepo!.addShiftIntervals(intervals, shiftId);
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

  void getIntervalsList(BuildContext? context, int shiftId, bool fromMainShiftScreen) async {
    _getIntervalLoading = true;
    if(fromMainShiftScreen){
      _mainDayIntervals = [];
    }
      ApiResponse apiResponse = await shiftRepo!.getIntervalList(shiftId);
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

  /// EDIT INTERVAL
  void updateIconsVisibility() {
    if(_iconsVisible == true){
      _iconsVisible = false;
    }else{
      _iconsVisible = true;
    }
    notifyListeners();
  }

  void setIntervalTitle(String title){
    _intervalTitle = title;
    notifyListeners();
  }

  void setIcon(Map<String, dynamic> icon) {
    _icon = icon;
    notifyListeners();
  }

  void setIconColor(Color color) {
    _iconColor = color;
    notifyListeners();
  }

  void updateFoodStamps(){
    _foodStamps == false? _foodStamps = true: _foodStamps = false;
    notifyListeners();
  }

  void initAllowance(int intervalId) {
    List<String> names = ['Servizio Esterno', 'Missione', 'Cambio Turno', 'Reperibilità', 'Controllo del Territorio Serale',
      'Servizio Ordine Pubblico'];

    names.forEach((name) {
      _extraServiceAllowancesList.add(ServiceAllowanceModel(
          id: random.nextInt(10000) + 1, /// Temprorary Id
          name: name,
          status: true,
          intervalId: intervalId
      ));
    });
    notifyListeners();
  }

  void resetAllowanceTexts(){
    _allowanceAmount = '';
    _allowanceName = '';
    notifyListeners();
  }

  void updateExtraAllowanceStatus(ServiceAllowanceModel allowance){
    ServiceAllowanceModel allowanceItem = _extraServiceAllowancesList
        .where((item) => item.id == allowance.id)
        .first;

    allowanceItem.status = allowance.status;
    notifyListeners();
  }

  void updateExtraAllowanceAmount(ServiceAllowanceModel allowance){
    ServiceAllowanceModel allowanceItem = _extraServiceAllowancesList
        .where((item) => item.id == allowance.id)
        .first;

    allowanceItem.amount = allowance.amount;
    notifyListeners();
  }

  /// Service Times
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


  /// VOUCHER
  void removeVoucher(int id) {
    _voucherList.removeWhere((item) => (item.id == id));
    notifyListeners();
  }

  void updateVoucherInfo(int id, String type, value){

    VoucherModel voucher = _voucherList
        .where((item) => item.id == id)
        .first;

    if(type == 'name'){
      voucher.name= value;
    }else if(type == 'amount'){
      voucher.amount= value;
    }

    notifyListeners();
  }

  void addVoucher(VoucherModel voucher){
    _voucherList.add(voucher);
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
    ApiResponse apiResponse = await shiftRepo!.storeShiftIntervalInfo(shiftId, interval);
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
}