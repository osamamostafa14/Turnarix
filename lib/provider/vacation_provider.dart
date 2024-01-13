import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:turnarix/data/model/response/base/api_response.dart';
import 'package:turnarix/data/model/response/base/error_response.dart';
import 'package:turnarix/data/model/response/response_model.dart';
import 'package:turnarix/data/model/vacation_model.dart';
import 'package:turnarix/data/repository/vacation_repo.dart';

class VacationProvider with ChangeNotifier {
  final VacationRepo? vacationRepo;
  VacationProvider({@required this.vacationRepo});

  //Exchange Paginator
  bool _vacationsIsLoading = false;
  bool get vacationsIsLoading => _vacationsIsLoading;

  bool _bottomVacationsLoading = false;
  bool get bottomVacationsLoading => _bottomVacationsLoading;

  List<VacationModel> _vacationsLists = [];
  List<VacationModel> get vacationsLists => _vacationsLists;

  String? _vacationsOffset;
  String? get vacationsOffset => _vacationsOffset;

  int? _totalVacationSize;
  int? get totalVacationSize => _totalVacationSize;

  List<String> _vacationOffsetList = [];

  bool _vacationLoading = false;
  bool get vacationLoading => _vacationLoading;
//END Exchange Paginator


  void getVacationsList(BuildContext? context, String offset) async {

    if(offset == '1'){
      _vacationLoading = true;
    }

    if (!_vacationOffsetList.contains(offset)) {
      _vacationOffsetList.add(offset);
      ApiResponse apiResponse = await vacationRepo!.getVacations(offset);

      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _bottomVacationsLoading = false;
        if (offset == '1') {
          _vacationsLists = [];
        }
        _totalVacationSize = VacationPaginator.fromJson(apiResponse.response!.data).totalSize;
        _vacationsLists.addAll(VacationPaginator.fromJson(apiResponse.response!.data).vacations!);
        _vacationsOffset = VacationPaginator.fromJson(apiResponse.response!.data).offset;
        _vacationLoading = false;
      } else {
        _bottomVacationsLoading = false;
        _vacationLoading = false;
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(content: Text(apiResponse.error.toString())));
      }
    } else {
      if(_vacationLoading) {
        _bottomVacationsLoading = false;
        _vacationLoading = false;
        //notifyListeners();
      }
    }
    notifyListeners();
  }

  void clearOffset() {
    _vacationOffsetList = [];
    _vacationsLists = [];
    notifyListeners();
  }

  void showBottomVacationLoader() {
    _bottomVacationsLoading = true;
    notifyListeners();
  }

  bool _storeLoading = false;
  bool get storeLoading => _storeLoading;

  Future<ResponseModel> storeVacation(BuildContext context, String name) async {
    _storeLoading = true;
    notifyListeners();
    ResponseModel responseModel;
    ApiResponse apiResponse = await vacationRepo!.storeVacation(name);
    _storeLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

      responseModel = ResponseModel(true, 'success!');
      print('Store success');
    } else {
      _storeLoading = false;
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

  Future<ResponseModel> updateVacation(BuildContext context, String name, int vacationId) async {
    _storeLoading = true;
    notifyListeners();
    ResponseModel responseModel;
    ApiResponse apiResponse = await vacationRepo!.updateVacation(name, vacationId);
    _storeLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel(true, 'success!');
      print('Store success');
    } else {
      _storeLoading = false;
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

  Future<ResponseModel> deleteVacation(BuildContext context, int vacationId) async {
    _storeLoading = true;
    notifyListeners();
    ResponseModel responseModel;
    ApiResponse apiResponse = await vacationRepo!.deleteVacation(vacationId);
    _storeLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel(true, 'success!');
      print('Delete success');
    } else {
      _storeLoading = false;
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

  bool _bottomVacationsVisible = false;
  bool get bottomVacationsVisible => _bottomVacationsVisible;
  void updateBottomVacationsVisibility(bool value) {
    _bottomVacationsVisible = value;
    notifyListeners();
  }

}