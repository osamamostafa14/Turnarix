import 'package:turnarix/data/model/calendar_data_model.dart';
import 'package:turnarix/data/model/shifts/vacation_model.dart';

class YearModel {
  int? _id;
  int? _year;
  List<MonthModel>? _months;

  YearModel({
    int? id,
    int? year,
    List<MonthModel>? months,

  }) {
    this._id = id;
    this._year = year;
    this._months = months;
  }

  int? get id => _id;
  int? get year => _year;
  List<MonthModel>? get months => _months;

  YearModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _year = json['year'];
    if (json['months'] != null) {
      _months = <MonthModel>[];
      json['months'].forEach((v) {
        _months!.add(MonthModel.fromJson(v));
      });
    }
  }
}

class MonthModel {
  int? _id;
  String? _name;
  int? _year;
  MonthStatistics? _monthStatistics;
  List<dynamic>? _vacationStatistics;
  List<DayModel>? _days;
  int? _workedHours;

  MonthModel({
    int? id,
    String? name,
    int? year,
    MonthStatistics? monthStatistics,
    List<dynamic>? vacationStatistics,
    List<DayModel>? days,
    int? workedHours,

  }) {
    this._id = id;
    this._name = name;
    this._year = year;
    this._monthStatistics = monthStatistics;
    this._vacationStatistics = vacationStatistics;
    this._days = days;
    this._workedHours = workedHours;
  }

  int? get id => _id;
  String? get name => _name;
  int? get year => _year;
  MonthStatistics? get monthStatistics => _monthStatistics;
  List<dynamic>? get vacationStatistics => _vacationStatistics;
  List<DayModel>? get days => _days;
  int? get workedHours => _workedHours;

  MonthModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _year = json['year'];
    _workedHours = json['total_worked_hours'];
    if(json['month_statistics'] != null){
      _monthStatistics = MonthStatistics.fromJson(json['month_statistics']);
    }

    _vacationStatistics = json['vacation_statistics'];

    if (json['days'] != null) {
      _days = <DayModel>[];
      json['days'].forEach((v) {
        _days!.add(DayModel.fromJson(v));
      });
    }
  }
}

class MonthStatistics {
  double? _hours;
  double? _eurosAmount;

  MonthStatistics({
    double? hours,
    double? eurosAmount,
  }) {
    this._hours = hours;
    this._eurosAmount = eurosAmount;
  }

  double? get hours => _hours;
  double? get eurosAmount => _eurosAmount;

  MonthStatistics.fromJson(Map<String, dynamic> json) {
    _hours = json['hours'] is int? json['hours']+.0 : json['hours'];
    _eurosAmount = json['euros_amount'] is int? json['euros_amount']+.0 : json['euros_amount'];
  }
}