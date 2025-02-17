import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../../../../app/app.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../dashboard/dashboard.dart';
import '../../../root/root.dart';
import '../../account.dart';

class AccountScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;

  const AccountScreen({super.key, required this.scaffold});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    initialCallBack();
  }

  void initialCallBack() {
    final token = SharedPrefs().getToken();
    BlocProvider.of<AttendanceStatusCubit>(context, listen: false)
        .getAttendanceStatus(token);
    BlocProvider.of<AccountDetailsCubit>(context).getAccountDetails();
  }

  Widget popupMenuItem(BuildContext context,
      {required String label, required IconData icon}) {
    return Row(
      children: [
        Icon(icon, size: 18, color: appColor.gray950),
        Dimensions.kHorizontalSpaceSmaller,
        Text(label, style: context.textTheme.labelLarge),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AttendanceStatusCubit, AttendanceStatusState>(
      listener: (context, state) {
        if (state is AttendanceStatusFailed) {
          if (state.message == "Invalid Token") {
            BlocProvider.of<AuthenticationBloc>(context, listen: false)
                .add(const LoggedOut());
            BlocProvider.of<NavigationCubit>(context)
                .getNavBarItem(NavbarItem.home);
          }
        }
      },
      child: Column(
        children: [
          SizedBox(
            height: 110.h,
            child: Container(
              padding: Dimensions.kPaddingAllMedium,
              width: context.deviceSize.width,
              decoration: BoxDecoration(color: appColor.brand800),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BlocBuilder<AccountDetailsCubit, AccountDetailsState>(
                    builder: (context, state) {
                      if (state is AccountDetailsLoading) {
                        return const AccountHeaderShimmerLoading();
                      }
                      if (state is AccountDetailsLoaded) {
                        final profile = state.profile.profile!;
                        final isCheckImageEmpty = SharedPrefs.instance
                                    .getString(AppKeys.profile) !=
                                "" &&
                            SharedPrefs.instance.getString(AppKeys.profile) !=
                                "null" &&
                            SharedPrefs.instance.getString(AppKeys.profile) !=
                                null;
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 42.w,
                              height: 42.h,
                              padding: const EdgeInsets.all(12).w,
                              decoration: BoxDecoration(
                                color:
                                    isCheckImageEmpty ? null : appColor.gray50,
                                borderRadius: Dimensions.kBorderRadiusAllLarge,
                                border: Border.all(
                                  color: appColor.white,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                ),
                                image: isCheckImageEmpty
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topCenter,
                                        image: NetworkImage(
                                            "${ApiUrl.baseUrl}/public/${profile.avatar}"))
                                    : null,
                              ),
                              child: isCheckImageEmpty
                                  ? null
                                  : SvgPicture.asset(
                                      AppSvg.accountFill,
                                      colorFilter: ColorFilter.mode(
                                          appColor.brand800, BlendMode.srcIn),
                                    ),
                            ),
                            Dimensions.kHorizontalSpaceSmall,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${profile.firstName ?? ''} ${profile.lastName ?? ''}",
                                  style: context.textTheme.titleLarge?.copyWith(
                                    color: appColor.white,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  profile.email ?? "",
                                  style:
                                      context.textTheme.labelMedium?.copyWith(
                                    color: appColor.white,
                                  ),
                                ),
                              ],
                            ),
                            Dimensions.kSpacer,
                            BlocBuilder<AccountDetailsCubit,
                                AccountDetailsState>(
                              builder: (context, state) {
                                return PopupMenuButton(
                                  iconColor: appColor.white,
                                  child: SvgPicture.asset(
                                    AppSvg.edit,
                                    colorFilter: ColorFilter.mode(
                                        appColor.white, BlendMode.srcIn),
                                    width: Dimensions.iconSizeSmaller,
                                  ),
                                  itemBuilder: (BuildContext bc) {
                                    return [
                                      if (state is AccountDetailsLoaded)
                                        PopupMenuItem(
                                          onTap: () => Navigator.pushNamed(
                                              context,
                                              AppRouterPath.profileEditScreen,
                                              arguments: ProfileEditScreen(
                                                  profile:
                                                      state.profile.profile!)),
                                          child: popupMenuItem(context,
                                              label: "Edit Profile Details",
                                              icon: Icons.edit),
                                        ),
                                      PopupMenuItem(
                                        onTap: onPickedProfilePhoto,
                                        child: popupMenuItem(context,
                                            label: "Set Profile Photo",
                                            icon: Icons.camera_alt_rounded),
                                      ),
                                    ];
                                  },
                                );
                              },
                            ),
                            Dimensions.kHorizontalSpaceMedium,
                            GestureDetector(
                              onTap: () =>
                                  widget.scaffold.currentState!.openDrawer(),
                              child: SvgPicture.asset(
                                AppSvg.menuFull,
                                colorFilter: ColorFilter.mode(
                                    appColor.white, BlendMode.srcIn),
                                width: Dimensions.iconSizeSmaller,
                              ),
                            ),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                accountProfileUI(),
                Dimensions.kVerticalSpaceSmall,
                subPageLinkCard(
                    label: 'Personal',
                    onPressed: () => Navigator.pushNamed(
                        context, AppRouterPath.profilePersonalDetailsScreen)),
                Dimensions.kVerticalSpaceSmallest,
                subPageLinkCard(
                    label: 'Contact',
                    onPressed: () => Navigator.pushNamed(
                        context, AppRouterPath.profileContactDetailsScreen)),
                Dimensions.kVerticalSpaceSmallest,
                subPageLinkCard(
                    label: 'Education',
                    onPressed: () => Navigator.pushNamed(
                        context, AppRouterPath.profileUpdateEducationScreen)),
                Dimensions.kVerticalSpaceSmallest,
                subPageLinkCard(
                    label: 'Experience',
                    onPressed: () => Navigator.pushNamed(
                        context, AppRouterPath.profileUpdateExperienceScreen)),
                Dimensions.kVerticalSpaceSmallest,
                subPageLinkCard(
                    label: 'Skills',
                    onPressed: () => Navigator.pushNamed(
                        context, AppRouterPath.profileUpdateSkillsScreen)),
                Dimensions.kVerticalSpaceSmallest,
                subPageLinkCard(
                    label: 'Training and Certification',
                    onPressed: () => Navigator.pushNamed(
                        context,
                        AppRouterPath
                            .profileUpdateTrainingCertificationScreen)),
                Dimensions.kVerticalSpaceSmallest,
                subPageLinkCard(
                    label: 'Visa and Immigration',
                    onPressed: () => Navigator.pushNamed(context,
                        AppRouterPath.profileUpdateVisaImmigrationScreen)),
                Dimensions.kVerticalSpaceSmallest,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget accountProfileUI() {
    return BlocBuilder<AccountDetailsCubit, AccountDetailsState>(
      builder: (context, state) {
        if (state is AccountDetailsLoading) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: Dimensions.kPaddingAllMedium,
                decoration: BoxDecoration(color: appColor.white),
                width: context.deviceSize.width,
                child: ShimmerWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account',
                        style: context.textTheme.titleLarge
                            ?.copyWith(color: appColor.brand900),
                      ),
                      Dimensions.kVerticalSpaceSmallest,
                      Container(
                        width: 160.w,
                        height: 16.h,
                        color: appColor.gray200.withOpacity(.5),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "Employee Number",
                        style: context.textTheme.labelSmall
                            ?.copyWith(color: appColor.gray700),
                      ),
                      SizedBox(height: 4.h),
                      Divider(color: appColor.brand900.withOpacity(.5)),
                      SizedBox(height: 4.h),
                      Container(
                        width: 160.w,
                        height: 16.h,
                        color: appColor.gray600.withOpacity(.5),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "Phone number",
                        style: context.textTheme.labelSmall
                            ?.copyWith(color: appColor.gray700),
                      ),
                      SizedBox(height: 4.h),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        if (state is AccountDetailsLoaded) {
          final profile = state.profile.profile!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: Dimensions.kPaddingAllMedium,
                decoration: BoxDecoration(color: appColor.white),
                width: context.deviceSize.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account',
                      style: context.textTheme.titleLarge
                          ?.copyWith(color: appColor.brand900),
                    ),
                    Dimensions.kVerticalSpaceSmallest,
                    Text(
                      profile.employeeNumber ?? "",
                      style: context.textTheme.labelLarge,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      "Employee Number",
                      style: context.textTheme.labelSmall
                          ?.copyWith(color: appColor.gray700),
                    ),
                    SizedBox(height: 4.h),
                    Divider(color: appColor.brand900.withOpacity(.1)),
                    SizedBox(height: 4.h),
                    Text(
                      profile.email ?? "",
                      style: context.textTheme.labelLarge,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      "Email",
                      style: context.textTheme.labelSmall
                          ?.copyWith(color: appColor.gray700),
                    ),
                    SizedBox(height: 4.h),
                    Divider(color: appColor.brand900.withOpacity(.1)),
                    SizedBox(height: 4.h),
                    Text(
                      "+91 ${profile.workTelephoneNumber}",
                      style: context.textTheme.labelLarge,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      "Phone number",
                      style: context.textTheme.labelSmall
                          ?.copyWith(color: appColor.gray700),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        if (state is AccountDetailsFailed) {
          return Container();
        }

        return Container();
      },
    );
  }

  Widget subPageLinkCard(
      {required String label, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16).w,
        decoration: BoxDecoration(color: appColor.white),
        width: context.deviceSize.width,
        child: Row(
          children: [
            Text(label,
                style: context.textTheme.labelLarge
                    ?.copyWith(color: appColor.gray700)),
            Dimensions.kSpacer,
            Icon(Icons.arrow_forward_ios_rounded,
                size: 16, color: appColor.gray700),
          ],
        ),
      ),
    );
  }

  labelActionButton({required VoidCallback onPressed, required String label}) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Text(label, style: context.textTheme.labelLarge),
          Dimensions.kSpacer,
          const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        ],
      ),
    );
  }

  void onTapLogoutButton() {
    AppAlerts.displayLogoutAlert(
      context: context,
      onPressed: () {
        BlocProvider.of<AuthenticationBloc>(context, listen: false)
            .add(const LoggedOut());
        BlocProvider.of<NavigationCubit>(context)
            .getNavBarItem(NavbarItem.home);
        Navigator.of(context).pop();
      },
    );
  }

  onPickedProfilePhoto() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) profileEditPhoto(image);
  }

  profileEditPhoto(XFile image) {
    showModalBottomSheet(
            showDragHandle: false,
            enableDrag: false,
            isDismissible: false,
            isScrollControlled: true,
            context: context,
            builder: (_) => ImageEditScreen(image: image))
        .then((value) => initialCallBack());
  }
}

