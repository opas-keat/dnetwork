class SummaryInfoServiceResponse {
  String? code;
  String? message;
  List<SummaryInfoData>? data;

  SummaryInfoServiceResponse({this.code, this.message, this.data});

  SummaryInfoServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SummaryInfoData>[];
      json['data'].forEach((v) {
        data!.add(SummaryInfoData.fromJson(v));
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

class SummaryInfoData {
  String? id;
  String? name;
  String? nameEn;
  int? value;

  SummaryInfoData({this.id, this.name, this.nameEn, this.value});

  SummaryInfoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['nameEn'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['nameEn'] = nameEn;
    data['value'] = value;
    return data;
  }
}
