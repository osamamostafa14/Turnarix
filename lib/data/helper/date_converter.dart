import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateConverter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  }

  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static DateTime convertStringToDatetime(String dateTime) {
    return DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").parse(dateTime);
  }

  static DateTime convertStringToDatetime2(String dateTime) {
    return DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").parse(dateTime);
  }

  static DateTime convertStringToDatetimeLocal(String dateTime) {
   // DateFormat.yMEd().add_jms().format(dateTime);
    return DateFormat("yyyy-MM-dd").parse(dateTime);
  }
  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, true).toLocal();
  }

  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat('hh:mm aa').format(isoStringToLocalDate(dateTime));
  }
  static String isoStringToLocalAMPM(String dateTime) {
    return DateFormat('a').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateTime.toUtc());
  }

  static String convertTimeToTime(String time) {
    return DateFormat('hh:mm a').format(DateFormat('hh:mm:ss').parse(time));
  }

  static String monthYear(String time) {
    DateTime dateTime = DateFormat('yyyy-MM-dd').parse(time);
    return DateFormat('d MMM yyyy').format(dateTime);
  }

  static String timeOnly(String time) {
    DateTime dateTime = DateFormat('yyyy-MM-dd hh:mm:ss').parse(time);
    return DateFormat('h:mm a').format(dateTime);
  }

  static String formatDayMonthYear(DateTime dateTime) {
    return DateFormat('dd MMM yy').format(dateTime);
  }

  static String monthYearTime(DateTime date) {

    // Format the date
    String formattedDate = DateFormat('dd MMM h:mm a').format(date);

    return formattedDate;
    // Print the formatted date
    print(formattedDate); // Output: 24 Sep 1:00 AM
  }

  static String formatTimeString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString); // Parse the date string to DateTime
    String formattedTime = DateFormat.jm().format(dateTime); // Format time using 'jm' pattern
    return formattedTime;
  }


  static TimeOfDay convertToTimeOfDay(String timeString) {
    // Split the string to get hours and minutes

    List<String> timeParts = timeString.split(':');
    int hours = int.parse(timeParts[0]);


    // Extracting minutes and AM/PM information
    List<String> minuteAndPeriod = timeParts[1].split(' ');
    int minutes = int.parse(minuteAndPeriod[0]);
    String period = minuteAndPeriod[1];

    // Convert to 24-hour format if needed (if the string has AM/PM)
    if (period.toLowerCase() == 'pm' && hours != 12) {
      hours += 12;
    } else if (period.toLowerCase() == 'am' && hours == 12) {
      hours = 0;
    }

    return TimeOfDay(hour: hours, minute: minutes);
  }

  static int getMonthNumber(String monthName) {
    if(monthName == 'January'){
      return 1;
    } else if (monthName == "February") {
      return 2;
    } else if (monthName == "March") {
      return 3;
    } else if (monthName == "April") {
      return 4;
    } else if (monthName == "May") {
      return 5;
    } else if (monthName == "June") {
      return 6;
    } else if (monthName == "July") {
      return 7;
    } else if (monthName == "August") {
      return 8;
    } else if (monthName == "September") {
      return 9;
    } else if (monthName == "October") {
      return 10;
    } else if (monthName == "November") {
      return 11;
    } else if (monthName == "December") {
      return 12;
    }
    else{
      return 1;
    }
  }

  static String getMonthName(int monthNumber) {
    if (monthNumber == 1) {
      return 'January';
    } else if (monthNumber == 2) {
      return 'February';
    } else if (monthNumber == 3) {
      return 'March';
    } else if (monthNumber == 4) {
      return 'April';
    } else if (monthNumber == 5) {
      return 'May';
    } else if (monthNumber == 6) {
      return 'June';
    } else if (monthNumber == 7) {
      return 'July';
    } else if (monthNumber == 8) {
      return 'August';
    } else if (monthNumber == 9) {
      return 'September';
    } else if (monthNumber == 10) {
      return 'October';
    } else if (monthNumber == 11) {
      return 'November';
    } else if (monthNumber == 12) {
      return 'December';
    } else {
      return 'Invalid month number';
    }
  }


  static String hoursConverter(double hours) {
    if (hours < 24) {
      return '$hours hrs';
    } else if (hours < 24 * 30) {
      // Convert to days
      int days = (hours / 24).floor();
      return '$days d';
    } else if (hours < 24 * 30 * 12) {
      // Convert to months
      int months = (hours / (24 * 30)).floor();
      return '$months m';
    } else {
      // Convert to years
      int years = (hours / (24 * 30 * 12)).floor();
      return '$years y';
    }
  }

}
