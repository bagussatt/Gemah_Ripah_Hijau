import 'package:intl/intl.dart';

class ReadPickup {
  final int id;
  final String waktu;
  final String lokasi;
  final String catatan;
  final String status;

  ReadPickup({
    required this.id,
    required this.waktu,
    required this.lokasi,
    required this.catatan,
    required this.status,
  });

  factory ReadPickup.fromJson(Map<String, dynamic> json) {
    return ReadPickup(
      id: json['id'],
      waktu: json['waktu'],
      lokasi: json['lokasi'],
      catatan: json['catatan'] ?? "Belum Ada Catatan",
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'waktu': waktu,
      'lokasi': lokasi,
      'catatan': catatan,
      'status': status,
    };
  }

  String formattedDateTime() {
    DateTime dateTime = DateTime.parse(waktu);
    return DateFormat('dd MMMM yyyy, HH:mm').format(dateTime);
  }
}
