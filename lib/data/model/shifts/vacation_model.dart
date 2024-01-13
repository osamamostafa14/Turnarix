//
// class VacationModel {
//   int? _id;
//   int? _intervalId;
//   String? _name;
//   String? _startDate;
//   String? _endDate;
//   String? _createdAt;
//   String? _updatedAt;
//
//   VacationModel({
//     int? id,
//     int? intervalId,
//     String? name,
//     String? startDate,
//     String? endDate,
//     String? createdAt,
//     String? updatedAt,
//   }) {
//     this._id = id;
//     this._intervalId = intervalId;
//     this._name = name;
//     this._startDate = startDate;
//     this._endDate = endDate;
//     this._createdAt = createdAt;
//     this._updatedAt = updatedAt;
//   }
//
//   int? get id => _id;
//   int? get intervalId => _intervalId;
//   String? get name => _name;
//   String? get startDate => _startDate;
//   String? get endDate => _endDate;
//   String? get createdAt => _createdAt;
//   String? get updatedAt => _updatedAt;
//
//   VacationModel.fromJson(Map<String, dynamic> json) {
//     _id = json['id'];
//     _intervalId = json['interval_id'];
//     _name = json['name'];
//     _startDate = json['start_date'];
//     _endDate = json['end_date'];
//     _createdAt = json['created_at'];
//     _updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {
//       'id': _id,
//       'interval_id': _intervalId,
//       'name': _name,
//       'start_date': _startDate,
//       'end_date': _endDate,
//       'created_at': _createdAt,
//       'updated_at': _updatedAt,
//     };
//     return data;
//   }
// }
