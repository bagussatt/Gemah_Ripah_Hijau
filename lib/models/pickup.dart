class Pickup {
  int id;
  String status;
  String waktu;
  String lokasi;
  String catatan;

  Pickup({
    required this.id,
    required this.status,
    required this.waktu,
    required this.lokasi,
    required this.catatan,
  });

  factory Pickup.fromJson(Map<String, dynamic> json) => Pickup(
        id: json['id'],
        status: json['status'],
        waktu: json['waktu'],
        lokasi: json['lokasi'],
        catatan: json['catatan'],
      );
}
