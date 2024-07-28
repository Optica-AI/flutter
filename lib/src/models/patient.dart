class Patient {
  final String name;
  final int age;
  final String dob;
  final String gender;
  final bool hasPreExistingConditions;
  final List<String> preExistingConditions;

  Patient({
    required this.name,
    required this.age,
    required this.dob,
    required this.gender,
    required this.hasPreExistingConditions,
    required this.preExistingConditions,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      name: json['name'],
      age: json['age'],
      dob: json['dob'],
      gender: json['gender'],
      hasPreExistingConditions: json['hasPreExistingConditions'],
      preExistingConditions: List<String>.from(json['preExistingConditions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'dob': dob,
      'gender': gender,
      'hasPreExistingConditions': hasPreExistingConditions,
      'preExistingConditions': preExistingConditions,
    };
  }
}
