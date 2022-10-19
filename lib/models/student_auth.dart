class StudentAuth {
  final String token;
  final int userId;
  final int studentId;

  StudentAuth(
      {required this.token, required this.userId, required this.studentId});

  factory StudentAuth.fromMap(Map data){
    return StudentAuth(
        token: data["token"],
        userId: data["user_id"],
        studentId: data["student_id"]
    );
  }
}