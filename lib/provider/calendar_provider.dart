import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  DateTime? _selectedDay;
  DateTime? get selectedDay => _selectedDay;

  List<DateTime> _dateList = [];
  List<DateTime>? get dateList => _dateList;

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
    _monthName = DateFormat('MMMM').format(dateTime);
    _dayName = DateFormat('EEEE').format(dateTime); // Full day name
    _dayNumber = DateFormat('d').format(dateTime); // Day number
    _monthName = DateFormat('MMMM').format(dateTime);
    _year = dateTime.year;
    _selectedDatetime = dateTime;
    notifyListeners();
  }

  void initCalendar() {

    DateTime now = DateTime.now();

    // Get the first day of the next 10 months and add them to _dateList
    for (int i = 0; i < 10; i++) {
      DateTime nextMonth = DateTime(now.year, now.month + i + 1, 1);
      _dateList.add(nextMonth);
    }

    // At this point, _dateList contains the first day of the next 10 months
    _dateList.forEach((date) {
      print(date); // You can print the dates to see the result
    });

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

  void setCalendarType(String type){
    _typeSelected = type;
    notifyListeners();
  }

  void setSelectedDate(DateTime dateTime){
    _selectedDay = dateTime;
    notifyListeners();
  }


}