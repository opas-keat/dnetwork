class CommissPositionCommuServiceResponse {
  String? code;
  String? message;
  List<CommissPositionCommuData>? data;

  CommissPositionCommuServiceResponse({this.code, this.message, this.data});

  CommissPositionCommuServiceResponse.withError({
    code,
    String? msg,
  }) : message = msg;

  CommissPositionCommuServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CommissPositionCommuData>[];
      json['data'].forEach((v) {
        data!.add(CommissPositionCommuData.fromJson(v));
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

class CommissPositionCommuData {
  int? id;
  String? name;

  CommissPositionCommuData({this.id, this.name});

  CommissPositionCommuData.fromJson(Map<String, dynamic> json) {
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
