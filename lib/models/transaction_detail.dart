class TransactionDetail{
  final int id;
  final String receiverId;
  final String senderId;
  final int amount;
  final String currentTimestamp;
  TransactionDetail({
    required this.id,
    required this.receiverId,
    required this.senderId,
    required this.amount,
    required this.currentTimestamp
});
  factory TransactionDetail.fromMap(Map data){
    return TransactionDetail(
      id: data["id"],
      receiverId: data["receiver_id"],
      senderId: data["sender_id"],
      amount: int.parse(data["amount"].toString()),
      currentTimestamp: data["current_timestamp"].toString()
    );
  }


}