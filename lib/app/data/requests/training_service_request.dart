class TrainingServiceRequest {
  List<Trainings>? trainings;

  TrainingServiceRequest({this.trainings});

  TrainingServiceRequest.fromJson(Map<String, dynamic> json) {
    if (json['trainings'] != null) {
      trainings = <Trainings>[];
      json['trainings'].forEach((v) {
        trainings!.add(Trainings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (trainings != null) {
      data['trainings'] = trainings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Trainings {
  String? trainingName;
  String? trainingDateForm;
  String? trainingDateTo;
  String? trainingType;
  int? trainingTotal;
  String? province;

  Trainings(
      {this.trainingName,
      this.trainingDateForm,
      this.trainingDateTo,
      this.trainingType,
      this.trainingTotal,
      this.province});

  Trainings.fromJson(Map<String, dynamic> json) {
    trainingName = json['training_name'];
    trainingDateForm = json['training_date_form'];
    trainingDateTo = json['training_date_to'];
    trainingType = json['training_type'];
    trainingTotal = json['training_total'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['training_name'] = trainingName;
    data['training_date_form'] = trainingDateForm;
    data['training_date_to'] = trainingDateTo;
    data['training_type'] = trainingType;
    data['training_total'] = trainingTotal;
    data['province'] = province;
    return data;
  }
}
