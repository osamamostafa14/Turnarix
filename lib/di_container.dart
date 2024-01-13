import 'package:turnarix/data/repository/auth_repo.dart';
import 'package:turnarix/data/repository/calendar_repo.dart';
import 'package:turnarix/data/repository/chat_repo.dart';
import 'package:turnarix/data/repository/messages_repo.dart';
import 'package:turnarix/data/repository/profile_repo.dart';
import 'package:turnarix/data/repository/saved_shift_repo.dart';
import 'package:turnarix/data/repository/shift_exchange_repo.dart';
import 'package:turnarix/data/repository/shifts_repo.dart';
import 'package:turnarix/data/repository/splash_repo.dart';
import 'package:turnarix/data/repository/vacation_repo.dart';
import 'package:turnarix/data/repository/vacation_statistics_repo.dart';
import 'package:turnarix/data/repository/worker_calendar_repo.dart';
import 'package:turnarix/provider/auth_provider.dart';
import 'package:turnarix/provider/calendar_provider.dart';
import 'package:turnarix/provider/chat_provider.dart';
import 'package:turnarix/provider/localization_provider.dart';
import 'package:turnarix/provider/profile_provider.dart';
import 'package:turnarix/provider/saved_shift_provider.dart';
import 'package:turnarix/provider/shift_exchange_provider.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:turnarix/provider/splash_provider.dart';
import 'package:turnarix/provider/statistics/vacation_statistics_provider.dart';
import 'package:turnarix/provider/theme_provider.dart';
import 'package:turnarix/provider/vacation_provider.dart';
import 'package:turnarix/provider/worker_calendar_provider.dart';
import 'package:turnarix/utill/app_constants.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL, sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => AuthRepo(dioClient: sl()));
  sl.registerLazySingleton(() => ProfileRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => ChatRepo(dioClient: sl()));
  sl.registerLazySingleton(() => MessagesRepo(dioClient: sl()));
  sl.registerLazySingleton(() => CalendarRepo(dioClient: sl()));
  sl.registerLazySingleton(() => ShiftsRepo(dioClient: sl()));
  sl.registerLazySingleton(() => SavedShiftsRepo(dioClient: sl()));
  sl.registerLazySingleton(() => WorkerCalendarRepo(dioClient: sl()));
  sl.registerLazySingleton(() => ShiftExchangeRepo(dioClient: sl()));
  sl.registerLazySingleton(() => VacationRepo(dioClient: sl()));
  sl.registerLazySingleton(() => VacationStatisticsRepo(dioClient: sl()));

  sl.registerFactory(() => SplashProvider(splashRepo: sl()));
  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  sl.registerFactory(() => ProfileProvider(profileRepo: sl()));
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerFactory(() => CalendarProvider(calendarRepo: sl()));
  sl.registerFactory(() => ShiftsProvider(shiftsRepo: sl()));
  sl.registerFactory(() => SavedShiftProvider(shiftRepo: sl()));
  sl.registerFactory(() => ChatProvider(chatRepo: sl()));
  sl.registerFactory(() => WorkerCalendarProvider(calendarRepo: sl()));
  sl.registerFactory(() => ShiftExchangeProvider(shiftExchangeRepo: sl()));
  sl.registerFactory(() => VacationProvider(vacationRepo: sl()));
  sl.registerFactory(() => VacationStatisticsProvider(vacationRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
