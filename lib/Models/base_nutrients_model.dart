class FitnessCalculatorResponse {
  int statusCode;
  String requestResult;
  FitnessData data;

  FitnessCalculatorResponse({
    required this.statusCode,
    required this.requestResult,
    required this.data,
  });

  factory FitnessCalculatorResponse.fromJson(Map<String, dynamic> json) {
    return FitnessCalculatorResponse(
      statusCode: json['status_code'],
      requestResult: json['request_result'],
      data: FitnessData.fromJson(json['data']),
    );
  }
}

class FitnessData {
  int BMR;
  Goals goals;

  FitnessData({
    required this.BMR,
    required this.goals,
  });

  factory FitnessData.fromJson(Map<String, dynamic> json) {
    return FitnessData(
      BMR: json['BMR'],
      goals: Goals.fromJson(json['goals']),
    );
  }
}

class Goals {
  int maintainWeight;
  WeightLoss mildWeightLoss;
  WeightLoss weightLoss;
  WeightLoss extremeWeightLoss;
  WeightGain mildWeightGain;
  WeightGain weightGain;
  WeightGain extremeWeightGain;

  Goals({
    required this.maintainWeight,
    required this.mildWeightLoss,
    required this.weightLoss,
    required this.extremeWeightLoss,
    required this.mildWeightGain,
    required this.weightGain,
    required this.extremeWeightGain,
  });

  factory Goals.fromJson(Map<String, dynamic> json) {
    return Goals(
      maintainWeight: json['maintain weight'],
      mildWeightLoss: WeightLoss.fromJson(json['Mild weight loss']),
      weightLoss: WeightLoss.fromJson(json['Weight loss']),
      extremeWeightLoss: WeightLoss.fromJson(json['Extreme weight loss']),
      mildWeightGain: WeightGain.fromJson(json['Mild weight gain']),
      weightGain: WeightGain.fromJson(json['Weight gain']),
      extremeWeightGain: WeightGain.fromJson(json['Extreme weight gain']),
    );
  }
}

class WeightLoss {
  String lossWeight;
  int calory;

  WeightLoss({
    required this.lossWeight,
    required this.calory,
  });

  factory WeightLoss.fromJson(Map<String, dynamic> json) {
    return WeightLoss(
      lossWeight: json['loss weight'],
      calory: json['calory'],
    );
  }
}

class WeightGain {
  String gainWeight;
  int calory;

  WeightGain({
    required this.gainWeight,
    required this.calory,
  });

  factory WeightGain.fromJson(Map<String, dynamic> json) {
    return WeightGain(
      gainWeight: json['gain weight'],
      calory: json['calory'],
    );
  }
}
