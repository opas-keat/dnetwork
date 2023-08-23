class CommissServiceRequest {
  List<Commisss>? commisss;

  CommissServiceRequest({this.commisss});

  CommissServiceRequest.fromJson(Map<String, dynamic> json) {
    if (json['commisss'] != null) {
      commisss = <Commisss>[];
      json['commisss'].forEach((v) {
        commisss!.add(Commisss.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (commisss != null) {
      data['commisss'] = commisss!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Commisss {
  int? id;
  int? commissStationId;
  String? commissStationName;
  String? province;
  String? amphure;
  String? district;
  String? commissFirstName;
  String? commissSurName;
  String? commissIdCard;
  String? commissBirthYear;
  String? commissLocation;
  String? commissDate;
  String? commissTelephone;
  String? commissPosition;
  String? commissPositionCommu;
  String? commissExp;

  Commisss(
      {this.id,
      this.commissStationId,
      this.commissStationName,
      this.province,
      this.amphure,
      this.district,
      this.commissFirstName,
      this.commissSurName,
      this.commissIdCard,
      this.commissBirthYear,
      this.commissLocation,
      this.commissDate,
      this.commissTelephone,
      this.commissPosition,
      this.commissPositionCommu,
      this.commissExp});

  Commisss.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commissStationId = json['commiss_station_id'];
    commissStationName = json['commiss_station_name'];
    province = json['province'];
    amphure = json['amphure'];
    district = json['district'];
    commissFirstName = json['commiss_first_name'];
    commissSurName = json['commiss_sur_name'];
    commissIdCard = json['commiss_id_card'];
    commissBirthYear = json['commiss_birth_year'];
    commissLocation = json['commiss_location'];
    commissDate = json['commiss_date'];
    commissTelephone = json['commiss_telephone'];
    commissPosition = json['commiss_position'];
    commissPositionCommu = json['commiss_position_commu'];
    commissExp = json['commiss_exp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['commiss_station_id'] = commissStationId;
    data['commiss_station_name'] = commissStationName;
    data['province'] = province;
    data['amphure'] = amphure;
    data['district'] = district;
    data['commiss_first_name'] = commissFirstName;
    data['commiss_sur_name'] = commissSurName;
    data['commiss_id_card'] = commissIdCard;
    data['commiss_birth_year'] = commissBirthYear;
    data['commiss_location'] = commissLocation;
    data['commiss_date'] = commissDate;
    data['commiss_telephone'] = commissTelephone;
    data['commiss_position'] = commissPosition;
    data['commiss_position_commu'] = commissPositionCommu;
    data['commiss_exp'] = commissExp;
    return data;
  }
}
