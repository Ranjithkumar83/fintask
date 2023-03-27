
class User{
  final String name;
  final String email;
  final String password;
  final String role;

  User(
      {required this.name,
      required this.email,
      required this.password,
      required this.role});

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      name: map["name"],
      email: map["email"],
      password: map["password"],
      role: map["role"],
    );
  }

  toMap() {
    Map<String, dynamic> map = Map();
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['role'] = role;
  }
}
