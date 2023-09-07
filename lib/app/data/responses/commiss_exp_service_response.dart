class CommissExpServiceResponse {
  String? code;
  String? message;
  List<CommissExpData>? data;

  CommissExpServiceResponse({this.code, this.message, this.data});

  CommissExpServiceResponse.withError({
    code,
    String? msg,
  }) : message = msg;

  CommissExpServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CommissExpData>[];
      json['data'].forEach((v) {
        data!.add(CommissExpData.fromJson(v));
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

class CommissExpData {
  int? id;
  String? name;
  int? totalData;

  CommissExpData({this.id, this.name, this.totalData});

  CommissExpData.fromJson(Map<String, dynamic> json) {
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
