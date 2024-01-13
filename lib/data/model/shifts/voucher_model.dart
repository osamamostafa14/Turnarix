class VoucherModel {
  int? _id;
  int? _intervalId;
  double? _amount;
  String? _name;

  VoucherModel({
    int? id,
    int? intervalId,
    double? amount,
    String? name,
  }) {
    this._id = id;
    this._intervalId = intervalId;
    this._amount = amount;
    this._name = name;
  }

  int? get id => _id;
  int? get intervalId => _intervalId;
  double? get amount => _amount;
  String? get name => _name;

  set name(String? value) {
    _name = value;
  }
  set amount(double? value) {
    _amount = value;
  }

  VoucherModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _intervalId = json['interval_id'];
    _amount = json['amount'] is int? json['amount'] +.0: json['amount'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': _id,
      'interval_id': _intervalId,
      'amount': _amount,
      'name': _name,
    };
    return data;
  }
}