class AdminReadPickup {
  final int id;
  final String status;
  final String catatan;
  final String waktu;
  final String lokasi;

  AdminReadPickup({
    required this.id,
    required this.status,
    required this.catatan,
    required this.waktu,
    required this.lokasi,
  });

  factory AdminReadPickup.fromJson(Map<String, dynamic> json) {
    return AdminReadPickup(
      id: json['id'],
      status: json['status'],
      catatan: json['catatan'],
      waktu: json['waktu'],
      lokasi: json['lokasi'],
    );
  }
}
