class ServiceAllowanceModel {
  int? _id;
  String? _name;
  String? _amount;
  bool? _status;
  int? _intervalId;

  ServiceAllowanceModel(
      {int? id,
        String? name,
        String? amount,
        bool? status,
        int? intervalId,
      }) {
    this._id = id;
    this._name = name;
    this._amount = amount;
    this._status = status;
    this._intervalId = intervalId;
  }

  int? get id => _id;
  String? get name => _name;
  String? get amount => _amount;
  bool? get status => _status;
  int? get intervalId => _intervalId;

  set status(bool? value) {
    _status = value;
  }

  set amount(String? value) {
    _amount = value;
  }

  ServiceAllowanceModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _amount = json['amount'].toString();
    _status = json['status'] == 1? true: false;
    _intervalId = json['interval_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': _id,
      'name': _name,
      'amount': _amount,
      'status': _status,
      'interval_id': _intervalId,
    };
    return data;
  }
}
