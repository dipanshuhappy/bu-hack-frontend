class StaffAuth {
  final String token;
  final int userId;
  final int staffId;

  StaffAuth(
      {required this.token, required this.userId, required this.staffId});

  factory StaffAuth.fromMap(Map data){
    return StaffAuth(
        token: data["token"],
        userId: data["user_id"],
        staffId: data["staff_id"]
    );
  }
}