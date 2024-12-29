class UserSearchResponse {
  String? code;
  String? message;
  List<UserSearch>? data;

  UserSearchResponse({this.code, this.message, this.data});

  UserSearchResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserSearch>[];
      json['data'].forEach((v) {
        data!.add(UserSearch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserSearch {
  int? id;
  String? userType;
  String? userStatus;
  String? userName;
  String? firstName;
  String? lastName;
  String? province;
  String? pdpaCheck;
  String? idCard;

  UserSearch(
      {this.id,
      this.userType,
      this.userStatus,
      this.userName,
      this.firstName,
      this.lastName,
      this.province,
      this.pdpaCheck,
      this.idCard});

  UserSearch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    userStatus = json['user_status'];
    userName = json['user_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    province = json['province'];
    pdpaCheck = json['pdpa_check'];
    idCard = json['id_card'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_type'] = userType;
    data['user_status'] = userStatus;
    data['user_name'] = userName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['province'] = province;
    data['pdpa_check'] = pdpaCheck;
    data['id_card'] = idCard;
    return data;
  }
}
