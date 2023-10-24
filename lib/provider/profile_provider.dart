import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turnarix/data/model/response/base/api_response.dart';
import 'package:turnarix/data/model/response/base/error_response.dart';
import 'package:turnarix/data/model/response/response_model.dart';
import 'package:turnarix/data/model/response/signup_model.dart';
import 'package:turnarix/data/model/response/user_info_model.dart';
import 'package:turnarix/data/repository/profile_repo.dart';
import 'package:http/http.dart' as http;
import 'package:turnarix/utill/app_constants.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileRepo? profileRepo;
  ProfileProvider({@required this.profileRepo});

  UserInfoModel? _userInfoModel;
  UserInfoModel? get userInfoModel => _userInfoModel;

  bool _profileSelected = false;
  bool get profileSelected => _profileSelected;

  File? _profileImageFile;
  File? get profileImageFile => _profileImageFile;

  File? _driverInsuranceImageFile;
  File? get driverInsuranceImageFile => _driverInsuranceImageFile;

  File? _driverLicenseImageFile;
  File? get driverLicenseImageFile => _driverLicenseImageFile;


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

  Future<ResponseModel> getUserInfo(BuildContext? context) async {

    ResponseModel _responseModel;
    ApiResponse apiResponse = await profileRepo!.getUserInfo();
    if(apiResponse.response != null){
      if (apiResponse.response!.statusCode == 200) {
        _userInfoModel = UserInfoModel.fromJson(apiResponse.response!.data);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('my_defined_user_id', _userInfoModel!.id!);
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

  void setSelectedMenuItem(String value){
    if(value == 'profile'){
      _profileSelected == false? _profileSelected = true : _profileSelected = false;
    }
    notifyListeners();
  }

  void resetMenuItems(){
    _profileSelected = false;
    notifyListeners();
  }


  Future<http.StreamedResponse> updatePersonalInfo(String token, SignUpModel signUpdModel) async {

    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.BASE_URL}${AppConstants.UPDATE_PERSONAL_INFO_URI}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer ${token}'});
    if(_profileImageFile != null) {
      print('step 2');
      print('----------------${_profileImageFile!.readAsBytes().asStream()}/${_profileImageFile!.lengthSync()}/${_profileImageFile!.path.split('/').last}');
      request.files.add(http.MultipartFile('profile_image', new http.ByteStream(DelegatingStream.typed(_profileImageFile!.openRead())), _profileImageFile!.lengthSync(), filename: _profileImageFile!.path.split('/').last));
    }

    Map<String, String> _fields = Map();
    {
      _fields.addAll(<String, String>{
        '_method': 'post',
        'name' : signUpdModel.name!,
        'email' : signUpdModel.email!,
        'phone' : signUpdModel.phone!,
        'address' : signUpdModel.address!,
        'password' : signUpdModel.password!.toString(),
      });
    }
    request.fields.addAll(_fields);

    http.StreamedResponse response = await request.send();
    return response;
  }

}