class AccountHeaderShimmerLoading extends StatelessWidget {
  const AccountHeaderShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 42.w,
            height: 42.h,
            padding: const EdgeInsets.all(12).w,
            decoration: BoxDecoration(
              color: appColor.gray300,
              borderRadius: Dimensions.kBorderRadiusAllLarge,
            ),
            child: SvgPicture.asset(
              AppSvg.accountFill,
              colorFilter: ColorFilter.mode(appColor.gray300, BlendMode.srcIn),
            ),
          ),
          Dimensions.kHorizontalSpaceSmall,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 160.w,
                height: 16.h,
                color: appColor.gray300.withOpacity(.5),
              ),
              SizedBox(height: 2.h),
              Container(
                width: 160.w,
                height: 16.h,
                color: appColor.gray300.withOpacity(.5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ImageEditScreen extends StatefulWidget {
  final XFile image;

  const ImageEditScreen({super.key, required this.image});

  @override
  State<ImageEditScreen> createState() => _ImageEditScreenState();
}

class _ImageEditScreenState extends State<ImageEditScreen> {
  XFile? _pickedFile;
  CroppedFile? _croppedFile;

  @override
  void initState() {
    super.initState();
    _pickedFile = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountCrudBloc, AccountCrudState>(
      listener: (context, state) {
        if (state is AccountCrudSuccess) {
          Navigator.pop(context);

          AppAlerts.displaySnackBar(
              context, "Profile Uploaded Successfully", true);
        }
        if (state is AccountCrudFailed) {
          Navigator.pop(context);
          AppAlerts.displaySnackBar(context, "Profile Upload Failed", false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: _buildBoyUI(),
          backgroundColor: appColor.gray950.withOpacity(.8),
          bottomNavigationBar: Container(
            height: 70.h,
            padding: Dimensions.kPaddingAllMedium,
            color: appColor.gray950,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _clear,
                  icon: Icon(Icons.delete, color: appColor.white),
                ),
                IconButton(
                  onPressed: _cropImage,
                  icon: Icon(Icons.crop, color: appColor.white),
                ),
                Dimensions.kSpacer,
                if (_croppedFile != null)
                  state is AccountCrudLoading
                      ? const CircularProgressIndicator()
                      : TextButton(
                          onPressed: onSubmit, child: const Text('Done')),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBoyUI() {
    if (_croppedFile != null || _pickedFile != null) {
      return _imageCard();
    } else {
      return _uploaderCard();
    }
  }

  Widget _imageCard() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(alignment: Alignment.center, child: _image()),
        if (_croppedFile == null)
          Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 10).w,
                decoration: BoxDecoration(
                  color: appColor.white,
                  borderRadius: Dimensions.kBorderRadiusAllMedium,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_rounded,
                      color: appColor.warning600,
                      size: 20.w,
                    ),
                    Dimensions.kHorizontalSpaceSmaller,
                    RichText(
                      text: TextSpan(
                        style: context.textTheme.labelMedium,
                        children: [
                          const TextSpan(text: "Please crop your image"),
                          TextSpan(
                            text: ' "1:1 AspectRatio" \n',
                            style: context.textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                          const TextSpan(
                              text: "then you can update profile image"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _image() {
    if (_croppedFile != null) {
      final path = _croppedFile!.path;
      return Image.file(File(path), fit: BoxFit.contain);
    } else if (_pickedFile != null) {
      final path = _pickedFile!.path;
      return Image.file(File(path), fit: BoxFit.contain);
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _uploaderCard() {
    return Center(
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SizedBox(
          width: 320.0,
          height: 300.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DottedBorder(
                    radius: const Radius.circular(12.0),
                    borderType: BorderType.RRect,
                    dashPattern: const [8, 4],
                    color: Theme.of(context).highlightColor.withOpacity(0.4),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: Theme.of(context).highlightColor,
                            size: 80.0,
                          ),
                          const SizedBox(height: 24.0),
                          Text(
                            'Upload an image to start',
                            style: context.textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).highlightColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: ElevatedButton(
                    onPressed: _uploadImage, child: const Text('Upload')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _cropImage() async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: appColor.brand800,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            hideBottomControls: true,
            lockAspectRatio: true,
          ),
          IOSUiSettings(title: 'Cropper', hidesNavigationBar: true),
        ],
      );
      if (croppedFile != null) setState(() => _croppedFile = croppedFile);
    }
  }

  Future<void> _uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) setState(() => _pickedFile = pickedFile);
  }

  void _clear() {
    setState(() {
      _pickedFile = null;
      _croppedFile = null;
    });
  }

  void onSubmit() {
    final profileUpload = ProfileUploadEvent(body: {
      "profile_upload":
          base64.encode(File(_croppedFile!.path).readAsBytesSync())
    });

    Logger().i("Submit: $profileUpload");

    BlocProvider.of<AccountCrudBloc>(context).add(profileUpload);
  }
}
