class AlphaExcelParsingDetails {
  final int id;
  final String senderId;
  final String quizTimings;
  final String quizSubject;
  var excelPicked;
  AlphaExcelParsingDetails({
    required this.id,
    required this.senderId,
    required this.quizTimings,
    required this.quizSubject,
    required this.excelPicked
  });
  factory AlphaExcelParsingDetails.fromMap(Map data){
    return AlphaExcelParsingDetails(
        id: data["id"],
        senderId: data["sender_id"],
        quizTimings: data["quiz_time"].toString(),
        quizSubject: data["quiz_subject"].toString(),
        excelPicked: data["excel_picked"]
    );
  }


}