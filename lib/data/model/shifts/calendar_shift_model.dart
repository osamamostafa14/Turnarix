import 'package:turnarix/data/model/shifts/intervals_model.dart';
import 'package:turnarix/data/model/vacation_model.dart';

class CalendarInfoModel {

  String? _extraordinariesHoursSum;
  double? _extraordinariesAmountSum;
  List<CalendarShiftModel>? _calendarShifts;


  CalendarInfoModel(
      {String? extraordinariesHoursSum, double? extraordinariesAmountSum, List<CalendarShiftModel>? calendarShifts}) {

    this._extraordinariesHoursSum = extraordinariesHoursSum;
    this._extraordinariesAmountSum = extraordinariesAmountSum;
    this._calendarShifts = calendarShifts;
  }


  String? get extraordinariesHoursSum => _extraordinariesHoursSum;
  double? get extraordinariesAmountSum => _extraordinariesAmountSum;
  List<CalendarShiftModel>? get calendarShifts => _calendarShifts;


  CalendarInfoModel.fromJson(Map<String?, dynamic> json) {

    _extraordinariesHoursSum = json['extraordinaries_hours_sum'];
    _extraordinariesAmountSum = json['extraordinaries_amount_sum'] is int? json['extraordinaries_amount_sum']+.0: json['extraordinaries_amount_sum'];

    if (json['calendar_shifts'] != null) {
      _calendarShifts = [];
      json['calendar_shifts'].forEach((v) {
        _calendarShifts!.add(CalendarShiftModel.fromJson(v));
      });
    }
  }
}

class CalendarShiftModel {
  int? _id;
  int? _shiftId;
  String? _selectedDate;
  IntervalModel? _interval;

  CalendarShiftModel({
    int? id,
    int? shiftId,
    String? selectedDate,
    IntervalModel? interval,

  }) {
    this._id = id;
    this._shiftId = shiftId;
    this._interval = interval;
  }

  int? get id => _id;
  int? get shiftId => _shiftId;
  String? get selectedDate => _selectedDate;
  IntervalModel? get interval => _interval;

  // set shift(ShiftModel? value) {
  //   _shift = value;
  // }

  CalendarShiftModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _shiftId = json['shift_id'];
    _selectedDate = json['selected_date'];

    _interval = json['interval'] != null
        ? IntervalModel.fromJson(json['interval'])
        : null;
  }
}

