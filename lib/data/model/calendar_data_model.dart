import 'package:turnarix/data/model/shifts/calendar_shift_model.dart';
import 'package:turnarix/data/model/vacation_model.dart';

class DayModel {
  int? _id;
  int? _dayNumber;
  List<CalendarShiftModel>? _calendarShifts;
  List<CalendarVacationModel>? _calendarVacations;

  DayModel({
    int? id,
    int? dayNumber,
    List<CalendarShiftModel>? calendarShifts,
    List<CalendarVacationModel>? calendarVacations,
  }) {
    this._id = id;
    this._dayNumber = dayNumber;
    this._calendarShifts = calendarShifts;
    this._calendarVacations = calendarVacations;
  }

  int? get id => _id;
  int? get dayNumber => _dayNumber;
  List<CalendarShiftModel>? get calendarShifts => _calendarShifts;
  List<CalendarVacationModel>? get calendarVacations => _calendarVacations;

  set calendarShifts(List<CalendarShiftModel>? value) {
    _calendarShifts = value;
  }

  set calendarVacations(List<CalendarVacationModel>? value) {
    _calendarVacations = value;
  }

  DayModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _dayNumber = json['day_number'];
    if (json['calendar_shifts'] != null) {
      _calendarShifts = <CalendarShiftModel>[];
      json['calendar_shifts'].forEach((v) {
        _calendarShifts!.add(CalendarShiftModel.fromJson(v));
      });
    }

    if (json['calendar_vacations'] != null) {
      _calendarVacations = <CalendarVacationModel>[];
      json['calendar_vacations'].forEach((v) {
        _calendarVacations!.add(CalendarVacationModel.fromJson(v));
      });
    }
  }
}

class CalendarVacationModel {
  int? _id;
  int? _vacationId;
  String? _selectedDate;
  VacationModel? _vacation;

  CalendarVacationModel({
    int? id,
    int? vacationId,
    String? selectedDate,
    VacationModel? vacation,

  }) {
    this._id = id;
    this._vacationId = vacationId;
    this._vacation = vacation;
  }

  int? get id => _id;
  int? get vacationId => _vacationId;
  String? get selectedDate => _selectedDate;
  VacationModel? get vacation => _vacation;

  // set shift(ShiftModel? value) {
  //   _shift = value;
  // }

  CalendarVacationModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _vacationId = json['vacation_id'];
    _selectedDate = json['selected_date'];

    _vacation = json['vacation'] != null
        ? VacationModel.fromJson(json['vacation'])
        : null;
  }
}