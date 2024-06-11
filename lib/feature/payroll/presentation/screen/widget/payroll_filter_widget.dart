import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';

class PayrollFilterWidget extends StatelessWidget {
  final DateTime fromDate;
  final DateTime toDate;
  final VoidCallback selectFromDate;
  final VoidCallback selectToDate;
  final VoidCallback search;
  const PayrollFilterWidget(
      {super.key,
      required this.fromDate,
      required this.toDate,
      required this.selectFromDate,
      required this.selectToDate,
      required this.search});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 4).w,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: selectFromDate,
              borderRadius: Dimensions.kBorderRadiusAllSmallest,
              child: Container(
                height: 42,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: boxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        // 'FROM DATE',
                        DateFormat('dd-MM-yyyy').format(fromDate),
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: appColor.gray900,
                        ),
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
              onTap: selectToDate,
              borderRadius: Dimensions.kBorderRadiusAllSmallest,
              child: Container(
                height: 42,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: boxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        // 'TO DATE',
                        DateFormat('dd-MM-yyyy').format(toDate),
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: appColor.gray900,
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      AppSvg.calendar,
                      width: 14.w,
                      colorFilter:
                          ColorFilter.mode(appColor.gray700, BlendMode.srcIn),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 4.w),
          InkWell(
            onTap: search,
            borderRadius: Dimensions.kBorderRadiusAllSmallest,
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: appColor.brand900,
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
      border: Border.all(width: 1, color: appColor.gray300),
    );
  }
}
