class UserModel {
  final String email;
  final String password;

  const UserModel({required this.email, required this.password});

  @override
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      email: data.containsKey("email") ? data["email"] : '',
      password: data.containsKey("password") ? data["password"] : '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}
