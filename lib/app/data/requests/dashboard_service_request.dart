class DashboardServiceRequest {
  List<Dashboards>? dashboards;

  DashboardServiceRequest({this.dashboards});

  DashboardServiceRequest.fromJson(Map<String, dynamic> json) {
    if (json['dashboards'] != null) {
      dashboards = <Dashboards>[];
      json['dashboards'].forEach((v) {
        dashboards!.add(Dashboards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dashboards != null) {
      data['dashboards'] = dashboards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dashboards {
  String? name;
  String? status;

  Dashboards({this.name, this.status});

  Dashboards.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['status'] = status;
    return data;
  }
}
