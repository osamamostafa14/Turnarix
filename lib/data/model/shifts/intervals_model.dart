import 'dart:ui';
import 'package:turnarix/data/model/shifts/service_allowance_model.dart';
import 'package:turnarix/data/model/shifts/vacation_model.dart';
import 'package:turnarix/data/model/shifts/voucher_model.dart';

class IntervalModel {
  int? _id;
  int? _shiftId;
  String? _name;
  String? _title;
  String? _iconName;
  String? _iconColor;
  List<IntervalServiceModel>? _services;
  List<IntervalBreakModel>? _breaks;
  List<ServiceAllowanceModel>? _allowances;
  int? _foodStamp;
  List<IntervalExtraordinaryModel>? _extraordinaries;
   List<VoucherModel>? _vouchers;
  /// Local only
  Map<String, dynamic>? _iconInfo;
  Color? _localIconColor;

  IntervalModel({
    int? id,
    int? shiftId,
    String? name,
    String? title,
    String? iconName,
    String? iconColor,
    List<IntervalServiceModel>? services,
    List<IntervalBreakModel>? breaks,
    List<ServiceAllowanceModel>? allowances,
    int? foodStamp,
    List<IntervalExtraordinaryModel>? extraordinaries,
    List<VoucherModel>? vouchers,
    /// Local only
    Map<String, dynamic>? iconInfo,
    Color? localIconColor,
  }) {
    this._id = id;
    this._shiftId = shiftId;
    this._name = name;
    this._title = title;
    this._iconName = iconName;
    this._iconColor = iconColor;
    this._services = services;
    this._breaks = breaks;
    this._allowances = allowances;
    this._foodStamp = foodStamp;
    this._extraordinaries = extraordinaries;
    this._vouchers = vouchers;

    this._iconInfo = iconInfo;
    this._localIconColor = localIconColor;

  }

  int? get id => _id;
  int? get shiftId => _shiftId;
  String? get name => _name;
  String? get title => _title;
  String? get iconName => _iconName;
  String? get iconColor => _iconColor;
  List<IntervalServiceModel>? get services => _services;
  List<IntervalBreakModel>? get breaks => _breaks;
  List<ServiceAllowanceModel>? get allowances => _allowances;
  int? get foodStamp => _foodStamp;
  List<IntervalExtraordinaryModel>? get extraordinaries => _extraordinaries;
  List<VoucherModel>? get vouchers => _vouchers;

  /// LOCAL ONLY
  Map<String, dynamic>? get iconInfo => _iconInfo;
  Color? get localIconColor => _localIconColor;

  set title(String? value) {
    _title = value;
  }
  set iconName(String? value) {
    _iconName = value;
  }
  set localIconColor(Color? value) {
    _localIconColor = value;
  }
  set iconInfo(Map<String, dynamic>? value) {
    _iconInfo = value;
  }

  IntervalModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _shiftId = json['shift_id'];
    _title = json['title'];
    _name = json['name'];
    _iconName = json['icon_name'];
    _iconColor = json['icon_color'];
    if (json['services'] != null) {
      _services = <IntervalServiceModel>[];
      json['services'].forEach((v) {
        _services!.add(IntervalServiceModel.fromJson(v));
      });
    }
    if (json['breaks'] != null) {
      _breaks = [];
      json['breaks'].forEach((v) {
        _breaks!.add(IntervalBreakModel.fromJson(v));
      });
    }
    if (json['allowances'] != null) {
      _allowances = [];
      json['allowances'].forEach((v) {
        _allowances!.add(ServiceAllowanceModel.fromJson(v));
      });
    }
    _foodStamp = json['food_stamp'];

    if (json['extraordinaries'] != null) {
      _extraordinaries = [];
      json['extraordinaries'].forEach((v) {
        _extraordinaries!.add(IntervalExtraordinaryModel.fromJson(v));
      });
    }

    if (json['vouchers'] != null) {
      _vouchers = [];
      json['vouchers'].forEach((v) {
        _vouchers!.add(VoucherModel.fromJson(v));
      });
    }

