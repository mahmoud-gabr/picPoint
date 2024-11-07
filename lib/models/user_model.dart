class UserModel {
  String? id;
  String? name;
  String? email;
  String? role;

  String? password;
  UserModel({
    this.id,
    this.name = "",
    this.email = "",
    this.role = '',
    this.password,
  });

  UserModel.fromJson(Map<dynamic, dynamic> map)
      : id = map['id'] ?? "",
        name = map['name'] ?? "",
        email = map['email'] ?? "",
        role = map['role'] ?? '';

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'role': role,
        if (id != null) 'id': id,
      };
}
