class MemberServiceRequest {
  List<Members>? members;

  MemberServiceRequest({this.members});

  MemberServiceRequest.fromJson(Map<String, dynamic> json) {
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(Members.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Members {
  int? id;
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
  String? memberPreName;

  Members(
      {this.id,this.memberStationId,
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
      this.memberExp,
      this.memberPreName});

  Members.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    memberPreName = json['member_pre_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
     data['id'] = id;
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
    data['member_pre_name'] = memberPreName;
    return data;
  }
}
