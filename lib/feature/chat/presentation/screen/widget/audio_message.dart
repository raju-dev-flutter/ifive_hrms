import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../chat.dart';

class AudioMessage extends StatelessWidget {
  final MessageContent message;

  const AudioMessage({super.key, required this.message});

  bool itsYou(int id) {
    return id == SharedPrefs().getId();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: Dimensions.kPaddingAllSmaller,
      decoration: BoxDecoration(
        color: appColor.white,
        borderRadius: Dimensions.kBorderRadiusAllSmaller,
      ),
      child: Row(
        children: [
          Icon(Icons.play_arrow, color: appColor.gray600),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                      width: double.infinity,
                      height: 2,
                      color: appColor.gray600),
                  Positioned(
                    left: 0,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: appColor.gray600,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "0.37",
            style:
                context.textTheme.labelLarge?.copyWith(color: appColor.gray600),
          ),
        ],
      ),
      // child: Text(
      //   message.message ?? "",
      //   textAlign: TextAlign.start,
      //   style: context.textTheme.labelLarge?.copyWith(color: appColor.gray600),
      // ),
    );
  }
}
