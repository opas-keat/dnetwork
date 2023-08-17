class VillageServiceResponse {
  String? code;
  String? message;
  List<VillageData>? data;

  VillageServiceResponse({this.code, this.message, this.data});

  VillageServiceResponse.withError({
    code,
    String? msg,
  }) : message = msg;

  VillageServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <VillageData>[];
      json['data'].forEach((v) {
        data!.add(VillageData.fromJson(v));
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

class VillageData {
  int? id;
  String? villageName;
  String? villageNo;
  int? villageTotal;
  int? villageTotalUsed;
  String? villageActivity;
  String? villageActYear;
  int? villageGoalAct;
  String? villageGoalAct2;
  String? villageTypeAct;
  String? villageLocation;
  String? election;
  String? province;
  String? amphure;
  String? district;

  VillageData(
      {this.id,
      this.villageName,
      this.villageNo,
      this.villageTotal,
      this.villageTotalUsed,
      this.villageActivity,
      this.villageActYear,
      this.villageGoalAct,
      this.villageGoalAct2,
      this.villageTypeAct,
      this.villageLocation,
      this.election,
      this.province,
      this.amphure,
      this.district});

  VillageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    villageName = json['village_name'];
    villageNo = json['village_no'];
    villageTotal = json['village_total'];
    villageTotalUsed = json['village_total_used'];
    villageActivity = json['village_activity'];
    villageActYear = json['village_act_year'];
    villageGoalAct = json['village_goal_act'];
    villageGoalAct2 = json['village_goal_act2'];
    villageTypeAct = json['village_type_act'];
    villageLocation = json['village_location'];
    election = json['election'];
    province = json['province'];
    amphure = json['amphure'];
    district = json['district'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['village_name'] = villageName;
    data['village_no'] = villageNo;
    data['village_total'] = villageTotal;
    data['village_total_used'] = villageTotalUsed;
    data['village_activity'] = villageActivity;
    data['village_act_year'] = villageActYear;
    data['village_goal_act'] = villageGoalAct;
    data['village_goal_act2'] = villageGoalAct2;
    data['village_type_act'] = villageTypeAct;
    data['village_location'] = villageLocation;
    data['election'] = election;
    data['province'] = province;
    data['amphure'] = amphure;
    data['district'] = district;
    return data;
  }
}
