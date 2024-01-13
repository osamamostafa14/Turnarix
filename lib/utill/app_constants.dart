
import 'package:turnarix/data/model/language_model.dart';

class AppConstants {

 static const String APP_NAME = 'Turnarix';
 static const String CONFIG_URI = '/api/v1/config';

 static const String BASE_URL = 'https://test.osama-mostafa.com';

 /// AUTH
 static const String LOGIN_URI = '/api/v1/auth/login';
 static const String TOKEN_URI = '/api/v1/customer/cm-firebase-token';
 static const String SOCIAL_LOGIN_URI = '/api/v1/auth/social-login';
 static const String REGISTER_URI = '/api/v1/auth/register';
 static const String CHECK_EMAIL_URI = '/api/v1/auth/check-email';
 static const String VERIFY_TOKEN_URI = '/api/v1/auth/verify-token';
 static const String VERIFY_PASSWORD_TOKEN_URI = '/api/v1/auth/verify-password-token';
 static const String FORGET_PASSWORD_URI = '/api/v1/auth/forgot-password';
 static const String RESET_PASSWORD_URI = '/api/v1/auth/reset-password';
 static const String REGISTER_IMAGES_URI = '/api/v1/customer/register-images';
 static const String VERIFY_EMAIL_URI = '/api/v1/auth/verify-email';

 /// SHIFTS
 static const String NEW_SHIFT_URI = '/api/v1/customer/shifts/add-new';
 static const String ADD_INTERVALS_URI = '/api/v1/customer/shifts/add-intervals';
 static const String GET_INTERVALS_URI = '/api/v1/customer/shifts/get-intervals';
 static const String STORE_INTERVAL_INFO_URI = '/api/v1/customer/shifts/store-interval-info';
 static const String STORE_NEW_INTERVAL_INFO_URI = '/api/v1/customer/shifts/store-new-interval-info';
 static const String SHIFTS_LIST_URI = '/api/v1/customer/shifts/list';
 static const String ADD_TO_CALENDAR_URI = '/api/v1/customer/calendar/add-to-calendar';
 static const String ADD_VACATION_TO_CALENDAR_URI = '/api/v1/customer/vacation/add-to-calendar';

 static const String UPDATE_SHIFT_NAME_URI = '/api/v1/customer/shifts/update/name';
 static const String REMOVE_INTERVAL_URI = '/api/v1/customer/shifts/update/remove-interval';

// static const String ADD_VACATION_URI = '/api/v1/customer/shifts/add-vacation';
// static const String UPDATE_VACATION_URI = '/api/v1/customer/shifts/update-vacation';


 /// CALENDAR
 static const String CALENDAR_SHIFTS_URI = '/api/v1/customer/calendar/calendar-info';
 static const String SHIFT_INTERVALS_URI = '/api/v1/customer/calendar/intervals';
 static const String REMOVE_SHIFT_FROM_CALENDAR_URI = '/api/v1/customer/calendar/remove-calendar-shift';

 /// WORKER CALENDAR
 static const String WORKER_CALENDAR_SHIFTS_URI = '/api/v1/customer/calendar/employee/calendar-info';
 static const String WORKER_SHIFT_INTERVALS_URI = '/api/v1/customer/calendar/employee/intervals';
 static const String DAY_CALENDAR_SHIFTS_URI = '/api/v1/customer/shifts/day-shifts';

 /// exchanges
 static const String EXCHANGE_REQUESTS_URI = '/api/v1/customer/exchange/exchange-requests';
 static const String EXCHANGE_REQUEST_STATUS_URI = '/api/v1/customer/exchange/update-status';
 static const String RECEIVED_EXCHANGE_REQUESTS_URI = '/api/v1/customer/exchange/received-exchange-requests';
 static const String SHIFT_EXCHANGE_URI = '/api/v1/customer/exchange/shift-exchange';

 /// vacations
 static const String VACATIONS_LIST_URI = '/api/v1/customer/vacation/vacation-list';
 static const String ADD_VACATION_URI = '/api/v1/customer/vacation/add-vacation';
 static const String UPDATE_VACATION_URI = '/api/v1/customer/vacation/update-vacation';
 static const String REMOVE_VACATION_URI = '/api/v1/customer/vacation/remove-vacation';
 static const String REMOVE_VACATION_FROM_CALENDAR_URI = '/api/v1/customer/vacation/remove-vacation-calendar';

 //PROFILE
 static const String UPDATE_PERSONAL_INFO_URI = '/api/v1/customer/profile/personal-info';

 //LOCATION
 static const String SEARCH_URI = '/api/v1/location/search';


 //CONVERSATIONS
 static const String MESSAGE_URI = '/api/v1/customer/conversation/get-messages';
 static const String MESSAGE_HISTORY_URI = '/api/v1/customer/conversation/messages-history';
 static const String SEND_MESSAGE_URI = '/api/v1/customer/conversation/send';
 static const String SEND_IMAGE_URI = '/api/v1/customer/conversation/send-image';


 //Main MESSAGES
 static const String MAIN_MESSAGES_URI = '/api/v1/customer/conversation/main-messages';
 static const String CHAT_USERS_LIST_URI = '/api/v1/customer/conversation/users-list';

 static const String CUSTOMER_INFO_URI = '/api/v1/customer/info';
 static const String EMPLOYEE_ROLES_URI = '/api/v1/employee/roles';

  // internal
  static const String TOKEN = 'token';
  static const String USER_ID = 'user_id';
 static const String USER_TYPE = 'user_type';

  static const String USER_PASSWORD = 'user_password';
  static const String USER_NUMBER = 'user_number';

 static const String COUNTRY_CODE = 'country_code';
 static const String LANGUAGE_CODE = 'language_code';

 static const String CURRENCY = '€';

 static const String THEME = 'theme';
 static const String PRIMARY_COLOR = 'primary_color';
 static const String FONT_SIZE = 'font_size';
 // TEMPORARY

 static const String API_KEY = 'AIzaSyC9oR81d66guPOb0QaLk-shF3GV4MagMJw';   // TEMPORARY
 /// DRIVER
 // internal
 static const String DRIVER_TOKEN = 'token';
 static const String DRIVER_ID = 'driver_id';
 static const String DRIVER_PASSWORD = 'driver_password';
 static const String DRIVER_NUMBER = 'driver_number';

 static List<LanguageModel> languages = [
  LanguageModel(
      languageName: 'English',
      languageCode: 'en'),
  LanguageModel(
      languageName: 'Arabic',
      languageCode: 'ar'),
 ];
}
