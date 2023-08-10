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
  String? name;
  String? telephone;
  String? address;
  String? position;
  int? networkStationId;
  String? networkStationName;
  String? networkFirstName;
  String? networkSurName;
  String? networkIdCard;
  String? networkBirthYear;
  String? networkDate;
  String? networkLocation;
  String? networkTelephone;
  String? networkPosition;
  String? networkPositionCommu;
  String? networkExp;

  NetworkData(
      {this.id,
      this.name,
      this.telephone,
      this.address,
      this.position,
      this.networkStationId,
      this.networkStationName,
      this.networkFirstName,
      this.networkSurName,
      this.networkIdCard,
      this.networkBirthYear,
      this.networkDate,
      this.networkLocation,
      this.networkTelephone,
      this.networkPosition,
      this.networkPositionCommu,
      this.networkExp});

  NetworkData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    telephone = json['telephone'];
    address = json['address'];
    position = json['position'];
    networkStationId = json['network_station_id'];
    networkStationName = json['network_station_name'];
    networkFirstName = json['network_first_name'];
    networkSurName = json['network_sur_name'];
    networkIdCard = json['network_id_card'];
    networkBirthYear = json['network_birth_year'];
    networkDate = json['network_date'];
    networkLocation = json['network_location'];
    networkTelephone = json['network_telephone'];
    networkPosition = json['network_position'];
    networkPositionCommu = json['network_position_commu'];
    networkExp = json['network_exp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['telephone'] = telephone;
    data['address'] = address;
    data['position'] = position;
    data['network_station_id'] = networkStationId;
    data['network_station_name'] = networkStationName;
    data['network_first_name'] = networkFirstName;
    data['network_sur_name'] = networkSurName;
    data['network_id_card'] = networkIdCard;
    data['network_birth_year'] = networkBirthYear;
    data['network_date'] = networkDate;
    data['network_location'] = networkLocation;
    data['network_telephone'] = networkTelephone;
    data['network_position'] = networkPosition;
    data['network_position_commu'] = networkPositionCommu;
    data['network_exp'] = networkExp;
    return data;
  }
}
