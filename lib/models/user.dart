class User {
  final String username;
  final String role;


  User({required this.username, required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      role: json['role'],
    );
  }
}
