import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../account.dart';

class ProfileContactDetailsScreen extends StatelessWidget {
  const ProfileContactDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor.gray50,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: "Contact Details",
          actions: [
            BlocBuilder<AccountDetailsCubit, AccountDetailsState>(
                builder: (context, state) {
              if (state is AccountDetailsLoading) {}
              if (state is AccountDetailsLoaded) {
                final contact = state.profile.contact;
                if (contact == null) {
                  return IconButton(
                    onPressed: () => Navigator.pushNamed(
                        context, AppRouterPath.profileUpdateContactScreen,
                        arguments: const ProfileUpdateContactScreen()),
                    icon: Icon(Icons.add, color: appColor.gray600),
                  );
                }
                return IconButton(
                  onPressed: () => Navigator.pushNamed(
                      context, AppRouterPath.profileUpdateContactScreen,
                      arguments: ProfileUpdateContactScreen(contact: contact)),
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
          if (state is AccountDetailsLoading) {}
          if (state is AccountDetailsLoaded) {
            final contact = state.profile.contact;
            if (contact == null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                // height: context.deviceSize.height * 0.8,
                // alignment: Alignment.center,
                children: [
                  Lottie.asset(AppLottie.empty, width: 250.w),
                ],
              );
            }
            return _$ContactDetailsCardUI(context, contact);
          }
          return Container();
        },
      ),
    );
  }

  _$ContactDetailsCardUI(BuildContext context, Contact contact) {
    return Padding(
      padding: Dimensions.kPaddingAllMedium,
      child: Column(
        children: [
          _$PermanentAddressCardUI(context, contact),
          Dimensions.kVerticalSpaceSmaller,
          _$CurrentAddressCardUI(context, contact),
          Dimensions.kVerticalSpaceSmaller,
          _$EmergencyContactsCardUI(context, contact),
        ],
      ),
    );
  }

  _$PermanentAddressCardUI(BuildContext context, Contact contact) {
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
            'Permanent Address',
            style: context.textTheme.headlineSmall,
          ),
          Dimensions.kVerticalSpaceSmaller,
          Text(
            contact.permanentFlatNo ?? "",
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Flat No",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray700),
          ),
          SizedBox(height: 4.h),
          Divider(color: appColor.brand900.withOpacity(.1)),
          SizedBox(height: 4.h),
          Text(
            contact.permanentStreet ?? '',
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Street ",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray700),
          ),
          SizedBox(height: 4.h),
          Divider(color: appColor.brand900.withOpacity(.1)),
          SizedBox(height: 4.h),
          Text(
            contact.permanentStreetAddress ?? '',
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Address ",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray700),
          ),
          SizedBox(height: 4.h),
          Divider(color: appColor.brand900.withOpacity(.1)),
          SizedBox(height: 4.h),
          Text(
            "${contact.permanentCityName ?? ''}, ${contact.permanentStateName ?? ''}, ${contact.permanentCountryName ?? ''}",
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "City, State, Country",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray700),
          ),
          SizedBox(height: 4.h),
          Divider(color: appColor.brand900.withOpacity(.1)),
          SizedBox(height: 4.h),
          Text(
            (contact.permanentPostalCode ?? '').toString(),
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Postal Code",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray700),
          ),
        ],
      ),
    );
  }

  _$CurrentAddressCardUI(BuildContext context, Contact contact) {
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
            'Current Address',
            style: context.textTheme.headlineSmall,
          ),
          Dimensions.kVerticalSpaceSmaller,
          Text(
            contact.currentFlatNo ?? "",
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Flat No",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray700),
          ),
          SizedBox(height: 4.h),
          Divider(color: appColor.brand900.withOpacity(.1)),
          SizedBox(height: 4.h),
          Text(
            contact.currentStreet ?? '',
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Street ",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray700),
          ),
          SizedBox(height: 4.h),
          Divider(color: appColor.brand900.withOpacity(.1)),
          SizedBox(height: 4.h),
          Text(
            contact.currentStreetAddress ?? '',
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Address ",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray700),
          ),
          SizedBox(height: 4.h),
          Divider(color: appColor.brand900.withOpacity(.1)),
          SizedBox(height: 4.h),
          Text(
            "${contact.currentCityName ?? ''}, ${contact.currentStateName ?? ''}, ${contact.currentCountryName ?? ''}",
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "City, State, Country",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray700),
          ),
          SizedBox(height: 4.h),
          Divider(color: appColor.brand900.withOpacity(.1)),
          SizedBox(height: 4.h),
          Text(
            (contact.currentPostalCode ?? '').toString(),
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            "Postal Code",
            style:
                context.textTheme.labelSmall?.copyWith(color: appColor.gray700),
          ),
        ],
      ),
    );
  }

  _$EmergencyContactsCardUI(BuildContext context, Contact contact) {
    List<dynamic> emergencyContact =
        jsonDecode(contact.emergencyContacts ?? '[]');
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
            'Emergency Contacts',
            style: context.textTheme.headlineSmall,
          ),
          Dimensions.kVerticalSpaceSmall,
          for (var contact in emergencyContact) ...[
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
                    contact[0] ?? "",
                    style: context.textTheme.labelLarge,
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "Name",
                    style: context.textTheme.labelSmall
                        ?.copyWith(color: appColor.gray700),
                  ),
                  SizedBox(height: 2.h),
                  Divider(color: appColor.brand900.withOpacity(.1)),
                  SizedBox(height: 2.h),
                  Text(
                    contact[1] ?? "",
                    style: context.textTheme.labelLarge,
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "Relation Type",
                    style: context.textTheme.labelSmall
                        ?.copyWith(color: appColor.gray700),
                  ),
                  SizedBox(height: 2.h),
                  Divider(color: appColor.brand900.withOpacity(.1)),
                  SizedBox(height: 2.h),
                  Text(
                    contact[3] ?? "",
                    style: context.textTheme.labelLarge,
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "Contact Number",
                    style: context.textTheme.labelSmall
                        ?.copyWith(color: appColor.gray700),
                  ),
                  SizedBox(height: 2.h),
                  Divider(color: appColor.brand900.withOpacity(.1)),
                  SizedBox(height: 2.h),
                  Text(
                    contact[2] ?? "",
                    style: context.textTheme.labelLarge,
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "Address",
                    style: context.textTheme.labelSmall
                        ?.copyWith(color: appColor.gray700),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
          ],
        ],
      ),
    );
  }
}
