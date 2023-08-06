class VillageServiceResponse {
  String? code;
  String? message;
  List<VillageData>? data;

  VillageServiceResponse({this.code, this.message, this.data});

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
  String? name;
  String? no;
  String? address;
  int? total;

  VillageData({this.id, this.name, this.no, this.address, this.total});

  VillageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    no = json['no'];
    address = json['address'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['no'] = no;
    data['address'] = address;
    data['total'] = total;
    return data;
  }
}
