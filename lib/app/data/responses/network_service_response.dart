class NetworkServiceResponse {
  String? code;
  String? message;
  List<NetworkData>? data;

  NetworkServiceResponse({this.code, this.message, this.data});

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
  String? networkDate;
  String? networkLocation;

  NetworkData(
      {this.id,
      this.name,
      this.telephone,
      this.address,
      this.position,
      this.networkDate,
      this.networkLocation});

  NetworkData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    telephone = json['telephone'];
    address = json['address'];
    position = json['position'];
    networkDate = json['network_date'];
    networkLocation = json['network_location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['telephone'] = telephone;
    data['address'] = address;
    data['position'] = position;
    data['network_date'] = networkDate;
    data['network_location'] = networkLocation;
    return data;
  }
}
