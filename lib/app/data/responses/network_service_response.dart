class NetworkServiceResponse {
  String? code;
  String? message;
  List<NetworkData>? data;

  NetworkServiceResponse({this.code, this.message, this.data});

  NetworkServiceResponse.withError({
    code,
    String? msg,
  }) : message = msg;

  NetworkServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NetworkData>[];
      json['data'].forEach((v) {
        data!.add(NetworkData.fromJson(v));
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

class NetworkData {
  int? id;
  int? networkStationId;
  String? networkStationName;
  String? province;
  String? amphure;
  String? district;
  String? networkFirstName;
  String? networkSurName;
  String? networkIdCard;
  String? networkBirthYear;
  String? networkLocation;
  String? networkDate;
  String? networkTelephone;
  String? networkPosition;
  String? networkPositionCommu;
  String? networkExp;
  String? networkPreName;
  String? networkAgency;

  NetworkData({
    this.id,
    this.networkStationId,
    this.networkStationName,
    this.province,
    this.amphure,
    this.district,
    this.networkFirstName,
    this.networkSurName,
    this.networkIdCard,
    this.networkBirthYear,
    this.networkLocation,
    this.networkDate,
    this.networkTelephone,
    this.networkPosition,
    this.networkPositionCommu,
    this.networkExp,
    this.networkPreName,
    this.networkAgency,
  });

  NetworkData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    networkStationId = json['network_station_id'];
    networkStationName = json['network_station_name'];
    province = json['province'];
    amphure = json['amphure'];
    district = json['district'];
    networkFirstName = json['network_first_name'];
    networkSurName = json['network_sur_name'];
    networkIdCard = json['network_id_card'];
    networkBirthYear = json['network_birth_year'];
    networkLocation = json['network_location'];
    networkDate = json['network_date'];
    networkTelephone = json['network_telephone'];
    networkPosition = json['network_position'];
    networkPositionCommu = json['network_position_commu'];
    networkExp = json['network_exp'];
    networkPreName = json['network_pre_name'];
    networkAgency = json['network_agency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['network_station_id'] = networkStationId;
    data['network_station_name'] = networkStationName;
    data['province'] = province;
    data['amphure'] = amphure;
    data['district'] = district;
    data['network_first_name'] = networkFirstName;
    data['network_sur_name'] = networkSurName;
    data['network_id_card'] = networkIdCard;
    data['network_birth_year'] = networkBirthYear;
    data['network_location'] = networkLocation;
    data['network_date'] = networkDate;
    data['network_telephone'] = networkTelephone;
    data['network_position'] = networkPosition;
    data['network_position_commu'] = networkPositionCommu;
    data['network_exp'] = networkExp;
    data['network_pre_name'] = networkPreName;
    data['network_agency'] = networkAgency;
    return data;
  }
}
