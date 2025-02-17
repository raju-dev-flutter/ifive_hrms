import 'package:flutter/material.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';

class ChatInputField extends StatefulWidget {
  final TextEditingController messageController;
  final VoidCallback onPressed;

  const ChatInputField(
      {Key? key, required this.messageController, required this.onPressed})
      : super(key: key);

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  bool isSend = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Dimensions.kPaddingAllMedium,
      decoration: BoxDecoration(
        color: appColor.gray50,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: appColor.gray500.withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0 * 0.75,
                ),
                decoration: BoxDecoration(
                  color: appColor.brand600.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    // Icon(
                    //   Icons.sentiment_satisfied_alt_outlined,
                    //   color: appColor.gray500,
                    // ),
                    Expanded(
                      child: CustomTextFormField(
                        borderColor: Colors.transparent,
                        controller: widget.messageController,
                        required: false,
                        onChanged: (val) {
                          setState(() => isSend = val != '' ? true : false);
                        },
                        maxLines: 1,
                      ),
                    ),
                    Icon(Icons.attach_file, color: appColor.gray500),
                    if (!isSend) ...[
                      Dimensions.kHorizontalSpaceSmall,
                      Icon(Icons.camera_alt_outlined, color: appColor.gray500),
                    ],
                  ],
                ),
              ),
            ),
            Dimensions.kHorizontalSpaceSmall,
            ActionButton(
              width: 48,
              radius: 40,
              onPressed: widget.onPressed,
              child: Icon(
                isSend ? Icons.send : Icons.mic,
                color: appColor.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
