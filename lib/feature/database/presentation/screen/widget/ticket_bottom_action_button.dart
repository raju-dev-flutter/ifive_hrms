import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../database.dart';

class TicketBottomActionButton extends StatelessWidget {
  final int position;
  final Function() onPressedBack;
  final Function() onPressedNext;
  final Function() onPressedSubmit;

  const TicketBottomActionButton(
      {super.key,
      required this.position,
      required this.onPressedBack,
      required this.onPressedNext,
      required this.onPressedSubmit});

  @override
  Widget build(BuildContext context) {
    final isFirstPage = position == 0 ? true : false;
    final isLastPage = position == 5 ? true : false;
    return Container(
      height: 70.h,
      color: appColor.white,
      padding: const EdgeInsets.symmetric(horizontal: 16).w,
      child: BlocBuilder<SfaCrudBloc, SfaCrudState>(
        builder: (context, state) {
          if (state is SfaCrudLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isFirstPage) Container(),
              if (!isFirstPage)
                ActionButton(
                  width: 120,
                  color: appColor.gray200,
                  onPressed: onPressedBack,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: Dimensions.iconSizeSmallest,
                      ),
                      Dimensions.kHorizontalSpaceSmallest,
                      Text("Back ", style: context.textTheme.bodySmall),
                    ],
                  ),
                ),
              if (isLastPage)
                ActionButton(
                  width: 120,
                  color: appColor.success600,
                  onPressed: onPressedSubmit,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(" Submit",
                          style: context.textTheme.bodySmall
                              ?.copyWith(color: appColor.white)),
                      Dimensions.kHorizontalSpaceSmallest,
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: Dimensions.iconSizeSmallest,
                        color: appColor.white,
                      ),
                    ],
                  ),
                ),
              if (!isLastPage)
                ActionButton(
                  width: 120,
                  color: appColor.blue600,
                  onPressed: onPressedNext,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(" Next",
                          style: context.textTheme.bodySmall
                              ?.copyWith(color: appColor.white)),
                      Dimensions.kHorizontalSpaceSmallest,
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: Dimensions.iconSizeSmallest,
                        color: appColor.white,
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     if (isFirstPage) Container(),
      //     if (!isFirstPage)
      //       ActionButton(
      //         width: 120,
      //         color: appColor.gray200,
      //         onPressed: onPressedBack,
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Icon(
      //               Icons.arrow_back_ios_new_rounded,
      //               size: Dimensions.iconSizeSmallest,
      //             ),
      //             Dimensions.kHorizontalSpaceSmallest,
      //             Text("Back ", style: context.textTheme.bodySmall),
      //           ],
      //         ),
      //       ),
      //     if (isLastPage)
      //       ActionButton(
      //         width: 120,
      //         color: appColor.success600,
      //         onPressed: onPressedSubmit,
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Text(" Submit",
      //                 style: context.textTheme.bodySmall
      //                     ?.copyWith(color: appColor.white)),
      //             Dimensions.kHorizontalSpaceSmallest,
      //             Icon(
      //               Icons.arrow_forward_ios_rounded,
      //               size: Dimensions.iconSizeSmallest,
      //               color: appColor.white,
      //             ),
      //           ],
      //         ),
      //       ),
      //     if (!isLastPage)
      //       ActionButton(
      //         width: 120,
      //         color: appColor.blue600,
      //         onPressed: onPressedNext,
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Text(" Next",
      //                 style: context.textTheme.bodySmall
      //                     ?.copyWith(color: appColor.white)),
      //             Dimensions.kHorizontalSpaceSmallest,
      //             Icon(
      //               Icons.arrow_forward_ios_rounded,
      //               size: Dimensions.iconSizeSmallest,
      //               color: appColor.white,
      //             ),
      //           ],
      //         ),
      //       ),
      //   ],
      // ),
    );
  }
}
