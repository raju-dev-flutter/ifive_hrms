import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../chat.dart';

class TextMessage extends StatelessWidget {
  final MessageContent message;

  const TextMessage({super.key, required this.message});

  bool itsYou(int id) {
    return id == SharedPrefs().getId();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: itsYou(message.senderId ?? 0)
          ? EdgeInsets.only(left: 70.w)
          : EdgeInsets.only(right: 70.w),
      padding: Dimensions.kPaddingAllSmaller,
      decoration: BoxDecoration(
        color: appColor.white,
        borderRadius: Dimensions.kBorderRadiusAllSmaller,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Text(
              message.message ?? "",
              textAlign: TextAlign.start,
              style: context.textTheme.labelLarge
                  ?.copyWith(color: appColor.gray800),
            ),
          ),
          Text(
            message.timestamp != null
                ? PickDateTime.stringFormat12Time(message.timestamp ?? "")
                : "",
            textAlign: TextAlign.end,
            style: context.textTheme.labelSmall
                ?.copyWith(color: appColor.gray400, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
