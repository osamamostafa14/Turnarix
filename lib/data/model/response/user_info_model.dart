class UserInfoModel {
  int? id;
  String? name;
  String? surname;
  String? email;
  String? roleName;
  int? roleId;
  String? address;
  String? image;
  int? isPhoneVerified;
  String? emailVerifiedAt;
  String? providerName;
  String? createdAt;
  String? updatedAt;
  String? emailVerificationToken;
  String? phone;
  String? cmFirebaseToken;
  int? updateVersion;
  int? status;

  UserInfoModel(
      {this.id,
        this.name,
        this.surname,
        this.email,
        this.roleName,
        this.roleId,
        this.address,
        this.image,
        this.isPhoneVerified,
        this.emailVerifiedAt,
        this.providerName,
        this.createdAt,
        this.updatedAt,
        this.emailVerificationToken,
        this.phone,
        this.cmFirebaseToken,
        this.updateVersion,
        this.status,
      });

  UserInfoModel.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    email = json['email'];
    roleName = json['role_name'];
    roleId = json['role_id'];
    address = json['address'];
    image = json['image'];
    isPhoneVerified = json['is_phone_verified'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    emailVerificationToken = json['email_verification_token'];
    phone = json['phone'];
    cmFirebaseToken = json['cm_firebase_token'];
    updateVersion = json['update_version'];
    providerName = json['provider_name'];
    status = json['status'];
  }

}

