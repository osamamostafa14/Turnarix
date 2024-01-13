import 'package:turnarix/data/model/shifts/intervals_model.dart';

class ShiftsPaginator {
  int? _totalSize;
  String? _limit;
  String? _offset;
  List<ShiftModel>? _shifts;

  ShiftsPaginator(
      {int? totalSize, String? limit,String? offset, List<ShiftModel>? shifts}) {
    this._totalSize = totalSize;
    this._limit = limit;
    this._offset = offset;
    this._shifts = shifts;
  }

  int? get totalSize => _totalSize;
  String? get limit => _limit;
  String? get offset => _offset;
  List<ShiftModel>? get shifts => _shifts;

  ShiftsPaginator.fromJson(Map<String?, dynamic> json) {
    _totalSize = json['total_size'];
    _limit = json['limit'].toString();
    _offset = json['offset'];

    if (json['shifts'] != null) {
      _shifts = [];
      json['shifts'].forEach((v) {
        _shifts!.add(ShiftModel.fromJson(v));
      });
    }
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['total_size'] = this._totalSize;
    data['limit'] = this._limit;
    data['offset'] = this._offset;

    return data;
  }
}

class ShiftModel {
  int? _id;
  String? _shiftName;
  List<IntervalModel>? _intervals;
  String? _createdAt;
  String? _updatedAt;

  ShiftModel({
    int? id,
    String? shiftName,
    List<IntervalModel>? intervals,
    String? createdAt,
    String? updatedAt,
  }) {
    this._id = id;
    this._shiftName = shiftName;
    this._intervals = intervals;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int? get id => _id;
  String? get shiftName => _shiftName;
  List<IntervalModel>? get intervals => _intervals;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  ShiftModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _shiftName = json['name'];
    if (json['intervals'] != null) {
      _intervals = <IntervalModel>[];
      json['intervals'].forEach((v) {
        _intervals!.add(IntervalModel.fromJson(v));
      });
    }
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': _id,
      'name': _shiftName,
      'intervals': _intervals != null ? _intervals!.map((v) => v.toJson()).toList() : null,
      'created_at': _createdAt,
      'updated_at': _updatedAt,
    };
    return data;
  }
}
