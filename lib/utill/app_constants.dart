
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

 /// DRIVER AUTH
 static const String DRIVER_LOGIN_URI = '/api/v1/driver-auth/login';
 static const String DRIVER_TOKEN_URI = '/api/v1/driver/cm-firebase-token';
 static const String DRIVER_SOCIAL_LOGIN_URI = '/api/v1/driver-auth/social-login';
 static const String DRIVER_REGISTER_URI = '/api/v1/driver-auth/register';
 static const String DRIVER_CHECK_EMAIL_URI = '/api/v1/driver-auth/check-email';
 static const String DRIVER_VERIFY_TOKEN_URI = '/api/v1/driver-auth/verify-token';
 static const String DRIVER_VERIFY_PASSWORD_TOKEN_URI = '/api/v1/driver-auth/verify-password-token';
 static const String DRIVER_FORGET_PASSWORD_URI = '/api/v1/driver-auth/forgot-password';
 static const String DRIVER_RESET_PASSWORD_URI = '/api/v1/driver-auth/reset-password';
 static const String DRIVER_REGISTER_IMAGES_URI = '/api/v1/driver/register-images';
 static const String DRIVER_VERIFY_EMAIL_URI = '/api/v1/driver-auth/verify-email';

 // DRIVER PROFILE
 static const String DRIVER_INFO_URI = '/api/v1/driver/info';
 static const String UPDATE_DRIVER_VEHICLE_INFO_URI = '/api/v1/driver/profile/vehicle-info';

 //PROFILE
 static const String UPDATE_PERSONAL_INFO_URI = '/api/v1/customer/profile/personal-info';

 //LOCATION
 static const String SEARCH_URI = '/api/v1/location/search';


 //CONVERSATIONS
 static const String MESSAGE_URI = '/api/v1/customer/conversation/get';
 static const String MESSAGE_HISTORY_URI = '/api/v1/customer/conversation/messages-history';
 static const String SEND_MESSAGE_URI = '/api/v1/customer/conversation/send';
 static const String SEND_IMAGE_URI = '/api/v1/customer/conversation/send-image';

 //MESSAGES
 static const String MESSAGES_URI = '/api/v1/customer/message/get';


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

 static const String CURRENCY = '\$';

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
