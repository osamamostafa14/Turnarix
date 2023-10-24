class SignUpModel {
  String? name;
  String? surname;
  String? phone;
  String? address;
  String? roleName;
  int? roleId;
  String? email;
  String? password;

  SignUpModel({this.name,this.surname, this.phone,this.address, this.roleName, this.roleId, this.email='', this.password});

  SignUpModel.fromJson(Map<String?, dynamic> json) {
    name = json['name'];
    surname = json['surname'];
    address = json['address'];
    phone = json['phone'];
    roleName = json['role_name'];
    roleId = json['role_id'];
    email = json['email'];
    password = json['password'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['email'] = this.email;
    data['role_name'] = this.roleName;
    data['role_id'] = this.roleId;
    data['password'] = this.password;
    return data;
  }
}
