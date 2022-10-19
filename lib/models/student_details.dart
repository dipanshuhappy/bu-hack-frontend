class StudentDetails {
  final int id;
  final String bennett_email;
  final String first_name;
  final String last_name;
  final String enrollment_number;
  final String school_code;
  final String department_code;
 final String batch;
  final String program;
  final String current_semester;
  factory StudentDetails.fromMap(Map data){
    return StudentDetails(
      id:data["id"],
      bennett_email:data["bennett_email"],
      first_name:data["first_name"],
      last_name:data["last_name"],
      enrollment_number:data["enrollment_number"],
      batch: data["batch"],
      current_semester: data["current_semester"].toString(),
      department_code: data["department_code"],
      program: data["program"],
      school_code: data["school_code"]
    );
  }

  StudentDetails({
    required this.id,
    required this.bennett_email,
    required this.first_name,
    required this.last_name,
    required this.enrollment_number,
    required this.school_code,
    required this.department_code,
    required this.batch,
    required this.program,
    required this.current_semester
  });
}
