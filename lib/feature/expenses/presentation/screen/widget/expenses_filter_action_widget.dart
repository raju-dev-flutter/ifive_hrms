import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';

class ExpensesFilterActionWidget extends StatelessWidget {
  final String from;
  final String to;
  final Function() onPressedFromDate;
  final Function() onPressedToDate;
  final Function() onPressedSearch;

  const ExpensesFilterActionWidget(
      {super.key,
      required this.from,
      required this.to,
      required this.onPressedFromDate,
      required this.onPressedToDate,
      required this.onPressedSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 6).w,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: onPressedFromDate,
              borderRadius: Dimensions.kBorderRadiusAllSmallest,
              child: Container(
                height: 42,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: boxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      from,
                      style: context.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: appColor.gray900,
                      ),
                    ),
                    SvgPicture.asset(
                      AppSvg.calendar,
                      width: 14.w,
                      colorFilter: ColorFilter.mode(
                        appColor.gray700,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: onPressedToDate,
              borderRadius: Dimensions.kBorderRadiusAllSmallest,
              child: Container(
                height: 42,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: boxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      to,
                      style: context.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: appColor.gray900,
                        // fontSize: 8,
                      ),
                    ),
                    SvgPicture.asset(
                      AppSvg.calendar,
                      width: 14.w,
                      colorFilter: ColorFilter.mode(
                        appColor.gray700,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 4.w),
          InkWell(
            onTap: onPressedSearch,
            borderRadius: Dimensions.kBorderRadiusAllSmallest,
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: appColor.brand600,
                borderRadius: Dimensions.kBorderRadiusAllSmallest,
              ),
              child: SvgPicture.asset(
                AppSvg.search,
                width: 14,
                colorFilter: ColorFilter.mode(
                  appColor.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: appColor.white,
      borderRadius: Dimensions.kBorderRadiusAllSmallest,
      border: Border.all(width: 1, color: appColor.gray400),
    );
  }
}
