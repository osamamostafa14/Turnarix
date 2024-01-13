import 'package:turnarix/data/model/response/user_info_model.dart';
import 'package:turnarix/data/model/shifts/calendar_shift_model.dart';

class ExchangeRequestPaginator {
  int? _totalSize;
  String? _limit;
  String? _offset;
  List<ExchangeRequestModel>? _requests;

  ExchangeRequestPaginator(
      {int? totalSize, String? limit, String? offset, List<ExchangeRequestModel>? requests}) {
    this._totalSize = totalSize;
    this._limit = limit;
    this._offset = offset;
    this._requests = requests;

  }

  int? get totalSize => _totalSize;
  String? get limit => _limit;
  String? get offset => _offset;
  List<ExchangeRequestModel>? get requests => _requests;


  ExchangeRequestPaginator.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _limit = json['limit'].toString();
    _offset = json['offset'];

    if (json['requests'] != null) {
      _requests = [];
      json['requests'].forEach((v) {
        _requests!.add(ExchangeRequestModel.fromJson(v));
      });
    }
  }

}

class ExchangeRequestModel {
  int? _id;
  UserInfoModel? _employee;
  CalendarShiftModel? _userShift;
  CalendarShiftModel? _employeeShift;
  String? _status;
  String? _createdAt;
  String? _updatedAt;

  ExchangeRequestModel({
    int? id,
    UserInfoModel? employee,
    CalendarShiftModel? userShift,
    CalendarShiftModel? employeeShift,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    this._id = id;
    this._employee = employee;
    this._userShift = userShift;
    this._employeeShift = employeeShift;
    this._status = status;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int? get id => _id;
  UserInfoModel? get employee => _employee;
  CalendarShiftModel? get userShift => _userShift;
  CalendarShiftModel? get employeeShift => _employeeShift;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  ExchangeRequestModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _employee = UserInfoModel.fromJson(json['employee']);
    _userShift = CalendarShiftModel.fromJson(json['user_shift']);
    _employeeShift = CalendarShiftModel.fromJson(json['employee_shift']);
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
}
