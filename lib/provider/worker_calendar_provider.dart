import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:turnarix/data/helper/date_converter.dart';
import 'package:turnarix/data/model/response/base/api_response.dart';
import 'package:turnarix/data/model/response/response_model.dart';
import 'package:turnarix/data/model/shifts/calendar_shift_model.dart';
import 'package:turnarix/data/model/shifts/intervals_model.dart';
import 'package:turnarix/data/model/year_model.dart';
import 'package:turnarix/data/repository/worker_calendar_repo.dart';

class WorkerCalendarProvider with ChangeNotifier {
  final WorkerCalendarRepo? calendarRepo;
  WorkerCalendarProvider({@required this.calendarRepo});

  List<MonthModel> _monthsShifts = [];
  List<MonthModel> get monthsShifts => _monthsShifts;

  List<IntervalModel> _intervalList = [];
  List<IntervalModel> get intervalList => _intervalList;

  List<DateTime> _dateList = [];
  List<DateTime>? get dateList => _dateList;

  List<String> _daysList = [];
  List<String> get daysList => _daysList;

  DateTime _selectedDay = DateTime.now();
  DateTime get selectedDay => _selectedDay;



  Future<ResponseModel> getCalendarShifts(BuildContext? context, int workerId) async {
    _monthsShifts = [];
    ResponseModel _responseModel;
    ApiResponse apiResponse = await calendarRepo!.getCalendarShifts(workerId);
    if(apiResponse.response != null){
      if (apiResponse.response!.statusCode == 200) {
        print('success calendars');
        // apiResponse.response!.data.forEach((v) {
        //   _calendarInfoModels.add(CalendarInfoModel.fromJson(v));
        // });
        apiResponse.response!.data.forEach((v) {
          _monthsShifts.add(MonthModel.fromJson(v));
        });
        _responseModel = ResponseModel(true, 'successful');
      } else {
        notifyListeners();
        String _errorMessage;
        if (apiResponse.error is String) {
          _errorMessage = apiResponse.error.toString();
        } else {
          _errorMessage = apiResponse.error.errors[0].message;
        }
        print(_errorMessage);
        _responseModel = ResponseModel(false, _errorMessage);
        // ApiChecker.checkApi(context, apiResponse);
      }
    }else{
      String _errorMessage;
      if (apiResponse.error is String) {
        _errorMessage = apiResponse.error.toString();
      } else {
        _errorMessage = apiResponse.error.errors[0].message;
      }
      print(_errorMessage);
      _responseModel = ResponseModel(false, _errorMessage);
    }

    notifyListeners();
    return _responseModel;
  }

  Future<ResponseModel> getShiftIntervals(BuildContext? context, int employeeId) async {
    _intervalList = [];
    ResponseModel _responseModel;
    ApiResponse apiResponse = await calendarRepo!.getShiftIntervals(employeeId);
    if(apiResponse.response != null){
      if (apiResponse.response!.statusCode == 200) {
        apiResponse.response!.data.forEach((v) {
          _intervalList.add(IntervalModel.fromJson(v));
        });
        _responseModel = ResponseModel(true, 'successful');
      } else {
        notifyListeners();
        String _errorMessage;
        if (apiResponse.error is String) {
          _errorMessage = apiResponse.error.toString();
        } else {
          _errorMessage = apiResponse.error.errors[0].message;
        }
        print(_errorMessage);
        _responseModel = ResponseModel(false, _errorMessage);
        // ApiChecker.checkApi(context, apiResponse);
      }
    }else{
      String _errorMessage;
      if (apiResponse.error is String) {
        _errorMessage = apiResponse.error.toString();
      } else {
        _errorMessage = apiResponse.error.errors[0].message;
      }
      print(_errorMessage);
      _responseModel = ResponseModel(false, _errorMessage);
    }

    notifyListeners();
    return _responseModel;
  }


  List<CalendarShiftModel> _calendarShifts = [];
  List<CalendarShiftModel> get calendarShifts => _calendarShifts;

  bool _dayShiftsLoading = false;
  bool get dayShiftsLoading => _dayShiftsLoading;


  void resetDayShifts() {
    _calendarShifts = [];
    notifyListeners();
  }


