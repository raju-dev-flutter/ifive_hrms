part of 'theme.dart';

@immutable
class Dimensions {
  //padding
  static final kPaddingAllLargest = const EdgeInsets.all(50.0).w;
  static final kPaddingAllLarger = const EdgeInsets.all(30.0).w;
  static final kPaddingAllLarge = const EdgeInsets.all(20.0).w;
  static final kPaddingAllMedium = const EdgeInsets.all(16.0).w;
  static final kPaddingAllSmall = const EdgeInsets.all(12.0).w;
  static final kPaddingAllSmaller = const EdgeInsets.all(8.0).w;
  static final kPaddingAllSmallest = const EdgeInsets.all(4.0).w;
  static const kPaddingZero = EdgeInsets.zero;

  //BorderRadius
  static final kBorderRadiusAllLargest = BorderRadius.circular(50).w;
  static final kBorderRadiusAllLarger = BorderRadius.circular(30).w;
  static final kBorderRadiusAllLarge = BorderRadius.circular(20).w;
  static final kBorderRadiusAllMedium = BorderRadius.circular(16).w;
  static final kBorderRadiusAllSmall = BorderRadius.circular(12).w;
  static final kBorderRadiusAllSmaller = BorderRadius.circular(8).w;
  static final kBorderRadiusAllSmallest = BorderRadius.circular(4).w;

  static final kRadiusAllSmallest = const Radius.circular(6).w;

  //VerticalSpace
  static final kVerticalSpaceLargest = SizedBox(height: 30.w);
  static final kVerticalSpaceLarger = SizedBox(height: 24.w);
  static final kVerticalSpaceLarge = SizedBox(height: 20.w);
  static final kVerticalSpaceMedium = SizedBox(height: 16.w);
  static final kVerticalSpaceSmall = SizedBox(height: 12.w);
  static final kVerticalSpaceSmaller = SizedBox(height: 8.w);
  static final kVerticalSpaceSmallest = SizedBox(height: 4.w);

  //Horizontal Space
  static final kHorizontalSpaceLargest = SizedBox(width: 30.w);
  static final kHorizontalSpaceLarger = SizedBox(width: 24.w);
  static final kHorizontalSpaceLarge = SizedBox(width: 20.w);
  static final kHorizontalSpaceMedium = SizedBox(width: 16.w);
  static final kHorizontalSpaceSmall = SizedBox(width: 12.w);
  static final kHorizontalSpaceSmaller = SizedBox(width: 8.w);
  static final kHorizontalSpaceSmallest = SizedBox(width: 4.w);

  // Size
  static final double iconSizeLargest = 80.h;
  static final double iconSizeLarger = 48.h;
  static final double iconSizeLarge = 36.h;
  static final double iconSizeMedium = 30.h;
  static final double iconSizeSmall = 24.h;
  static final double iconSizeSmaller = 18.h;
  static final double iconSizeSmallest = 16.h;

  static final double sizeLargest = 50.h;
  static final double sizeLarger = 20.h;
  static final double sizeLarge = 18.h;
  static final double sizeMedium = 16.h;
  static final double sizeSmall = 12.h;
  static final double sizeSmaller = 8.h;
  static final double sizeSmallest = 4.h;

  static final double kAuthorTextFieldSize = 35.h;

  static const kSpacer = Spacer();

  static const kDivider = Divider(height: 0);

  static const kSizedBox = SizedBox();
}
