class MessageContentModel {
  List<MessageContent>? messageContent;

  MessageContentModel({this.messageContent});

  MessageContentModel.fromJson(Map<String, dynamic> json) {
    if (json['message_content'] != null) {
      messageContent = <MessageContent>[];
      json['message_content'].forEach((v) {
        messageContent!.add(MessageContent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (messageContent != null) {
      data['message_content'] = messageContent!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MessageContent {
  int? messageId;
  int? senderId;
  int? receiverId;
  String? message;
  String? status;
  String? timestamp;

  MessageContent(
      {this.messageId,
      this.senderId,
      this.receiverId,
      this.message,
      this.status,
      this.timestamp});

  MessageContent.fromJson(Map<String, dynamic> json) {
    messageId = json['message_id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    message = json['message'];
    status = json['status'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message_id'] = messageId;
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['message'] = message;
    data['status'] = status;
    data['timestamp'] = timestamp;
    return data;
  }
}
