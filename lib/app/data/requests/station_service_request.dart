class StationServiceRequest {
  List<Stations>? stations;

  StationServiceRequest({this.stations});

  StationServiceRequest.fromJson(Map<String, dynamic> json) {
    if (json['stations'] != null) {
      stations = <Stations>[];
      json['stations'].forEach((v) {
        stations!.add(new Stations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stations != null) {
      data['stations'] = this.stations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stations {
  String? name;
  int? totalCommiss;
  int? totalMember;
  String? process;
  String? province;
  String? amphure;
  String? district;
  String? location;
  String? facebook;

  Stations(
      {this.name,
      this.totalCommiss,
      this.totalMember,
      this.process,
      this.province,
      this.amphure,
      this.district,
      this.location,
      this.facebook});

  Stations.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    totalCommiss = json['total_commiss'];
    totalMember = json['total_member'];
    process = json['process'];
    province = json['province'];
    amphure = json['amphure'];
    district = json['district'];
    location = json['location'];
    facebook = json['facebook'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['total_commiss'] = this.totalCommiss;
    data['total_member'] = this.totalMember;
    data['process'] = this.process;
    data['province'] = this.province;
    data['amphure'] = this.amphure;
    data['district'] = this.district;
    data['location'] = this.location;
    data['facebook'] = this.facebook;
    return data;
  }
}
