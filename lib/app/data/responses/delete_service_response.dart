class DeleteServiceResponse {
  String? code;
  String? message;
  bool? data;

  DeleteServiceResponse({this.code, this.message, this.data});

  DeleteServiceResponse.withError({
    code,
    String? msg,
  }) : message = msg;

  DeleteServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}
