class StationServiceResponse {
  String? code;
  String? message;
  List<StationData>? data;

  StationServiceResponse({this.code, this.message, this.data});

  StationServiceResponse.withError({
    code,
    String? msg,
  }) : message = msg;

  StationServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StationData>[];
      json['data'].forEach((v) {
        data!.add(StationData.fromJson(v));
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

class StationData {
  int? id;
  String? name;
  String? location;
  String? province;
  String? amphure;
  String? district;
  String? process;
  String? facebook;
  int? totalComiss;
  int? totalMember;

  StationData(
      {this.id,
      this.name,
      this.location,
      this.province,
      this.amphure,
      this.district,
      this.process,
      this.facebook,
      this.totalComiss,
      this.totalMember});

  StationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    province = json['province'];
    amphure = json['amphure'];
    district = json['district'];
    process = json['process'];
    facebook = json['facebook'];
    totalComiss = json['total_comiss'];
    totalMember = json['total_member'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['location'] = location;
    data['province'] = province;
    data['amphure'] = amphure;
    data['district'] = district;
    data['process'] = process;
    data['facebook'] = facebook;
    data['total_comiss'] = totalComiss;
    data['total_member'] = totalMember;
    return data;
  }
}
