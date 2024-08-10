class PatientModel {
  String patient_names;
  String patient_phone;
  String patient_password;

  PatientModel(
    this.patient_names,
    this.patient_phone,
    this.patient_password,
  );

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
      json['names'] as String,
      json['phone'] as String,
      json['password'] as String);
  Map<String, dynamic> toJson() => {
        'names': patient_names.toString(),
        'phone': patient_phone.toString(),
        'password': patient_password.toString()
      };
}
