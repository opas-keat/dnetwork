class MemberServiceResponse {
  String? code;
  String? message;
  List<MemberData>? data;

  MemberServiceResponse({this.code, this.message, this.data});

  MemberServiceResponse.withError({
    code,
    String? msg,
  }) : message = msg;

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
  int? memberStationId;
  String? memberStationName;
  String? province;
  String? amphure;
  String? district;
  String? memberFirstName;
  String? memberSurName;
  String? memberIdCard;
  String? memberBirthYear;
  String? memberLocation;
  String? memberDate;
  String? memberTelephone;
  String? memberPosition;
  String? memberPositionCommu;
  String? memberExp;

  MemberData(
      {this.id,
      this.name,
      this.telephone,
      this.address,
      this.position,
      this.memberStationId,
      this.memberStationName,
      this.province,
      this.amphure,
      this.district,
      this.memberFirstName,
      this.memberSurName,
      this.memberIdCard,
      this.memberBirthYear,
      this.memberLocation,
      this.memberDate,
      this.memberTelephone,
      this.memberPosition,
      this.memberPositionCommu,
      this.memberExp});

  MemberData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    telephone = json['telephone'];
    address = json['address'];
    position = json['position'];
    memberStationId = json['member_station_id'];
    memberStationName = json['member_station_name'];
    province = json['province'];
    amphure = json['amphure'];
    district = json['district'];
    memberFirstName = json['member_first_name'];
    memberSurName = json['member_sur_name'];
    memberIdCard = json['member_id_card'];
    memberBirthYear = json['member_birth_year'];
    memberLocation = json['member_location'];
    memberDate = json['member_date'];
    memberTelephone = json['member_telephone'];
    memberPosition = json['member_position'];
    memberPositionCommu = json['member_position_commu'];
    memberExp = json['member_exp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['telephone'] = telephone;
    data['address'] = address;
    data['position'] = position;
    data['member_station_id'] = memberStationId;
    data['member_station_name'] = memberStationName;
    data['province'] = province;
    data['amphure'] = amphure;
    data['district'] = district;
    data['member_first_name'] = memberFirstName;
    data['member_sur_name'] = memberSurName;
    data['member_id_card'] = memberIdCard;
    data['member_birth_year'] = memberBirthYear;
    data['member_location'] = memberLocation;
    data['member_date'] = memberDate;
    data['member_telephone'] = memberTelephone;
    data['member_position'] = memberPosition;
    data['member_position_commu'] = memberPositionCommu;
    data['member_exp'] = memberExp;
    return data;
  }
}
