class MemberPositionServiceResponse {
  String? code;
  String? message;
  List<MemberPositionData>? data;

  MemberPositionServiceResponse({this.code, this.message, this.data});

  MemberPositionServiceResponse.withError({
    code,
    String? msg,
  }) : message = msg;

  MemberPositionServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MemberPositionData>[];
      json['data'].forEach((v) {
        data!.add(MemberPositionData.fromJson(v));
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

class MemberPositionData {
  int? id;
  String? name;
  int? totalData;

  MemberPositionData({this.id, this.name, this.totalData});

  MemberPositionData.fromJson(Map<String, dynamic> json) {
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
