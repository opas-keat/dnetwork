// class AuthenServiceResponse {
//   AuthenServiceResponse({
//     required this.statusCode,
//     required this.code,
//     required this.message,
//     required this.data,
//   });

//   int? statusCode;
//   String? code;
//   String? message;
//   AuthenServiceData? data;

//   AuthenServiceResponse.withError({
//     this.statusCode,
//     String? msg,
//   }) : message = msg;

//   factory AuthenServiceResponse.fromJson(Map<String, dynamic> json) =>
//       AuthenServiceResponse(
//         statusCode: json["status_code"],
//         code: json["code"],
//         message: json["message"],
//         data: AuthenServiceData.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status_code": statusCode,
//         "code": code,
//         "message": message,
//         "data": data,
//       };
// }

// class AuthenServiceData {
//   String? message;
//   String? token;
//   String? refreshToken;

//   AuthenServiceData({this.message, this.token, this.refreshToken});

//   AuthenServiceData.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     token = json['token'];
//     refreshToken = json['refreshToken'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['message'] = message;
//     data['token'] = token;
//     data['refreshToken'] = refreshToken;
//     return data;
//   }
// }

class AuthenServiceResponse {
  String? code;
  String? message;
  AuthenData? data;

  AuthenServiceResponse({this.code, this.message, this.data});

  AuthenServiceResponse.withError({
    code,
    String? msg,
  }) : message = msg;

  AuthenServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? AuthenData.fromJson(json['data']) : null;
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

class AuthenData {
  List<Roles>? roles;
  String? token;
  String? username;

  AuthenData({this.roles, this.token, this.username});

  AuthenData.fromJson(Map<String, dynamic> json) {
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(Roles.fromJson(v));
      });
    }
    token = json['token'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    data['token'] = token;
    data['username'] = username;
    return data;
  }
}

class Roles {
  String? role;

  Roles({this.role});

  Roles.fromJson(Map<String, dynamic> json) {
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role'] = role;
    return data;
  }
}
