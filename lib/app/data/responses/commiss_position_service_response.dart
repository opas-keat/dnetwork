class CommissPositionServiceResponse {
  String? code;
  String? message;
  List<CommissPositionData>? data;

  CommissPositionServiceResponse({this.code, this.message, this.data});

  CommissPositionServiceResponse.withError({
    code,
    String? msg,
  }) : message = msg;

  CommissPositionServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CommissPositionData>[];
      json['data'].forEach((v) {
        data!.add(CommissPositionData.fromJson(v));
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

class CommissPositionData {
  int? id;
  String? name;

  CommissPositionData({this.id, this.name});

  CommissPositionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
