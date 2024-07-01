class Complaint {
  final int userId;
  final String complaint;
  final String photoUrl;

  Complaint({required this.userId, required this.complaint, required this.photoUrl});

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      userId: json['user_id'],
      complaint: json['complaint'],
      photoUrl: json['photo_url'],
    );
  }
}
