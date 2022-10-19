class StaffDetails {
  final String bennett_email;
  final String first_name;
  final String last_name;
  final String faculty_id;
  final String designation;
  final String cabin_number;
  final String intercom;
  final String school_code;
  final String department_code;
  final String phd_date;
  final String phd_institution;
  final String favourite_courses;
  final String batch_mentor;
  final String status;
  factory StaffDetails.fromMap(Map data){
    return StaffDetails(
        bennett_email:data["bennett_email"],
        first_name:data["first_name"],
        last_name:data["last_name"],
        faculty_id:data["faculty_id"].toString(),
        designation: data["designation"],
        cabin_number: data["cabin_number"],
        intercom: data["intercom"].toString(),
        department_code: data["department_code"],
        school_code: data["school_code"],
        phd_date: data["phd_date"],
      phd_institution: data["phd_institution"],
      favourite_courses: data["favourite_courses"],
      batch_mentor: data["batch_mentor"],
      status: data["status"]
    );
  }

  StaffDetails({
    required this.bennett_email,
    required this.first_name,
    required this.last_name,
    required this.faculty_id,
    required this.designation,
    required this.cabin_number,
    required this.intercom,
    required this.school_code,
    required this.department_code,
    required this.phd_date,
    required this.phd_institution,
    required this.favourite_courses,
    required this.batch_mentor,
    required this.status,
  });
}