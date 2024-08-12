class ResultModel {
  final int id;
  final int patientId;
  final int addedBy;
  final String result;
  final String referenceRange;
  final String comments;
  final String patientName;
  final DateTime createdAt;
  final DateTime updatedAt;

  ResultModel({
    required this.id,
    required this.patientId,
    required this.addedBy,
    required this.result,
    required this.referenceRange,
    required this.comments,
    required this.patientName,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create an instance from a JSON map
  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      id: json['id'],
      patientId: json['patientId'],
      addedBy: json['addedBy'],
      result: json['result'],
      referenceRange: json['referenceRange'],
      comments: json['comments'],
      patientName: json['patientName'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'addedBy': addedBy,
      'result': result,
      'referenceRange': referenceRange,
      'comments': comments,
      'patientName': patientName,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
