class ServiceAllowanceModel {
  int? _id;
  String? _name;
  String? _amount;
  bool? _status;
  String? _uniqueId;

  ServiceAllowanceModel(
      {int? id,
        String? name,
        String? amount,
        bool? status,
        String? uniqueId,
      }) {
    this._id = id;
    this._name = name;
    this._amount = amount;
    this._status = status;
    this._uniqueId = uniqueId;
  }

  int? get id => _id;
  String? get name => _name;
  String? get amount => _amount;
  bool? get status => _status;
  String? get uniqueId => _uniqueId;

  set status(bool? value) {
    _status = value;
  }

  set amount(String? value) {
    _amount = value;
  }

  ServiceAllowanceModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _amount = json['amount'];
    _status = json['status'];
    _uniqueId = json['unique_id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': _id,
      'name': _name,
      'amount': _amount,
      'unique_id': _uniqueId,
    };
    return data;
  }
}
