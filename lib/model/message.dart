class Message {

  int id;
  String messages;
  int userId;
  String createdAt;
  int? senderId;

  Message(this.id,
      this.messages,
      this.userId,
      this.createdAt,
      this.senderId);

  factory Message.fromJson(dynamic json) {
    return Message(
        json['id'] as int,
        json['messages'] as String,
        json['userId'] as int,
        json['createdAt'] as String,
        json['senderId'] as int

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'messages':messages,
      'userId' :userId,
      'createdAt': createdAt,
      'senderId': senderId
    };
  }
}