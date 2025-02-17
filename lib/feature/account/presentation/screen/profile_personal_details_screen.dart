import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../account.dart';

class ProfilePersonalDetailsScreen extends StatelessWidget {
  const ProfilePersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor.gray50,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: "Personal Details",
          actions: [
            BlocBuilder<AccountDetailsCubit, AccountDetailsState>(
                builder: (context, state) {
              if (state is AccountDetailsLoading) {}
              if (state is AccountDetailsLoaded) {
                final personal = state.profile.personal;
                if (personal == null) {
                  return IconButton(
                    onPressed: () => Navigator.pushNamed(
                        context, AppRouterPath.profileUpdatePersonalScreen,
                        arguments: const ProfileUpdatePersonalScreen()),
                    padding: Dimensions.kPaddingAllSmall,
                    icon: Icon(Icons.add, color: appColor.gray600),
                  );
                }
                return IconButton(
                  onPressed: () => Navigator.pushNamed(
                      context, AppRouterPath.profileUpdatePersonalScreen,
                      arguments:
                          ProfileUpdatePersonalScreen(personal: personal)),
                  padding: Dimensions.kPaddingAllSmall,
                  icon: Icon(Icons.edit, color: appColor.gray600),
                );
              }
              return Container();
            }),
          ],
        ),
      ),
      body: _$BuildBodyUI(),
    );
  }

  _$BuildBodyUI() {
    return SingleChildScrollView(
      child: BlocBuilder<AccountDetailsCubit, AccountDetailsState>(
        builder: (context, state) {
          if (state is AccountDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AccountDetailsLoaded) {
            final personal = state.profile.personal;
            if (personal == null) {
              return Container(
                  height: context.deviceSize.height * 0.8,
                  alignment: Alignment.center,
                  child: Center(child: EmptyScreen(onPressed: () async {
                    BlocProvider.of<AccountDetailsCubit>(context)
                        .getAccountDetails();
                  })));
            }
            return _$ContactDetailsCardUI(context, personal);
          }
          if (state is AccountDetailsFailed) {
            return Center(child: EmptyScreen(onPressed: () async {
              BlocProvider.of<AccountDetailsCubit>(context).getAccountDetails();
            }));
          }
          return Container();
        },
      ),
    );
  }

  _$ContactDetailsCardUI(BuildContext context, Personal personal) {
    return Padding(
      padding: Dimensions.kPaddingAllMedium,
      child: Column(
        children: [
          _$PersonalInformationCardUI(context, personal),
          Dimensions.kVerticalSpaceSmaller,
          _$AdditionalInformationCardUI(context, personal),
          Dimensions.kVerticalSpaceSmaller,
          _$LanguageCardUI(context, personal),
          Dimensions.kVerticalSpaceSmaller,
          _$FamilyInformationCardUI(context, personal),
        ],
      ),
    );
  }

  _$PersonalInformationCardUI(BuildContext context, Personal personal) {
    return Container(
      padding: Dimensions.kPaddingAllMedium,
      width: context.deviceSize.width,
      decoration: BoxDecoration(
        color: appColor.white,
        borderRadius: BorderRadius.circular(8).w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal Information',
            style: context.textTheme.headlineSmall,
          ),
          Dimensions.kVerticalSpaceSmaller,
          Text(
            personal.genderName ?? "",
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "gender",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray600),
          ),
          SizedBox(height: 4.h),
          Divider(color: appColor.brand900.withOpacity(.1)),
          SizedBox(height: 4.h),
          Text(
            personal.maritalStatusName ?? '',
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Marital Status",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray600),
          ),
          SizedBox(height: 4.h),
          Divider(color: appColor.brand900.withOpacity(.1)),
          SizedBox(height: 4.h),
          Text(
            personal.nationalityName ?? '',
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Nationality",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray600),
          ),
          SizedBox(height: 4.h),
          Divider(color: appColor.brand900.withOpacity(.1)),
          SizedBox(height: 4.h),
          Text(
            personal.dateOfBirth ?? "",
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Date of Birth",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray600),
          ),
          SizedBox(height: 4.h),
          Divider(color: appColor.brand900.withOpacity(.1)),
          SizedBox(height: 4.h),
          Text(
            (personal.age ?? '').toString(),
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Age",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray600),
          ),
        ],
      ),
    );
  }

  _$AdditionalInformationCardUI(BuildContext context, Personal personal) {
    return Container(
      padding: Dimensions.kPaddingAllMedium,
      width: context.deviceSize.width,
      decoration: BoxDecoration(
        color: appColor.white,
        borderRadius: BorderRadius.circular(8).w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Additional Information",
            style: context.textTheme.headlineSmall,
          ),
          Dimensions.kVerticalSpaceSmaller,
          Text(
            personal.bloodGroupName ?? "",
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Blood Group",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray600),
          ),
          SizedBox(height: 4.h),
          Divider(color: appColor.brand900.withOpacity(.1)),
          SizedBox(height: 4.h),
          Text(
            personal.personalMail ?? "",
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Personal E-Mail",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray600),
          ),
          SizedBox(height: 4.h),
          Divider(color: appColor.brand900.withOpacity(.1)),
          SizedBox(height: 4.h),
          Text(
            personal.personalMobile ?? '',
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Personal Contact ",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray600),
          ),
          SizedBox(height: 4.h),
          Divider(color: appColor.brand900.withOpacity(.1)),
          SizedBox(height: 4.h),
          Text(
            personal.motherTongueName ?? '',
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Mother Tongue",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray600),
          ),
        ],
      ),
    );
  }

  _$LanguageCardUI(BuildContext context, Personal personal) {
    List<dynamic> language = jsonDecode(personal.language ?? '[]');
    return Container(
      padding: Dimensions.kPaddingAllMedium,
      width: context.deviceSize.width,
      decoration: BoxDecoration(
        color: appColor.white,
        borderRadius: BorderRadius.circular(8).w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Language',
            style: context.textTheme.headlineSmall,
          ),
          Dimensions.kVerticalSpaceSmall,
          for (var i = 0; i < language.length; i++) ...[
            Container(
              padding: Dimensions.kPaddingAllMedium,
              width: context.deviceSize.width,
              decoration: BoxDecoration(
                color: appColor.gray50,
                borderRadius: BorderRadius.circular(8).w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    language[i][0] ?? "",
                    style: context.textTheme.labelLarge,
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "Language Name",
                    style: context.textTheme.labelSmall
                        ?.copyWith(color: appColor.gray600),
                  ),
                  SizedBox(height: 2.h),
                  Divider(color: appColor.brand900.withOpacity(.1)),
                  SizedBox(height: 2.h),
                  Text(
                    "${language[i][1] ?? ""}, ${language[i][2] ?? ""}, ${language[i][3] ?? ""}",
                    style: context.textTheme.labelLarge,
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "Language Level",
                    style: context.textTheme.labelSmall
                        ?.copyWith(color: appColor.gray600),
                  ),
                ],
              ),
            ),
            language.length - 1 == i
                ? Dimensions.kSizedBox
                : Dimensions.kVerticalSpaceSmall,
          ],
        ],
      ),
    );
  }

  _$FamilyInformationCardUI(BuildContext context, Personal personal) {
    return Container(
      padding: Dimensions.kPaddingAllMedium,
      width: context.deviceSize.width,
      decoration: BoxDecoration(
        color: appColor.white,
        borderRadius: BorderRadius.circular(8).w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Family Information",
            style: context.textTheme.headlineSmall,
          ),
          Dimensions.kVerticalSpaceSmaller,
          Text(
            personal.fatherName ?? "",
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Father Name",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray600),
          ),
          SizedBox(height: 4.h),
          Divider(color: appColor.brand900.withOpacity(.1)),
          SizedBox(height: 4.h),
          Text(
            personal.fatherAadharNumber ?? "",
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Father Aadhaar Number",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray600),
          ),
          SizedBox(height: 4.h),
          Divider(color: appColor.brand900.withOpacity(.1)),
          SizedBox(height: 4.h),
          Text(
            personal.fatherDob ?? '',
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Father Date of birth",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray600),
          ),
          SizedBox(height: 4.h),
          Divider(color: appColor.brand900.withOpacity(.1)),
          SizedBox(height: 4.h),
          Text(
            (personal.fatherAge ?? 0).toString(),
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Father Age",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray600),
          ),
          SizedBox(height: 4.h),
          Divider(color: appColor.brand900.withOpacity(.1)),
          SizedBox(height: 4.h),
          Text(
            personal.motherName ?? "",
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Mother Name",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray600),
          ),
          SizedBox(height: 4.h),
          Divider(color: appColor.brand900.withOpacity(.1)),
          SizedBox(height: 4.h),
          Text(
            personal.motherAadharNumber ?? "",
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Mother Aadhaar Number",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray600),
          ),
          SizedBox(height: 4.h),
          Divider(color: appColor.brand900.withOpacity(.1)),
          SizedBox(height: 4.h),
          Text(
            personal.motherDob ?? '',
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Mother Date of birth",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray600),
          ),
          SizedBox(height: 4.h),
          Divider(color: appColor.brand900.withOpacity(.1)),
          SizedBox(height: 4.h),
          Text(
            (personal.motherAge ?? 0).toString(),
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Mother Age",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray600),
          ),
        ],
      ),
    );
  }
}
