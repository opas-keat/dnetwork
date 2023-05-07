class AuthenServiceResponse {
  AuthenServiceResponse({
    required this.statusCode,
    required this.code,
    required this.message,
    required this.data,
  });

  int? statusCode;
  String? code;
  String? message;
  AuthenServiceData? data;

  AuthenServiceResponse.withError({
    this.statusCode,
    String? msg,
  }) : message = msg;

  factory AuthenServiceResponse.fromJson(Map<String, dynamic> json) =>
      AuthenServiceResponse(
        statusCode: json["status_code"],
        code: json["code"],
        message: json["message"],
        data: AuthenServiceData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "code": code,
        "message": message,
        "data": data,
      };
}

class AuthenServiceData {
  String? message;
  String? token;
  String? refreshToken;

  AuthenServiceData({this.message, this.token, this.refreshToken});

  AuthenServiceData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}
