class StationServiceRequest {
  List<Stations>? stations;

  StationServiceRequest({this.stations});

  StationServiceRequest.fromJson(Map<String, dynamic> json) {
    if (json['stations'] != null) {
      stations = <Stations>[];
      json['stations'].forEach((v) {
        stations!.add(Stations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (stations != null) {
      data['stations'] = stations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stations {
  String? name;
  int? totalComiss;
  String? process;
  String? province;
  String? amphure;
  String? district;
  String? location;

  Stations(
      {this.name,
      this.totalComiss,
      this.process,
      this.province,
      this.amphure,
      this.district,
      this.location});

  Stations.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    totalComiss = json['total_comiss'];
    process = json['process'];
    province = json['province'];
    amphure = json['amphure'];
    district = json['district'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['total_comiss'] = totalComiss;
    data['process'] = process;
    data['province'] = province;
    data['amphure'] = amphure;
    data['district'] = district;
    data['location'] = location;
    return data;
  }
}
