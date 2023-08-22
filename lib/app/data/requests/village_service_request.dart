class VillageServiceRequest {
  List<Villages>? villages;

  VillageServiceRequest({this.villages});

  VillageServiceRequest.fromJson(Map<String, dynamic> json) {
    if (json['villages'] != null) {
      villages = <Villages>[];
      json['villages'].forEach((v) {
        villages!.add(Villages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (villages != null) {
      data['villages'] = villages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Villages {
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
  String? election;
  String? province;
  String? amphure;
  String? district;
  String? villageLocation;

  Villages({
    this.id,
    this.villageName,
    this.villageNo,
    this.villageTotal,
    this.villageTotalUsed,
    this.villageActivity,
    this.villageActYear,
    this.villageGoalAct,
    this.villageGoalAct2,
    this.villageTypeAct,
    this.election,
    this.province,
    this.amphure,
    this.district,
    this.villageLocation,
  });

  Villages.fromJson(Map<String, dynamic> json) {
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
    election = json['election'];
    province = json['province'];
    amphure = json['amphure'];
    district = json['district'];
    villageLocation = json['village_location'];
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
    data['election'] = election;
    data['province'] = province;
    data['amphure'] = amphure;
    data['district'] = district;
    data['village_location'] = villageLocation;
    return data;
  }
}
