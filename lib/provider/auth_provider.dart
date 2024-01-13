import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:turnarix/data/model/response/base/api_response.dart';
import 'package:turnarix/data/model/response/base/error_response.dart';
import 'package:turnarix/data/model/response/employee_role_model.dart';
import 'package:turnarix/data/model/response/response_model.dart';
import 'package:turnarix/data/model/response/signup_model.dart';
import 'package:turnarix/data/repository/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:turnarix/utill/app_constants.dart';
import 'package:async/async.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepo? authRepo;
  AuthProvider({@required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _checkEmailLoading = false;
  bool get checkEmailLoading => _checkEmailLoading;

  String _loginErrorMessage = '';
  String get loginErrorMessage => _loginErrorMessage;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  String _registrationErrorMessage = '';
  String get registrationErrorMessage => _registrationErrorMessage;

  String _checkEmailMessage = '';
  String get checkEmailMessage => _checkEmailMessage;

  //GOOGLE LOGIN
  String? _accessToken;
  String? get accessToken => _accessToken;

  String? _idToken;
  String? get idToken => _idToken;

  String? _googleFullName;
  String? get googleFullName => _googleFullName;

  String? _googleEmail;
  String? get googleEmail => _googleEmail;

  String? _googleProviderId;
  String? get googleProviderId => _googleProviderId;

  String _verificationMsg = '';
  String get verificationMessage => _verificationMsg;

  bool _isEnableVerificationCode = false;
  bool get isEnableVerificationCode => _isEnableVerificationCode;

  String _verificationCode = '';
  String get verificationCode => _verificationCode;

  bool _verifyTokenLoading = false;
  bool get verifyTokenLoading => _verifyTokenLoading;

  bool _isverificationButtonLoading = false;
  bool get isverificationButtonLoading => _isverificationButtonLoading;

  bool _termsAccepted = false;
  bool get termsAccepted => _termsAccepted;

  SignUpModel? _signUpModel;
  SignUpModel? get signUpModel => _signUpModel;

  bool _isForgotPasswordLoading = false;
  bool get isForgotPasswordLoading => _isForgotPasswordLoading;

  File? _profileImageFile;
  File? get profileImageFile => _profileImageFile;

  File? _driverLicenseImageFile;
  File? get driverLicenseImageFile => _driverLicenseImageFile;

  File? _driverInsuranceImageFile;
  File? get driverInsuranceImageFile => _driverInsuranceImageFile;

  String _email = '';
  String get email => _email;

  String _name = '';
  String get name => _name;

  String _surName = '';
  String get surName => _surName;

  String _roleName = 'Selezionare';
  String get roleName => _roleName;

  String _phoneNumber = '';
  String get phoneNumber => _phoneNumber;

  int? _roleId;
  int? get roleId => _roleId;

  List<EmployeeRoleModel> _employeeRoles = [];
  List<EmployeeRoleModel> get employeeRoles => _employeeRoles;

  Future<ResponseModel> getEmployeeRoles(BuildContext? context) async {
    ResponseModel _responseModel;
    ApiResponse apiResponse = await authRepo!.getEmployeeRoles();
    if(apiResponse.response != null){
      if (apiResponse.response!.statusCode == 200) {
        _employeeRoles = [];
        apiResponse.response!.data.forEach((model) {
          _employeeRoles.add(EmployeeRoleModel.fromJson(model));
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

  void setTermValue(bool value) {
    _termsAccepted = value;
    notifyListeners();
  }

  void setProfileImage(File image) {
    _profileImageFile = image;
    notifyListeners();
  }

  void setLicenseImage(File image) {
    _driverLicenseImageFile = image;
    notifyListeners();
  }

  void setInsuranceImage(File image) {
    _driverInsuranceImageFile = image;
    notifyListeners();
  }

  void setSignUpModel(SignUpModel model){
    _signUpModel = model;
    notifyListeners();
  }

  void setFirstScreenValues(String name, String surName, String email){
    _name = name;
    _surName = surName;
    _email = email;
    notifyListeners();
  }

  void setRole(String roleName, int roleId){
    _roleName = roleName;
    _roleId = roleId;
    notifyListeners();
  }

  void setSecondScreenValues(String phone){
    _phoneNumber = phone;
    notifyListeners();
  }


  String getUserNumber() {
    return authRepo!.getUserNumber() ?? "";
  }
  String getUserPassword() {
    return authRepo!.getUserPassword() ?? "";
  }
  var box = Hive.box('myBox');

  Future<bool> checkLoggedIn() async {
    var _token = box.get(AppConstants.TOKEN);
    _isLoggedIn = _token != null? true: false;
    print('token --  ${_token}');
    return _token != null? true: false;
  }

  void clearVerificationMessage() {
    _verificationMsg = '';
  }

  Future<ResponseModel> login(String email, String password) async {
    _isLoading = true;
    _loginErrorMessage = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo!.login(email: email, password: password);
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map map = apiResponse.response!.data;
      String token = map["token"];
      authRepo!.saveUserToken(token).then((value) {
        checkLoggedIn();
      });
      await authRepo!.updateToken();
      responseModel = ResponseModel(true, 'successful');
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error.errors[0].message;
      }
      print(errorMessage);
      _loginErrorMessage = errorMessage;
      responseModel = ResponseModel(false, errorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<bool> clearSharedData() async {
    _isLoading = true;
    notifyListeners();
    bool _isSuccess = await authRepo!.clearSharedData();
    _isLoading = false;
    notifyListeners();
    return _isSuccess;
  }

  Future<ResponseModel> socialLogin(String email, String fullname, String providerName, String providerId) async {
    print('providerName test: ${providerName}  --- provider id=$providerId');
    _isLoading = true;
    _loginErrorMessage = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo!.socialLogin(email: email, fullname: fullname,providerName: providerName, providerId: providerId);
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map map = apiResponse.response!.data;
      String token = map["token"];
      authRepo!.saveUserToken(token).then((value) {
        checkLoggedIn();
      });
      await authRepo!.updateToken();
      responseModel = ResponseModel(true, 'successful');
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error.errors[0].message;
      }
      print(errorMessage);
      _loginErrorMessage = errorMessage;
      responseModel = ResponseModel(false, errorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<void> signInWithGoogle() async {
    // begin interactive sign process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtain auth details from request
    final GoogleSignInAuthentication gAuth  =await gUser!.authentication;

    // create a new credential for user
    _accessToken = gAuth.accessToken;
    _idToken = gAuth.idToken;

    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: _accessToken,
        idToken: _idToken
    );
    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    // Access the user data from the user credential
    final User user = userCredential.user!;
    print('USER: ${user}');

    _googleEmail = user.providerData[0].email; // why email value here is null
    _googleFullName = user.displayName;
    _googleProviderId = user.uid;
    print('Google Email: ${_googleEmail}');
    print('Google Full Name: ${_googleFullName}');
    print('Google ProviderId: ${_googleProviderId}');

  }


  updateEmail(String email) {
    _email = email;
    notifyListeners();
  }

  Future<ResponseModel> checkEmail(String email, String fromUpdatePassword) async {
    _checkEmailLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo!.checkEmail(email, fromUpdatePassword);

    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _checkEmailLoading = false;
      responseModel = ResponseModel(true, 'success!');
    } else {
      _checkEmailLoading = false;
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
      _checkEmailMessage = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }

  void resetMessages(){
    _checkEmailMessage = '';
    _registrationErrorMessage = '';
    notifyListeners();
  }

  Future<ResponseModel> registration(SignUpModel signUpModel) async {
    print('signup model ${jsonEncode(signUpModel)}');
    _isLoading = true;
    _registrationErrorMessage = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo!.registration(signUpModel);
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

      Map map = apiResponse.response!.data;
      String token = map["token"];
      authRepo!.saveUserToken(token).then((value) {
        checkLoggedIn();
      });
      await authRepo!.updateToken();
      responseModel = ResponseModel(true, 'successful');
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        errorMessage = errorResponse.errors![0].message!;
      }
      print(errorMessage);
      _registrationErrorMessage = errorMessage;
      responseModel = ResponseModel(false, errorMessage);

    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }


  Future<http.StreamedResponse> registerImages(String token) async {
    print('step 1');
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.BASE_URL}${AppConstants.REGISTER_IMAGES_URI}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer ${token}'});
    if(_profileImageFile != null) {
      print('step 2');
      print('----------------${_profileImageFile!.readAsBytes().asStream()}/${_profileImageFile!.lengthSync()}/${_profileImageFile!.path.split('/').last}');
      request.files.add(http.MultipartFile('profile_image', new http.ByteStream(DelegatingStream.typed(_profileImageFile!.openRead())), _profileImageFile!.lengthSync(), filename: _profileImageFile!.path.split('/').last));
    }

    if(_driverLicenseImageFile != null) {
      print('----------------${_driverLicenseImageFile!.readAsBytes().asStream()}/${_driverLicenseImageFile!.lengthSync()}/${_driverLicenseImageFile!.path.split('/').last}');
      request.files.add(http.MultipartFile('license_image', new http.ByteStream(DelegatingStream.typed(_driverLicenseImageFile!.openRead())), _driverLicenseImageFile!.lengthSync(), filename: _driverLicenseImageFile!.path.split('/').last));
    }

    if(_driverInsuranceImageFile != null) {
      print('----------------${_driverInsuranceImageFile!.readAsBytes().asStream()}/${_driverInsuranceImageFile!.lengthSync()}/${_driverInsuranceImageFile!.path.split('/').last}');
      request.files.add(http.MultipartFile('insurance_image', new http.ByteStream(DelegatingStream.typed(_driverInsuranceImageFile!.openRead())), _driverInsuranceImageFile!.lengthSync(), filename: _driverInsuranceImageFile!.path.split('/').last));
    }

    Map<String, String> _fields = Map();
    {
      _fields.addAll(<String, String>{
        '_method': 'post',
      });
    }
    request.fields.addAll(_fields);

    http.StreamedResponse response = await request.send();
    return response;
  }

  updateVerificationCode(String query) {
    if (query.length == 4) {
      _isEnableVerificationCode = true;
    } else {
      _isEnableVerificationCode = false;
    }
    _verificationCode = query;
    notifyListeners();
  }

  Future<ResponseModel> verifyEmail(String email) async {
    _isverificationButtonLoading = true;
    _verificationMsg = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo!.verifyEmail(email, _verificationCode);
    _isverificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel(true, apiResponse.response!.data["message"]);
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
      _verificationMsg = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> verifyPasswordToken(String email) async {
    _verifyTokenLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo!.verifyPasswordToken(email, _verificationCode);
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _verifyTokenLoading = false;
      notifyListeners();
      responseModel = ResponseModel(true, apiResponse.response!.data["message"]);
    } else {
      _verifyTokenLoading = false;
      notifyListeners();
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
    return responseModel;
  }

  Future<ResponseModel> verifyToken(String email) async {
    _verifyTokenLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo!.verifyToken(email, _verificationCode);
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _verifyTokenLoading = false;
      notifyListeners();
      responseModel = ResponseModel(true, apiResponse.response!.data["message"]);
    } else {
      _verifyTokenLoading = false;
      notifyListeners();
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
    return responseModel;
  }

  Future<ResponseModel> forgetPassword(String email) async {
    _isForgotPasswordLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo!.forgetPassword(email);
    _isForgotPasswordLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isForgotPasswordLoading = false;
      responseModel = ResponseModel(true, apiResponse.response!.data["message"]);
    } else {
      _isForgotPasswordLoading = false;
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
    return responseModel;
  }

  Future<ResponseModel> resetPassword(String email, String password, String confirmPassword) async {
   _isForgotPasswordLoading = true;
    print('email : ${email}');
    notifyListeners();
    ApiResponse apiResponse = await authRepo!.resetPassword(email, password, confirmPassword);
    _isForgotPasswordLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel(true, apiResponse.response!.data["message"]);
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
    return responseModel;
  }


  void resetSignUpModel() {
    _signUpModel = null;
    notifyListeners();
  }
  String getUserToken() {
    return authRepo!.getUserToken();
  }
}