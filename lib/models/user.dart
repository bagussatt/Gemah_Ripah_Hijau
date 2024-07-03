class User {
  final int id;
  final String username;
  final String role;

  User({required this.id, required this.username, required this.role});

  factory User.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException("Invalid JSON format");
    }

    return User(
      id: json['user_id'] ?? 0, // Ganti dengan nilai default sesuai kebutuhan
      username:
          json['username'] ?? '', // Ganti dengan nilai default sesuai kebutuhan
      role: json['role'] ?? '', // Ganti dengan nilai default sesuai kebutuhan
    );
  }
}
