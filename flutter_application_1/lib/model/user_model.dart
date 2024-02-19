class UserModel {
  String? name;
  String? id;
  String? phone;
  String? childEmail;
  String? type;
  String? gender;
  String? dob;

  UserModel(
      {this.name,
      this.childEmail,
      this.id,
      this.phone,
      this.type,
      this.gender,
      this.dob});

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'id': id,
        'childEmail': childEmail,
        'type': type,
        'gender': gender,
        'dob': dob
      };
}
