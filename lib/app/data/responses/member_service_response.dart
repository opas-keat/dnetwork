class MemberServiceResponse {
  String? code;
  String? message;
  List<MemberData>? data;

  MemberServiceResponse({this.code, this.message, this.data});

  MemberServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MemberData>[];
      json['data'].forEach((v) {
        data!.add(MemberData.fromJson(v));
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

class MemberData {
  int? id;
  String? name;
  String? telephone;
  String? address;
  String? position;
  String? memberDate;
  String? memberLocation;

  MemberData(
      {this.id,
      this.name,
      this.telephone,
      this.address,
      this.position,
      this.memberDate,
      this.memberLocation});

  MemberData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    telephone = json['telephone'];
    address = json['address'];
    position = json['position'];
    memberDate = json['member_date'];
    memberLocation = json['member_location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['telephone'] = telephone;
    data['address'] = address;
    data['position'] = position;
    data['member_date'] = memberDate;
    data['member_location'] = memberLocation;
    return data;
  }
}
