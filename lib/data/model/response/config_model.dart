

class ConfigModel {
  String? _appName;
  String? _appLogo;
  String? _appAddress;
  String? _appPhone;
  String? _appEmail;
  BaseUrls? _baseUrls;
  String? _currencySymbol;
  String? _digitalPayment;
  String? _termsAndConditions;
  String? _privacyPolicy;
  String? _aboutUs;

  ConfigModel(
      {String? appName,
        String? appLogo,
        String? appAddress,
        String? appPhone,
        String? appEmail,
        BaseUrls? baseUrls,
        String? currencySymbol,
        String? digitalPayment,
        String? termsAndConditions,
        String? privacyPolicy,
        String? aboutUs,
       }) {
    this._appName = appName;
    this._appLogo = appLogo;
    this._appAddress = appAddress;
    this._appPhone = appPhone;
    this._appEmail = appEmail;
    this._baseUrls = baseUrls;
    this._currencySymbol = currencySymbol;
    this._digitalPayment = digitalPayment;
    this._termsAndConditions = termsAndConditions;
    this._aboutUs = aboutUs;
    this._privacyPolicy = privacyPolicy;
  }

  String? get appName => _appName;
  String? get appLogo => _appLogo;
  String? get appAddress => _appAddress;
  String? get appPhone => _appPhone;
  String? get appEmail => _appEmail;
  BaseUrls? get baseUrls => _baseUrls;
  String? get currencySymbol => _currencySymbol;
  String? get digitalPayment => _digitalPayment;
  String? get termsAndConditions => _termsAndConditions;
  String? get aboutUs=> _aboutUs;
  String? get privacyPolicy=> _privacyPolicy;


  ConfigModel.fromJson(Map<String, dynamic> json) {
    _appName = json['app_name'];
    _appLogo = json['app_logo'];
    _appAddress = json['app_address'];
    _appPhone = json['app_phone'];
    _appEmail = json['app_email'];
    _baseUrls = json['base_urls'] != null
        ? new BaseUrls.fromJson(json['base_urls'])
        : null;
    _currencySymbol = json['currency_symbol'];
    _digitalPayment = json['digital_payment'];
    _termsAndConditions = json['terms_and_conditions'];
    _privacyPolicy = json['privacy_policy'];
    _aboutUs = json['about_us'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_name'] = this._appName;
    data['app_logo'] = this._appLogo;
    data['app_address'] = this._appAddress;
    data['app_phone'] = this._appPhone;
    data['app_email'] = this._appEmail;
    if (this._baseUrls != null) {
      data['base_urls'] = this._baseUrls!.toJson();
    }
    data['currency_symbol'] = this._currencySymbol;
    data['digital_payment'] = this._digitalPayment;
    data['terms_and_conditions'] = this._termsAndConditions;
    data['privacy_policy'] = this.privacyPolicy;
    data['about_us'] = this.aboutUs;


    return data;
  }
}

class BaseUrls {
  String? _notificationImageUrl;
  String? _customerImageUrl;
  String? _chatImageUrl;
  String? _placeImageUrl;
  String? _driverImageUrl;

  BaseUrls(
      {
        String? notificationImageUrl,
        String? customerImageUrl,
        String? chatImageUrl,
        String? placeImageUrl,
        String? driverImageUrl,
      }) {

    this._notificationImageUrl = notificationImageUrl;
    this._customerImageUrl = customerImageUrl;
    this._chatImageUrl = chatImageUrl;
    this._chatImageUrl = chatImageUrl;
    this._placeImageUrl = placeImageUrl;
    this._driverImageUrl = driverImageUrl;
  }

  String? get notificationImageUrl => _notificationImageUrl;
  String? get customerImageUrl => _customerImageUrl;
  String? get chatImageUrl => _chatImageUrl;
  String? get placeImageUrl => _placeImageUrl;
  String? get driverImageUrl => _driverImageUrl;

  BaseUrls.fromJson(Map<String, dynamic> json) {
    _notificationImageUrl = json['notification_image_url'];
    _customerImageUrl = json['customer_image_url'];
    _chatImageUrl = json['chat_image_url'];
    _placeImageUrl = json['place_image_url'];
    _driverImageUrl = json['driver_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_image_url'] = this._notificationImageUrl;
    data['customer_image_url'] = this._customerImageUrl;
    data['chat_image_url'] = this._chatImageUrl;

    return data;
  }
}


