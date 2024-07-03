class CreatePickup {
  final int userId;
  final String waktu;
  final String lokasi;

  CreatePickup({
    required this.userId,
    required this.waktu,
    required this.lokasi,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'waktu': waktu,
      'lokasi': lokasi,
    };
  }
}
