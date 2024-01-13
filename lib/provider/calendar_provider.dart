import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:turnarix/data/helper/date_converter.dart';
import 'package:turnarix/data/model/calendar_data_model.dart';
import 'package:turnarix/data/model/response/base/api_response.dart';
import 'package:turnarix/data/model/response/base/error_response.dart';
import 'package:turnarix/data/model/response/response_model.dart';
import 'package:turnarix/data/model/shifts/calendar_shift_model.dart';
import 'package:turnarix/data/model/shifts/intervals_model.dart';
import 'package:turnarix/data/model/shifts/shift_model.dart';
import 'package:turnarix/data/model/vacation_model.dart';
import 'package:turnarix/data/model/year_model.dart';
import 'package:turnarix/data/repository/calendar_repo.dart';

class CalendarProvider with ChangeNotifier {
  final CalendarRepo? calendarRepo;
  CalendarProvider({@required this.calendarRepo});

  List<String> _daysList = [];
  List<String> get daysList => _daysList;

  int? _monthDaysNumber;
  int? get monthDaysNumber => _monthDaysNumber;

  String? _monthName;
  String? get monthName => _monthName;

  String? _dayName;
  String? get dayName => _dayName;

  String? _dayNumber;
  String? get dayNumber => _dayNumber;

  int? _year;
  int? get year => _year;

  DateTime? _selectedDatetime;
  DateTime? get selectedDatetime => _selectedDatetime;

  String _typeSelected = 'calendar';
  String get typeSelected => _typeSelected;

  DateTime _selectedDay = DateTime.now();
  DateTime get selectedDay => _selectedDay;

  List<DateTime> _dateList = [];
  List<DateTime>? get dateList => _dateList;

  List<CalendarInfoModel> _calendarInfoModels = [];
  List<CalendarInfoModel> get calendarInfoModels => _calendarInfoModels;

  List<ShiftModel> _temporarySavedCalendarShifts = [];
  List<ShiftModel> get temporarySavedCalendarShifts => _temporarySavedCalendarShifts;

  List<DayModel> _daysModelList = [];
  List<DayModel> get daysModelList => _daysModelList;

  YearModel? _yearModel;
  YearModel? get yearModel => _yearModel;

  List<MonthModel> _monthsShifts = [];
  List<MonthModel> get monthsShifts => _monthsShifts;

  List<IntervalModel> _intervalList = [];
  List<IntervalModel> get intervalList => _intervalList;



  // void getDateInfo(DateTime dateTime) {
  //   DateTime lastDayOfMonth = DateTime(dateTime.year, dateTime.month + 1, 0);
  //   _monthDaysNumber = lastDayOfMonth.day;
  //   _monthName = DateFormat('MMMM').format(dateTime);
  //   _dayName = DateFormat('EEEE').format(dateTime); // Full day name
  //   _dayNumber = DateFormat('d').format(dateTime); // Day number
  //   _monthName = DateFormat('MMMM').format(dateTime);
  //   _year = dateTime.year;
  //   _selectedDatetime = dateTime;
  //   notifyListeners();
  // }