  Future<ResponseModel> getDayCalendarShift(DateTime date) async {
    _dayShiftsLoading = true;
    notifyListeners();
    ResponseModel _responseModel;
    ApiResponse apiResponse = await calendarRepo!.getDayCalendarShift(date);
    if(apiResponse.response != null){
      if (apiResponse.response!.statusCode == 200) {
        print('success calendars');
        _dayShiftsLoading = false;
        notifyListeners();
        apiResponse.response!.data.forEach((v) {
          _calendarShifts.add(CalendarShiftModel.fromJson(v));
        });
        _responseModel = ResponseModel(true, 'successful');
      } else {
        _dayShiftsLoading = true;
        notifyListeners();
        String _errorMessage;
        if (apiResponse.error is String) {
          _errorMessage = apiResponse.error.toString();
        } else {
          _errorMessage = apiResponse.error.errors[0].message;
        }
        print(_errorMessage);
        _responseModel = ResponseModel(false, _errorMessage);
        // ApiChecker.checkApi(context, apiResponse);
      }
    }else{
      String _errorMessage;
      if (apiResponse.error is String) {
        _errorMessage = apiResponse.error.toString();
      } else {
        _errorMessage = apiResponse.error.errors[0].message;
      }
      print(_errorMessage);
      _responseModel = ResponseModel(false, _errorMessage);
    }

    notifyListeners();
    return _responseModel;
  }

  void initCalendar() {
    DateTime now = DateTime.now();
    // Get the first day of the next 10 months and add them to _dateList
    for (int i = -6; i < 10; i++) {
      DateTime nextMonth = DateTime(now.year, now.month + i + 1, 1);
      _dateList.add(nextMonth);
      print('_dateList: ${_dateList}');
    }
    notifyListeners();
  }

  List<String> getFirstDayNameOfMonth(DateTime dateTime) {
    _daysList = [];
    DateTime firstDayOfMonth = DateTime(dateTime.year, dateTime.month, 1);
    DateTime secondDayOfMonth = DateTime(dateTime.year, dateTime.month, 2);
    DateTime thirdDayOfMonth = DateTime(dateTime.year, dateTime.month, 3);
    DateTime fourthDayOfMonth = DateTime(dateTime.year, dateTime.month, 4);
    DateTime fifthDayOfMonth = DateTime(dateTime.year, dateTime.month, 5);
    DateTime sixDayOfMonth = DateTime(dateTime.year, dateTime.month, 6);
    DateTime seventhDayOfMonth = DateTime(dateTime.year, dateTime.month, 7);

    String dayOne = DateFormat('E').format(firstDayOfMonth);
    _daysList.add(dayOne);
    String dayTwo = DateFormat('E').format(secondDayOfMonth);
    _daysList.add(dayTwo);
    String dayThree = DateFormat('E').format(thirdDayOfMonth);
    _daysList.add(dayThree);
    String dayFour = DateFormat('E').format(fourthDayOfMonth);
    _daysList.add(dayFour);
    String dayFive = DateFormat('E').format(fifthDayOfMonth);
    _daysList.add(dayFive);
    String daySix = DateFormat('E').format(sixDayOfMonth);
    _daysList.add(daySix);
    String daySeven = DateFormat('E').format(seventhDayOfMonth);
    _daysList.add(daySeven);

    notifyListeners();

    return _daysList;
  }

  void setSelectedDate(DateTime dateTime){
    _selectedDay = dateTime;
    notifyListeners();
  }

  bool _bottomIntervalsVisible = false;
  bool get bottomIntervalsVisible => _bottomIntervalsVisible;

  void updateBottomIntervalsVisibility(bool value) {
    _bottomIntervalsVisible = value;
    notifyListeners();
  }

  List<CalendarShiftModel> getSelectedCalendarShifts(){
    List<CalendarShiftModel> _shifts = [];
    _monthsShifts.forEach((month) {
      if(DateConverter.getMonthNumber(month.name!) == _selectedDay.month && month.year == _selectedDay.year){
        month.days!.forEach((day) {
          if(day.dayNumber == _selectedDay.day){
            _shifts = day.calendarShifts!;
          }
        });
      }
    });
    return _shifts;
  }

}