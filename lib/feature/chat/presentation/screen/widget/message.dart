import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../chat.dart';

class Message extends StatelessWidget {
  final MessageContent message;

  const Message({super.key, required this.message});

  bool itsYou(int id) {
    return id == SharedPrefs().getId();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: itsYou(message.senderId ?? 0)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          TextMessage(message: message),
          // AudioMessage(message: message),
        ],
      ),
    );
  }
}
