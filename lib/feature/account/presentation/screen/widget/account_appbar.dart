// import 'dart:convert';
// import 'dart:io';
//
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:logger/logger.dart';
//
// import '../../../../../config/config.dart';
// import '../../../../../core/core.dart';
// import '../../../account.dart';
//
// class AccountAppBar extends StatefulWidget {
//   final VoidCallback onPressed;
//
//   const AccountAppBar({super.key, required this.onPressed});
//
//   @override
//   State<AccountAppBar> createState() => _AccountAppBarState();
// }
//
// class _AccountAppBarState extends State<AccountAppBar> {
//   @override
//   void initState() {
//     super.initState();
//
//     initialCallBack();
//   }
//
//   void initialCallBack() {
//     BlocProvider.of<AccountDetailsCubit>(context).getAccountDetails();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: appColor.gray100,
//       leading: Padding(
//         padding: const EdgeInsets.all(16).w,
//         child: InkWell(
//           onTap: widget.onPressed,
//           child: SvgPicture.asset(AppSvg.menu),
//         ),
//       ),
//       centerTitle: true,
//       title: Image(image: const AssetImage(AppIcon.ifiveLogo), width: 46.w),
//       actions: [
//         BlocBuilder<AccountDetailsCubit, AccountDetailsState>(
//           builder: (context, state) {
//             return PopupMenuButton(
//               iconColor: appColor.gray800,
//               itemBuilder: (BuildContext bc) {
//                 return [
//                   if (state is AccountDetailsLoaded)
//                     PopupMenuItem(
//                       onTap: () => Navigator.pushNamed(
//                           context, AppRouterPath.profileEditScreen,
//                           arguments: ProfileEditScreen(
//                               profile: state.profile.profile!.first)),
//                       child: popupMenuItem(context,
//                           label: "Edit Profile Details", icon: Icons.edit),
//                     ),
//                   PopupMenuItem(
//                     onTap: onPickedProfilePhoto,
//                     child: popupMenuItem(context,
//                         label: "Set Profile Photo",
//                         icon: Icons.camera_alt_rounded),
//                   ),
//                 ];
//               },
//             );
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget popupMenuItem(BuildContext context,
//       {required String label, required IconData icon}) {
//     return Row(
//       children: [
//         Icon(icon, size: 18, color: appColor.gray950),
//         Dimensions.kHorizontalSpaceSmaller,
//         Text(label, style: context.textTheme.labelLarge),
//       ],
//     );
//   }
//
//   onPickedProfilePhoto() async {
//     final ImagePicker picker = ImagePicker();
//
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       profileEditPhoto(image);
//     }
//   }
//
//   profileEditPhoto(XFile image) {
//     showModalBottomSheet(
//             showDragHandle: false,
//             enableDrag: false,
//             isDismissible: false,
//             isScrollControlled: true,
//             context: context,
//             builder: (_) => ImageEditScreen(image: image))
//         .then((value) => initialCallBack());
//   }
// }
//
// class ImageEditScreen extends StatefulWidget {
//   final XFile image;
//
//   const ImageEditScreen({super.key, required this.image});
//
//   @override
//   State<ImageEditScreen> createState() => _ImageEditScreenState();
// }
//
// class _ImageEditScreenState extends State<ImageEditScreen> {
//   XFile? _pickedFile;
//   CroppedFile? _croppedFile;
//
//   @override
//   void initState() {
//     super.initState();
//     _pickedFile = widget.image;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AccountCrudBloc, AccountCrudState>(
//       listener: (context, state) {
//         if (state is AccountCrudSuccess) {
//           Navigator.pop(context);
//
//           AppAlerts.displaySnackBar(
//               context, "Profile Uploaded Successfully", true);
//         }
//         if (state is AccountCrudFailed) {
//           Navigator.pop(context);
//           AppAlerts.displaySnackBar(context, "Profile Upload Failed", false);
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           body: _buildBoyUI(),
//           backgroundColor: appColor.gray950.withOpacity(.8),
//           bottomNavigationBar: Container(
//             height: 70.h,
//             padding: Dimensions.kPaddingAllMedium,
//             color: appColor.gray950,
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   onPressed: _clear,
//                   icon: Icon(Icons.delete, color: appColor.brand300),
//                 ),
//                 IconButton(
//                   onPressed: _cropImage,
//                   icon: Icon(Icons.crop, color: appColor.brand300),
//                 ),
//                 Dimensions.kSpacer,
//                 if (_croppedFile != null)
//                   state is AccountCrudLoading
//                       ? const CircularProgressIndicator()
//                       : TextButton(
//                           onPressed: onSubmit, child: const Text('Done')),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildBoyUI() {
//     if (_croppedFile != null || _pickedFile != null) {
//       return _imageCard();
//     } else {
//       return _uploaderCard();
//     }
//   }
//
//   Widget _imageCard() {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(alignment: Alignment.center, child: _image()),
//         if (_croppedFile == null)
//           Positioned(
//             bottom: 0,
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 4, horizontal: 10).w,
//                 decoration: BoxDecoration(
//                   color: appColor.gray100,
//                   borderRadius: Dimensions.kBorderRadiusAllMedium,
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.info_rounded,
//                       color: appColor.warning600,
//                       size: 20.w,
//                     ),
//                     Dimensions.kHorizontalSpaceSmaller,
//                     RichText(
//                       text: TextSpan(
//                         style: context.textTheme.labelMedium,
//                         children: [
//                           const TextSpan(text: "Please crop your image"),
//                           TextSpan(
//                             text: ' "1:1 AspectRatio" \n',
//                             style: context.textTheme.labelMedium?.copyWith(
//                                 fontWeight: FontWeight.bold,
//                                 fontStyle: FontStyle.italic),
//                           ),
//                           const TextSpan(
//                               text: "then you can update profile image"),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
//
//   Widget _image() {
//     if (_croppedFile != null) {
//       final path = _croppedFile!.path;
//       return Image.file(File(path), fit: BoxFit.contain);
//     } else if (_pickedFile != null) {
//       final path = _pickedFile!.path;
//       return Image.file(File(path), fit: BoxFit.contain);
//     } else {
//       return const SizedBox.shrink();
//     }
//   }
//
//   Widget _uploaderCard() {
//     return Center(
//       child: Card(
//         elevation: 4.0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.0),
//         ),
//         child: SizedBox(
//           width: 320.0,
//           height: 300.0,
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: DottedBorder(
//                     radius: const Radius.circular(12.0),
//                     borderType: BorderType.RRect,
//                     dashPattern: const [8, 4],
//                     color: Theme.of(context).highlightColor.withOpacity(0.4),
//                     child: Center(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.image,
//                             color: Theme.of(context).highlightColor,
//                             size: 80.0,
//                           ),
//                           const SizedBox(height: 24.0),
//                           Text(
//                             'Upload an image to start',
//                             style: context.textTheme.bodyMedium!.copyWith(
//                                 color: Theme.of(context).highlightColor),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 24.0),
//                 child: ElevatedButton(
//                   onPressed: _uploadImage,
//                   child: const Text('Upload'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _cropImage() async {
//     if (_pickedFile != null) {
//       final croppedFile = await ImageCropper().cropImage(
//         sourcePath: _pickedFile!.path,
//         compressFormat: ImageCompressFormat.jpg,
//         compressQuality: 100,
//         uiSettings: [
//           AndroidUiSettings(
//             toolbarTitle: 'Cropper',
//             toolbarColor: appColor.brand600,
//             toolbarWidgetColor: Colors.white,
//             initAspectRatio: CropAspectRatioPreset.square,
//             hideBottomControls: true,
//             lockAspectRatio: true,
//           ),
//           IOSUiSettings(
//             title: 'Cropper',
//             hidesNavigationBar: true,
//           ),
//         ],
//       );
//       if (croppedFile != null) {
//         setState(() => _croppedFile = croppedFile);
//       }
//     }
//   }
//
//   Future<void> _uploadImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _pickedFile = pickedFile;
//       });
//     }
//   }
//
//   void _clear() {
//     setState(() {
//       _pickedFile = null;
//       _croppedFile = null;
//     });
//   }
//
//   void onSubmit() {
//     final profileUpload = ProfileUploadEvent(body: {
//       "profile_upload":
//           base64.encode(File(_croppedFile!.path).readAsBytesSync())
//     });
//
//     Logger().i("Submit: $profileUpload");
//
//     BlocProvider.of<AccountCrudBloc>(context).add(profileUpload);
//   }
// }
