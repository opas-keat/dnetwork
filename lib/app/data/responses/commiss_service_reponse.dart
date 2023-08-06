class CommissServiceResponse {
  String? code;
  String? message;
  List<CommissData>? data;

  CommissServiceResponse({this.code, this.message, this.data});

  CommissServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CommissData>[];
      json['data'].forEach((v) {
        data!.add(CommissData.fromJson(v));
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

class CommissData {
  int? id;
  String? name;
  String? telephone;
  String? province;
  String? amphure;
  String? district;
  String? position;
  String? commissDate;
  String? commissLocation;

  CommissData(
      {this.id,
      this.name,
      this.telephone,
      this.province,
      this.amphure,
      this.district,
      this.position,
      this.commissDate,
      this.commissLocation});

  CommissData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    telephone = json['telephone'];
    province = json['province'];
    amphure = json['amphure'];
    district = json['district'];
    position = json['position'];
    commissDate = json['commiss_date'];
    commissLocation = json['commiss_location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['telephone'] = telephone;
    data['province'] = province;
    data['amphure'] = amphure;
    data['district'] = district;
    data['position'] = position;
    data['commiss_date'] = commissDate;
    data['commiss_location'] = commissLocation;
    return data;
  }
}
