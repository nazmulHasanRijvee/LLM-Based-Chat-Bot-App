

import '../../domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {

  MessageModel({
    required super.role,
    required super.text,
    required super.time
  });


  Map<String, dynamic> toJson() {

    return {
      "role" : role,
      "content" : [
        {
          "type" : "text",
          "text" : text
        }
      ]
    };

  }

}