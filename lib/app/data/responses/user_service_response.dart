class UserServiceResponse {
  String? code;
  String? message;
  UserData? data;

  UserServiceResponse({this.code, this.message, this.data});

  UserServiceResponse.withError({
    code,
    String? msg,
  }) : message = msg;

  UserServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserData {
  int? id;
  String? userType;
  String? userStatus;
  String? userName;
  String? firstName;
  String? lastName;
  String? province;
  String? pdpaCheck;

  UserData(
      {this.id,
      this.userType,
      this.userStatus,
      this.userName,
      this.firstName,
      this.lastName,
      this.province,
      this.pdpaCheck});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    userStatus = json['user_status'];
    userName = json['user_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    province = json['province'];
    pdpaCheck = json['pdpa_check'];
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
    return data;
  }
}
