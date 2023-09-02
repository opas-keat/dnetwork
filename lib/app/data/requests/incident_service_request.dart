class IncidentServiceRequest {
  List<Incidents>? incidents;

  IncidentServiceRequest({this.incidents});

  IncidentServiceRequest.fromJson(Map<String, dynamic> json) {
    if (json['incidents'] != null) {
      incidents = <Incidents>[];
      json['incidents'].forEach((v) {
        incidents!.add(Incidents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (incidents != null) {
      data['incidents'] = incidents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Incidents {
  int? id;
  String? incidentModule;
  String? incidentTitle;
  String? incidentDetail;
  String? province;
  String? resolvedDetail;

  Incidents(
      {this.id,
      this.incidentModule,
      this.incidentTitle,
      this.incidentDetail,
      this.province,
      this.resolvedDetail});

  Incidents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    incidentModule = json['incident_module'];
    incidentTitle = json['incident_title'];
    incidentDetail = json['incident_detail'];
    province = json['province'];
    resolvedDetail = json['resolved_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['incident_module'] = incidentModule;
    data['incident_title'] = incidentTitle;
    data['incident_detail'] = incidentDetail;
    data['province'] = province;
    data['resolved_detail'] = resolvedDetail;
    return data;
  }
}
