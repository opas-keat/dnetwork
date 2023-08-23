class NetworkServiceRequest {
  List<Networks>? networks;

  NetworkServiceRequest({this.networks});

  NetworkServiceRequest.fromJson(Map<String, dynamic> json) {
    if (json['networks'] != null) {
      networks = <Networks>[];
      json['networks'].forEach((v) {
        networks!.add(Networks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (networks != null) {
      data['networks'] = networks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Networks {
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

  Networks(
      {this.id,this.networkStationId,
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
      this.networkExp});

  Networks.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