    // if (json['vacations'] != null) {
    //   _vacations = [];
    //   json['vacations'].forEach((v) {
    //     _vacations!.add(VacationModel.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': _id,
      'shift_id': _shiftId,
      'title': _title,
      'name': _name,
      'icon_name': _iconName,
      'icon_color': _iconColor,
      'services': _services != null ? _services!.map((v) => v.toJson()).toList() : null,
      'breaks': _breaks != null ? _breaks!.map((v) => v.toJson()).toList() : null,
      'allowances': _allowances != null ? _allowances!.map((v) => v.toJson()).toList() : null,
      'food_stamp': _foodStamp,
      'extraordinaries': _extraordinaries != null ? _extraordinaries!.map((v) => v.toJson()).toList() : null,
      'vouchers': _vouchers != null ? _vouchers!.map((v) => v.toJson()).toList() : null,
    };
    return data;
  }
}

class IntervalServiceModel {
  int? _id;
  int? _intervalId;
  String? _startService;
  String? _endService;

  IntervalServiceModel(
      {int? id,
        int? intervalId,
        String? startService,
        String? endService,
      }) {
    this._id = id;
    this._intervalId = intervalId;
    this._startService = startService;
    this._endService = endService;
  }

  int? get id => _id;
  int? get intervalId => _intervalId;
  String? get startService => _startService;
  String? get endService => _endService;

  set startService(String? value) {
    _startService = value;
  }

  set endService(String? value) {
    _endService = value;
  }

  IntervalServiceModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _intervalId = json['interval_id'];
    _startService = json['start_service'];
    _endService = json['end_service'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': _id,
      'interval_id': _intervalId,
      'start_service': _startService,
      'end_service': _endService,
    };
    return data;
  }
}


class IntervalBreakModel {
  int? _id;
  int? _intervalId;
  String? _startTime;
  String? _endTime;

  IntervalBreakModel(
      {int? id,
        int? intervalId,
        String? startTime,
        String? endTime,
      }) {
    this._id = id;
    this._intervalId = intervalId;
    this._startTime = startTime;
    this._endTime = endTime;
  }

  int? get id => _id;
  int? get intervalId => _intervalId;
  String? get startTime => _startTime;
  String? get endTime => _endTime;

  set startTime(String? value) {
    _startTime = value;
  }

  set endTime(String? value) {
    _endTime = value;
  }

  IntervalBreakModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _intervalId = json['interval_id'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': _id,
      'interval_id': _intervalId,
      'start_time': _startTime,
      'end_time': _endTime,
    };
    return data;
  }
}

// class IntervalAllowanceModel {
//   int? _id;
//   String? _name;
//   int? _status;
//   double? _amount;
//
//   IntervalAllowanceModel(
//       {int? id,
//         String? name,
//         int? status,
//         double? amount,
//
//       }) {
//     this._id = id;
//     this._name = name;
//     this._status = status;
//     this._amount = amount;
//   }
//
//   int? get id => _id;
//   String? get name => _name;
//   int? get status => _status;
//   double? get amount => _amount;
//
//   IntervalAllowanceModel.fromJson(Map<String, dynamic> json) {
//     _id = json['id'];
//     _name = json['name'];
//     _status = json['status'];
//     _amount = json['amount'];
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {
//       'id': _id,
//       'name': _name,
//       'status': _status,
//       'amount': _amount,
//     };
//     return data;
//   }
// }

class IntervalExtraordinaryModel {
  int? _id;
  int? _intervalId;
  String? _title;
  String? _startTime;
  String? _endTime;
  double? _amountPerHour;
  String? _type;

  IntervalExtraordinaryModel({
    int? id,
    int? intervalId,
    String? title,
    String? startTime,
    String? endTime,
    double? amountPerHour,
    String? type,
  }) {
    this._id = id;
    this._intervalId = intervalId;
    this._title = title;
    this._startTime = startTime;
    this._endTime = endTime;
    this._amountPerHour = amountPerHour;
    this._type = type;
  }

  int? get id => _id;
  int? get intervalId => _intervalId;
  String? get title => _title;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  double? get amountPerHour => _amountPerHour;
  String? get type => _type;

  set startTime(String? value) {
    _startTime = value;
  }

  set endTime(String? value) {
    _endTime = value;
  }

  set title(String? value) {
    _title = value;
  }
  set amountPerHour(double? value) {
    _amountPerHour = value;
  }
  set type(String? value) {
    _type = value;
  }

  IntervalExtraordinaryModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _intervalId = json['interval_id'];
    _title = json['title'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _amountPerHour = json['amount_per_hour'] is int? json['amount_per_hour']+.0: json['amount_per_hour'];
    _type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': _id,
      'interval_id': _intervalId,
      'title': _title,
      'start_time': _startTime,
      'end_time': _endTime,
      'amount_per_hour': _amountPerHour,
      'type': _type,
    };
    return data;
  }
}
