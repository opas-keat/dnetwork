class ProvinceSummaryServiceResponse {
  String? code;
  String? message;
  List<ProvinceSummaryData>? data;

  ProvinceSummaryServiceResponse({this.code, this.message, this.data});

  ProvinceSummaryServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ProvinceSummaryData>[];
      json['data'].forEach((v) {
        data!.add(ProvinceSummaryData.fromJson(v));
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

class ProvinceSummaryData {
  String? id;
  String? seal;
  String? name;
  int? totalStation;
  int? totalCommiss;
  int? totalMember;
  int? totalNetwork;
  int? totalLectuter;
  int? totalVillage;

  ProvinceSummaryData(
      {this.id,
      this.seal,
      this.name,
      this.totalStation,
      this.totalCommiss,
      this.totalMember,
      this.totalNetwork,
      this.totalLectuter,
      this.totalVillage});

  ProvinceSummaryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    seal = json['seal'];
    name = json['name'];
    totalStation = json['totalStation'];
    totalCommiss = json['totalCommiss'];
    totalMember = json['totalMember'];
    totalNetwork = json['totalNetwork'];
    totalLectuter = json['totalLectuter'];
    totalVillage = json['totalVillage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['seal'] = seal;
    data['name'] = name;
    data['totalStation'] = totalStation;
    data['totalCommiss'] = totalCommiss;
    data['totalMember'] = totalMember;
    data['totalNetwork'] = totalNetwork;
    data['totalLectuter'] = totalLectuter;
    data['totalVillage'] = totalVillage;
    return data;
  }
}