  void getDateInfo(DateTime dateTime) {
    DateTime lastDayOfMonth = DateTime(dateTime.year, dateTime.month + 1, 0);
    _monthDaysNumber = lastDayOfMonth.day;
    print('monthDaysNumber: ${_monthDaysNumber}');
    print('lastDayOfMonth: ${lastDayOfMonth}');

    _monthName = DateFormat('MMMM').format(dateTime);
    _dayName = DateFormat('EEEE').format(dateTime); // Full day name
    _dayNumber = DateFormat('d').format(dateTime); // Day number
    _monthName = DateFormat('MMMM').format(dateTime);
    _year = dateTime.year;
    _selectedDatetime = dateTime;

    for(int i = 0; i < _monthDaysNumber!; i++){

      // DayModel _day = DayModel(
      //   id: i,
      //
      // );
      // _daysModelList.add(_day);


    }
    notifyListeners();
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

  // void initCalendarIntervals() {
  //   List<MonthModel> _months = [];
  //   _calendarInfoModels.forEach((element) {
  //     List<CalendarShiftModel> _calendarShifts = element.calendarShifts!;
  //   });
  //   _dateList.forEach((date) { // how to get days number count of this date
  //     List<DayModel> _daysList = [];
  //     int daysInCurrentMonth = DateTime(date.year, date.month + 1, 0).day;
  //     for(int i = 0; i < daysInCurrentMonth; i++){
  //       _calendarInfoModels.forEach((element) {
  //         List<CalendarShiftModel> _calendarShifts = element.calendarShifts!;
  //         _calendarShifts.forEach((element) {
  //           if(DateTime.parse(element.selectedDate!).month == i + 1){
  //
  //           }
  //         });
  //       });
  //       DayModel _day = DayModel(
  //         dayNumber: i,
  //         intervals:
  //       );
  //       _daysList.add(_day);
  //     }
  //     _months.add(MonthModel(
  //       month: date.month,
  //       days:
  //     ));
  //     print('daysInCurrentMonth: ${daysInCurrentMonth}');
  //   });
  //
  //   // _yearModel = YearModel(
  //   //   year: 2023,
  //   //   months:
  //   // );
  //
  //   notifyListeners();
  // }

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

  void setCalendarType(String type){
    _typeSelected = type;
    notifyListeners();
  }

  void setSelectedDate(DateTime dateTime){
    _selectedDay = dateTime;
    notifyListeners();
  }

  void addLocalCalendarShifts(ShiftModel shiftModel){
    _temporarySavedCalendarShifts.add(shiftModel);
    notifyListeners();
  }

  Future<ResponseModel> getCalendarShifts(BuildContext? context) async {
    _monthsShifts = [];
    ResponseModel _responseModel;
    ApiResponse apiResponse = await calendarRepo!.getCalendarShifts();
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

  Future<ResponseModel> getShiftIntervals(BuildContext? context) async {
    _intervalList = [];
    ResponseModel _responseModel;
    ApiResponse apiResponse = await calendarRepo!.getShiftIntervals();
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

  void updateSelectedDay(DateTime date, IntervalModel newInterval){
    _monthsShifts.forEach((month) {
      if(DateConverter.getMonthNumber(month.name!) == date.month && month.year == date.year){
        month.days!.forEach((day) {
          if(day.dayNumber == date.day){

            CalendarShiftModel _newShiftModel= CalendarShiftModel(
              id: 0,
              shiftId: 0,
              selectedDate: date.toString(),
              interval: newInterval
            );

            day.calendarShifts ??= []; // Ensure the list is initialized
            day.calendarShifts!.add(_newShiftModel);
          }
        });
      }
    });
    notifyListeners();
  }


  void updateVacationSelectedDay(DateTime date, VacationModel newVacation){
    _monthsShifts.forEach((month) {
      if(DateConverter.getMonthNumber(month.name!) == date.month && month.year == date.year){
        month.days!.forEach((day) {
          if(day.dayNumber == date.day){

            CalendarVacationModel _vacationModel= CalendarVacationModel(
                id: 0,
                vacationId: 0,
                selectedDate: date.toString(),
                vacation: newVacation
            );

            day.calendarVacations ??= []; // Ensure the list is initialized
            day.calendarVacations!.add(_vacationModel);
          }
        });
      }
    });
    notifyListeners();
  }

  void removeCalendarShiftFromDay(DateTime date, int calendarShiftId){
    _monthsShifts.forEach((month) {
      if(DateConverter.getMonthNumber(month.name!) == date.month && month.year == date.year){
        month.days!.forEach((day) {
          if(day.dayNumber == date.day){
            day.calendarShifts ??= []; // Ensure the list is initialized
            // Remove the item where id equals calendarShiftId
            day.calendarShifts!.removeWhere((shift) => shift.id == calendarShiftId);
          }
        });
      }
    });

    notifyListeners();
  }

  void removeVacationFromDay(DateTime date, int calendarVacationId){
    _monthsShifts.forEach((month) {
      if(DateConverter.getMonthNumber(month.name!) == date.month && month.year == date.year){
        month.days!.forEach((day) {
          if(day.dayNumber == date.day){
            day.calendarVacations ??= []; // Ensure the list is initialized
            // Remove the item where id equals calendarShiftId
            day.calendarVacations!.removeWhere((vacation) => vacation.id == calendarVacationId);
          }
        });
      }
    });

    notifyListeners();
  }

  Future<ResponseModel> addShiftIntervalToCalendar(BuildContext context,int intervalId, DateTime date) async {

    ResponseModel responseModel;
    ApiResponse apiResponse = await calendarRepo!.addShiftIntervalToCalendar(intervalId, date.toString());

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel(true, 'success!');
      CalendarShiftModel savedCalendarShift = CalendarShiftModel.fromJson(apiResponse.response!.data);
      removeCalendarShiftFromDay(date, 0);

      _monthsShifts.forEach((month) {
        if(DateConverter.getMonthNumber(month.name!) == date.month && month.year == date.year){
          month.days!.forEach((day) {
            if(day.dayNumber == date.day){

              day.calendarShifts ??= []; // Ensure the list is initialized
              day.calendarShifts!.add(savedCalendarShift);
            }
          });
        }
      });

      notifyListeners();
    } else {

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

  Future<ResponseModel> addVacationToCalendar(BuildContext context,int vacationId, DateTime date) async {

    ResponseModel responseModel;
    ApiResponse apiResponse = await calendarRepo!.addVacationToCalendar(vacationId, date.toString());

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel(true, 'success!');
      CalendarVacationModel savedCalendarVacation = CalendarVacationModel.fromJson(apiResponse.response!.data);
      removeVacationFromDay(date, 0);

      _monthsShifts.forEach((month) {
        if(DateConverter.getMonthNumber(month.name!) == date.month && month.year == date.year){
          month.days!.forEach((day) {
            if(day.dayNumber == date.day){

              day.calendarVacations ??= []; // Ensure the list is initialized
              day.calendarVacations!.add(savedCalendarVacation);
            }
          });
        }
      });

      notifyListeners();
    } else {

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

  DateTime _parseTime(String timeString) {
    try {
      // Attempt to parse the input string as a DateTime
      return DateTime.parse(timeString);
    } catch (e) {
      // If parsing as DateTime fails, try parsing as time string
      return DateFormat('h:mm a').parse(timeString);
    }
  }

  double calculateHoursDifference(String start, String end) {
    // Parse the time strings
    // DateTime startTime = _parseTime(start);
    // DateTime endTime = _parseTime(end);

    DateTime startTime = _parseTime(start);
    DateTime endTime = _parseTime(end);

    // Calculate the difference in hours
    Duration difference = endTime.difference(startTime);

    // Get the number of hours
    double hoursDifference = difference.inMinutes / 60;
    return hoursDifference;
  }

  double calculateDayExtraOrdinaries(IntervalModel interval){
    double hours = 0.0;
    interval.extraordinaries!.forEach((extraordinary) {
      String _startTime = extraordinary.startTime!;
      String _endTime = extraordinary.endTime!;

      DateTime startTime = _parseTime(_startTime);
      DateTime endTime = _parseTime(_endTime);

      // Calculate the difference in hours
      Duration difference = endTime.difference(startTime);

      // Get the number of hours
      double hoursDifference = difference.inMinutes / 60;
      hours = hours + hoursDifference;

    });
    return hours;
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

  List<CalendarVacationModel> getSelectedCalendarVacations(){

    List<CalendarVacationModel> _vacations= [];
    _monthsShifts.forEach((month) {
      if(DateConverter.getMonthNumber(month.name!) == _selectedDay.month && month.year == _selectedDay.year){
        month.days!.forEach((day) {
          if(day.dayNumber == _selectedDay.day){
            _vacations = day.calendarVacations!;

          }
        });
      }
    });
    return _vacations;
  }

  List<dynamic> _monthVacationStats = [];
  List<dynamic> get monthVacationStats => _monthVacationStats;

  void setCurrentMonthVacations(List<dynamic> item) {
    _monthVacationStats = item;
    print('monthVacationStats=> ${_monthVacationStats}');
    notifyListeners();
  }

  Future<ResponseModel> removeShiftFromCalendar(BuildContext context, int calendarShiftId) async {

    ResponseModel responseModel;
    ApiResponse apiResponse = await calendarRepo!.removeShiftFromCalendar(calendarShiftId);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel(true, 'success!');

    } else {
      responseModel = ResponseModel(true, 'success!');

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

  Future<ResponseModel> removeVacationFromCalendar(BuildContext context, int calendarVacationId) async {

    ResponseModel responseModel;
    ApiResponse apiResponse = await calendarRepo!.removeVacationFromCalendar(calendarVacationId);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel(true, 'success!');
      notifyListeners();
    } else {
      responseModel = ResponseModel(true, 'success!');

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