import 'package:turnarix/data/model/response/user_info_model.dart';

class ChatUsersPaginator {
  int? _totalSize;
  String? _limit;
  String? _offset;
  List<UserInfoModel>? _users;

  ChatUsersPaginator(
      {int? totalSize, String? limit, String? offset, List<UserInfoModel>? users}) {
    this._totalSize = totalSize;
    this._limit = limit;
    this._offset = offset;
    this._users = users;
  }

  int? get totalSize => _totalSize;
  String? get limit => _limit;
  String? get offset => _offset;
  List<UserInfoModel>? get users => _users;

  ChatUsersPaginator.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _limit = json['limit'].toString();
    _offset = json['offset'];

    if (json['users'] != null) {
      _users = [];
      json['users'].forEach((v) {
        _users!.add(UserInfoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this._totalSize;
    data['limit'] = this._limit;
    data['offset'] = this._offset;

    return data;
  }
}

