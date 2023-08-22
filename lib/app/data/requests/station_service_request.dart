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
  int? id;
  String? name;
  int? totalCommiss;
  int? totalMember;
  String? process;
  String? province;
  String? amphure;
  String? district;
  String? location;
  String? facebook;
  String? training;

  Stations(
      {this.id,
      this.name,
      this.totalCommiss,
      this.totalMember,
      this.process,
      this.province,
      this.amphure,
      this.district,
      this.location,
      this.facebook,
      this.training});

  Stations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    totalCommiss = json['total_commiss'];
    totalMember = json['total_member'];
    process = json['process'];
    province = json['province'];
    amphure = json['amphure'];
    district = json['district'];
    location = json['location'];
    facebook = json['facebook'];
    training = json['training'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['total_commiss'] = totalCommiss;
    data['total_member'] = totalMember;
    data['process'] = process;
    data['province'] = province;
    data['amphure'] = amphure;
    data['district'] = district;
    data['location'] = location;
    data['facebook'] = facebook;
    data['training'] = training;
    return data;
  }
}
