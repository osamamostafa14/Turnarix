import 'package:turnarix/data/model/response/user_info_model.dart';
import 'package:turnarix/data/model/shifts/calendar_shift_model.dart';

class VacationPaginator {
  int? _totalSize;
  String? _limit;
  String? _offset;
  List<VacationModel>? _vacations;

  VacationPaginator(
      {int? totalSize, String? limit, String? offset, List<VacationModel>? vacations}) {
    this._totalSize = totalSize;
    this._limit = limit;
    this._offset = offset;
    this._vacations = vacations;

  }

  int? get totalSize => _totalSize;
  String? get limit => _limit;
  String? get offset => _offset;
  List<VacationModel>? get vacations => _vacations;


  VacationPaginator.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _limit = json['limit'].toString();
    _offset = json['offset'];

    if (json['vacations'] != null) {
      _vacations = [];
      json['vacations'].forEach((v) {
        _vacations!.add(VacationModel.fromJson(v));
      });
    }
  }

}


class VacationModel {
  int? _id;
  int? _userId;
  String? _name;
  String? _startDate;
  String? _endDate;
  String? _createdAt;
  String? _updatedAt;

  VacationModel({
    int? id,
    int? userId,
    String? name,
    String? startDate,
    String? endDate,
    String? createdAt,
    String? updatedAt,
  }) {
    this._id = id;
    this._userId = userId;
    this._name = name;
    this._startDate = startDate;
    this._endDate = endDate;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int? get id => _id;
  int? get userId => _userId;
  String? get name => _name;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  VacationModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _name = json['name'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': _id,
      'user_id': _userId,
      'name': _name,
      'start_date': _startDate,
      'end_date': _endDate,
      'created_at': _createdAt,
      'updated_at': _updatedAt,
    };
    return data;
  }
}

