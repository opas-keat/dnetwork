class NetworkPositionServiceResponse {
  String? code;
  String? message;
  List<NetworkPositionData>? data;

  NetworkPositionServiceResponse({this.code, this.message, this.data});

  NetworkPositionServiceResponse.withError({
    code,
    String? msg,
  }) : message = msg;

  NetworkPositionServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NetworkPositionData>[];
      json['data'].forEach((v) {
        data!.add(NetworkPositionData.fromJson(v));
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

class NetworkPositionData {
  int? id;
  String? name;
  int? totalData;

  NetworkPositionData({this.id, this.name, this.totalData});

  NetworkPositionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    totalData = json['total_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['total_data'] = totalData;
    return data;
  }
}
