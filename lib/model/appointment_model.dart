// lib/models/appointment_model.dart

class AppointmentModel {
  final int id;
  final String title;
  final int patientId;
  final DateTime? appointmentDate;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  AppointmentModel({
    required this.id,
    required this.title,
    required this.patientId,
    this.appointmentDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create an instance from JSON
  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      title: json['title'],
      patientId: json['patientId'],
      appointmentDate: json['appointmentDate'] != null
          ? DateTime.parse(json['appointmentDate'])
          : null,
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'patientId': patientId,
      'appointmentDate': appointmentDate?.toIso8601String(),
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
