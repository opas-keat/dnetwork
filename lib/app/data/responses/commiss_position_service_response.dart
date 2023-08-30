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
  int? totalData;

  CommissPositionData({this.id, this.name, this.totalData});

  CommissPositionData.fromJson(Map<String, dynamic> json) {
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
