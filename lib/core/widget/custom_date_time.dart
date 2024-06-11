// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:rxdart/rxdart.dart';
//
// import '../../../../../config/config.dart';
// import '../constants/constants.dart';
//
// class CustomDateTime extends StatelessWidget {
//   final String label;
//   final String icon;
//   final ValueStream<String> streamDate;
//   final VoidCallback onPressed;
//   const CustomDateTime(
//       {super.key,
//       required this.label,
//       required this.icon,
//       required this.streamDate,
//       required this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<String>(
//         stream: streamDate,
//         builder: (context, snapshot) {
//           final selectedDate = snapshot.data;
//           final isCheck = selectedDate == null || selectedDate.isEmpty;
//           return InkWell(
//             onTap: onPressed,
//             child: Container(
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 borderRadius: Dimensions.kBorderRadiusAllSmallest,
//                 border: Border.all(
//                   color: AppColor.lightGrey,
//                   width: 1,
//                   strokeAlign: BorderSide.strokeAlignCenter,
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(left: 12, top: 12, bottom: 12).w,
//                     child: Text(
//                       isCheck ? label : selectedDate,
//                       style: context.textTheme.labelMedium?.copyWith(
//                           color: isCheck ? AppColor.grey : AppColor.black,
//                           fontWeight:
//                               isCheck ? FontWeight.normal : FontWeight.w500),
//                     ),
//                   ),
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 10, vertical: 12)
//                             .w,
//                     decoration: BoxDecoration(
//                       color: AppColor.lightGrey,
//                       borderRadius: BorderRadius.only(
//                         topRight: const Radius.circular(5).w,
//                         bottomRight: const Radius.circular(5).w,
//                       ),
//                     ),
//                     child: SvgPicture.asset(
//                       icon,
//                       width: 17.w,
//                       colorFilter: const ColorFilter.mode(
//                           AppColor.white, BlendMode.srcIn),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }
