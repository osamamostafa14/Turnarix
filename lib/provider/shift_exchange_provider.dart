import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:turnarix/data/model/response/base/api_response.dart';
import 'package:turnarix/data/model/response/base/error_response.dart';
import 'package:turnarix/data/model/response/response_model.dart';
import 'package:turnarix/data/model/shifts/exchange_request_model.dart';
import 'package:turnarix/data/repository/shift_exchange_repo.dart';

class ShiftExchangeProvider with ChangeNotifier {
  final ShiftExchangeRepo? shiftExchangeRepo;
  ShiftExchangeProvider({@required this.shiftExchangeRepo});

  bool _isEmployeeRequests = false;
  bool get isEmployeeRequests => _isEmployeeRequests;

  bool _requestExchangeLoading = false;
  bool get requestExchangeLoading => _requestExchangeLoading;

  DateTime? _seletedDateShiftExchange;
  DateTime? get seletedDateShiftExchange => _seletedDateShiftExchange;

  void updateRequestsType(bool value){
    _isEmployeeRequests = value;
    notifyListeners();
  }

  void setExchangeDateTime(DateTime date) {
    _seletedDateShiftExchange = date;
    notifyListeners();
  }
  void resetExchangeDateTime() {
    _seletedDateShiftExchange = null;
    notifyListeners();
  }


  Future<ResponseModel> requestShiftExchange(BuildContext context, int employeeId, int userCalendarShiftId, int employeeCalendarShiftId) async {
    _requestExchangeLoading = true;
    notifyListeners();
    ResponseModel responseModel;
    ApiResponse apiResponse = await shiftExchangeRepo!.requestShiftExchange(employeeId, userCalendarShiftId, employeeCalendarShiftId);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel(true, 'success!');
      _requestExchangeLoading = false;
      notifyListeners();
    } else {
      responseModel = ResponseModel(true, 'success!');
      _requestExchangeLoading = false;
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


  //Exchange Paginator
  bool _exchangeRequestsIsLoading = false;
  bool get exchangeRequestsIsLoading => _exchangeRequestsIsLoading;

  bool _bottomExchangeRequestsLoading = false;
  bool get bottomExchangeRequestsLoading => _bottomExchangeRequestsLoading;

  List<ExchangeRequestModel> _exchangeRequestLists = [];
  List<ExchangeRequestModel> get exchangeRequestLists => _exchangeRequestLists;

  String? _exchangeRequestsOffset;
  String? get exchangeRequestsOffset => _exchangeRequestsOffset;

  int? _totalExchangeRequestsSize;
  int? get totalExchangeRequestsSize => _totalExchangeRequestsSize;

  List<String> _exchangeRequestsOffsetList = [];

  bool _exchangeRequestsLoading = false;
  bool get exchangeRequestsLoading => _exchangeRequestsLoading;
//END Exchange Paginator



//   //Exchange RECEIVED Paginator
//   bool _exchangeRequestsIsLoading = false;
//   bool get exchangeRequestsIsLoading => _exchangeRequestsIsLoading;
//
//   bool _bottomExchangeRequestsLoading = false;
//   bool get bottomExchangeRequestsLoading => _bottomExchangeRequestsLoading;
//
//   List<ExchangeRequestModel> _exchangeRequestLists = [];
//   List<ExchangeRequestModel> get exchangeRequestLists => _exchangeRequestLists;
//
//   String? _exchangeRequestsOffset;
//   String? get exchangeRequestsOffset => _exchangeRequestsOffset;
//
//   int? _totalExchangeRequestsSize;
//   int? get totalExchangeRequestsSize => _totalExchangeRequestsSize;
//
//   List<String> _exchangeRequestsOffsetList = [];
//
//   bool _exchangeRequestsLoading = false;
//   bool get exchangeRequestsLoading => _exchangeRequestsLoading;
// //END Exchange RECEIVED Paginator


  void showBottomRunningOrdersLoader() {
    _bottomExchangeRequestsLoading = true;
    notifyListeners();
  }

  void getExchangeRequests(BuildContext? context, String offset, String status, String type) async {

    if(offset == '1'){
      _exchangeRequestsIsLoading = true;
    }

    if (!_exchangeRequestsOffsetList.contains(offset)) {
      _exchangeRequestsOffsetList.add(offset);
      ApiResponse apiResponse = await shiftExchangeRepo!.getExchangeRequests(offset, status, type);

      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _bottomExchangeRequestsLoading = false;
        if (offset == '1') {
          _exchangeRequestLists = [];
        }
        _totalExchangeRequestsSize = ExchangeRequestPaginator.fromJson(apiResponse.response!.data).totalSize;
        _exchangeRequestLists.addAll(ExchangeRequestPaginator.fromJson(apiResponse.response!.data).requests!);
        _exchangeRequestsOffset = ExchangeRequestPaginator.fromJson(apiResponse.response!.data).offset;
        _exchangeRequestsIsLoading = false;
      } else {
        _bottomExchangeRequestsLoading = false;
        _exchangeRequestsIsLoading = false;
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(content: Text(apiResponse.error.toString())));
      }
    } else {
      if(_exchangeRequestsIsLoading) {
        _bottomExchangeRequestsLoading = false;
        _exchangeRequestsIsLoading = false;
        //notifyListeners();
      }
    }
    notifyListeners();
  }

  void clearOffset() {
    _exchangeRequestsOffsetList = [];
    _exchangeRequestLists = [];
    notifyListeners();
  }

  Future<ResponseModel> exchangeRequestStatus(BuildContext context, int requestId, String status) async {
    _requestExchangeLoading = true;
    notifyListeners();
    ResponseModel responseModel;
    ApiResponse apiResponse = await shiftExchangeRepo!.exchangeRequestStatus(requestId, status);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel(true, 'success!');
      _requestExchangeLoading = false;
      notifyListeners();
    } else {
      responseModel = ResponseModel(true, 'success!');
      _requestExchangeLoading = false;
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
}