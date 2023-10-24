class EmployeeRoleModel {
  int? _id;
  String? _name;

  EmployeeRoleModel(
      {  int? id,
      String? name,

      }) {
    this._id = id;
    this._name = name;
  }

  int? get id => _id;
  String? get name => _name;

  EmployeeRoleModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': _id,
      'name': _name,
    };
    return data;
  }
}
