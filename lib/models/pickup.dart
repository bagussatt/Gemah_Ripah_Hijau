class Pickup {
  final int id;
  final String status;
  final String waktu;
  final String lokasi;
  final String catatan;

  Pickup({
    required this.id,
    required this.status,
    required this.waktu,
    required this.lokasi,
    required this.catatan,
  });

  factory Pickup.fromJson(Map<String, dynamic> json) {
    return Pickup(
      id: json['id'],
      status: json['status'],
      waktu: json['waktu'],
      lokasi: json['lokasi'],
      catatan: json['catatan'],
    );
  }
}
