class IncidentServiceResponse {
  String? code;
  String? message;
  List<IncidentData>? data;

  IncidentServiceResponse({this.code, this.message, this.data});

  IncidentServiceResponse.withError({
    code,
    String? msg,
  }) : message = msg;

  IncidentServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <IncidentData>[];
      json['data'].forEach((v) {
        data!.add(IncidentData.fromJson(v));
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

class IncidentData {
  int? id;
  String? createdBy;
  String? incidentDate;
  String? incidentModule;
  String? incidentTitle;
  String? incidentDetail;
  String? resolvedDate;
  String? resolvedDetail;
  String? province;

  IncidentData(
      {this.id,
      this.createdBy,
      this.incidentDate,
      this.incidentModule,
      this.incidentTitle,
      this.incidentDetail,
      this.resolvedDate,
      this.resolvedDetail,
      this.province});

  IncidentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdBy = json['created_by'];
    incidentDate = json['incident_date'];
    incidentModule = json['incident_module'];
    incidentTitle = json['incident_title'];
    incidentDetail = json['incident_detail'];
    resolvedDate = json['resolved_date'];
    resolvedDetail = json['resolved_detail'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_by'] = createdBy;
    data['incident_date'] = incidentDate;
    data['incident_module'] = incidentModule;
    data['incident_title'] = incidentTitle;
    data['incident_detail'] = incidentDetail;
    data['resolved_date'] = resolvedDate;
    data['resolved_detail'] = resolvedDetail;
    data['province'] = province;
    return data;
  }
}
