import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:turnarix/data/repository/vacation_statistics_repo.dart';

class VacationStatisticsProvider with ChangeNotifier {
  final VacationStatisticsRepo? vacationRepo;

  VacationStatisticsProvider({@required this.vacationRepo});

}