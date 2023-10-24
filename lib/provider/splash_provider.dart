import 'package:hive_flutter/hive_flutter.dart';
import 'package:turnarix/data/model/response/base/api_response.dart';
import 'package:turnarix/data/model/response/config_model.dart';
import 'package:turnarix/data/repository/splash_repo.dart';
import 'package:flutter/material.dart';

class SplashProvider extends ChangeNotifier {
  final SplashRepo? splashRepo;

  SplashProvider({@required this.splashRepo});

  ConfigModel? _configModel;
  BaseUrls? _baseUrls;

  ConfigModel? get configModel => _configModel;
  BaseUrls? get baseUrls => _baseUrls;

  int? _selectedLanguageId;
  int? get selectedLanguageId => _selectedLanguageId;

  String? _selectedLanguageCode;
  String? get selectedLanguageCode => _selectedLanguageCode;


  var box = Hive.box('myBox');

  Future<bool> initConfig(GlobalKey<ScaffoldMessengerState> globalKey, BuildContext? context) async {
    ApiResponse apiResponse = await splashRepo!.getConfig();
    bool isSuccess;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _configModel = ConfigModel.fromJson(apiResponse.response!.data);
      _baseUrls = ConfigModel.fromJson(apiResponse.response!.data).baseUrls;

      isSuccess = true;
      notifyListeners();
    } else {
      isSuccess = false;
      String _error;
      if(apiResponse.error is String) {
        _error = apiResponse.error;
      }else {
        _error = apiResponse.error.errors[0].message;
      }
      print(_error);
      globalKey.currentState!.showSnackBar(SnackBar(content: Text(_error), backgroundColor: Colors.red));
    }
    return isSuccess;
  }

  // Future<bool> initConfig(GlobalKey<ScaffoldMessengerState> globalKey) async {
  //   ApiResponse apiResponse = await splashRepo!.getConfig();
  //   bool isSuccess;
  //   if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
  //
  //     //_configModel = ConfigModel.fromJson(apiResponse.response!.data);
  //     _baseUrls = BaseUrls();
  //     isSuccess = true;
  //     print('success =  $isSuccess');
  //     print(apiResponse.response);
  //     notifyListeners();
  //   } else {
  //     isSuccess = false;
  //     String _error;
  //     if(apiResponse.error is String) {
  //       _error = apiResponse.error;
  //     }else {
  //       _error = apiResponse.error.errors[0].message;
  //     }
  //     print(_error);
  //     //globalKey.currentState.showSnackBar(SnackBar(content: Text(_error), backgroundColor: Colors.red));
  //   }
  //   return isSuccess;
  // }

  Future<bool> removeSharedData() {
    return splashRepo!.removeSharedData();
  }

  void setSelectedLanguage(int languageId, String languageCode) {
    _selectedLanguageId = languageId;
    _selectedLanguageCode = languageCode;
    notifyListeners();
  }

  void saveLanguage(int languageId, String languageCode) async {

    await box.put('language_id', languageId);
    await box.put('language_code', languageCode);
    notifyListeners();
  }


}