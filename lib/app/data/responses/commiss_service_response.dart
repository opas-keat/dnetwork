class CommissServiceResponse {
  String? code;
  String? message;
  List<CommissData>? data;

  CommissServiceResponse({this.code, this.message, this.data});

  CommissServiceResponse.withError({
    code,
    String? msg,
  }) : message = msg;

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
  String? position;
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
  String? commissPreName;

  CommissData({
    this.id,
    this.name,
    this.telephone,
    this.position,
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
    this.commissExp,
    this.commissPreName,
  });

  CommissData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    telephone = json['telephone'];
    position = json['position'];
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
    commissPreName = json['commiss_pre_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['telephone'] = telephone;
    data['position'] = position;
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
    data['commiss_pre_name'] = commissPreName;
    return data;
  }
}
