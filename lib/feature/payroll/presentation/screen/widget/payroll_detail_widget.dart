import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ifive_hrms/core/constants/app_assets.dart';

import '../../../../../config/config.dart';
import '../../../payroll.dart';

class PayrollDetailWidget extends StatelessWidget {
  final PaySlipResponse payroll;

  const PayrollDetailWidget({super.key, required this.payroll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4).w,
      child: Container(
        padding: Dimensions.kPaddingAllSmall,
        decoration: BoxDecoration(
          color: appColor.white,
          borderRadius: Dimensions.kBorderRadiusAllSmaller,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 44.w,
                  height: 44.h,
                  alignment: Alignment.center,
                  padding: Dimensions.kPaddingAllSmall,
                  decoration: BoxDecoration(
                    color: appColor.brand50,
                    borderRadius: Dimensions.kBorderRadiusAllLargest,
                  ),
                  child: SvgPicture.asset(
                    AppSvg.payroll,
                    colorFilter:
                        ColorFilter.mode(appColor.brand800, BlendMode.srcIn),
                  ),
                ),
                Dimensions.kHorizontalSpaceSmall,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (payroll.employeeNumber ?? '').toString(),
                        style: context.textTheme.labelLarge
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      Dimensions.kVerticalSpaceSmallest,
                      Text(
                        ("${payroll.monthName} ${payroll.year}").toUpperCase(),
                        style: context.textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
                Dimensions.kHorizontalSpaceSmallest,
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, AppRouterPath.payrollDetailsScreen,
                        arguments: PayrollDetailsScreen(
                            paySlipId: payroll.id.toString()));
                  },
                  borderRadius: Dimensions.kBorderRadiusAllLargest,
                  child: Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    // padding: Dimensions.kPaddingAllSmall,
                    decoration: BoxDecoration(
                      color: appColor.brand50,
                      borderRadius: Dimensions.kBorderRadiusAllLargest,
                    ),
                    child: Icon(
                      Icons.remove_red_eye_rounded,
                      color: appColor.brand800,
                      size: 16,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
