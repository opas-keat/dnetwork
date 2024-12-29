class UserServiceRequest {
  List<Users>? users;

  UserServiceRequest({this.users});

  UserServiceRequest.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? id;
  String? userType;
  String? userStatus;
  String? userName;
  String? firstName;
  String? lastName;
  String? province;
  String? passwords;
  String? idCard;

  Users(
      {this.id,
      this.userType,
      this.userStatus,
      this.userName,
      this.firstName,
      this.lastName,
      this.province,
      this.passwords,
      this.idCard});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    userStatus = json['user_status'];
    userName = json['user_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    province = json['province'];
    passwords = json['user_pass'];
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
    data['user_pass'] = passwords;
    data['id_card'] = idCard;
    return data;
  }
}
