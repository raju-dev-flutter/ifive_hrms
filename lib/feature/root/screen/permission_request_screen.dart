import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/app.dart';
import '../../../config/config.dart';
import '../../../core/core.dart';
import '../root.dart';

class PermissionRequestScreen extends StatelessWidget {
  const PermissionRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor.white,
      body: BlocConsumer<PermissionCubit, PermissionState>(
        listener: (context, state) {
          if (state is AllPermissionsGranted) {
            BlocProvider.of<AuthenticationBloc>(context, listen: false)
                .add(const AppPermission(permission: true));
          }
        },
        listenWhen: (previous, current) {
          return (current is AllPermissionsGranted);
        },
        builder: (context, state) {
          // var authenticationBloc =
          //     BlocProvider.of<AuthenticationBloc>(context, listen: false);
          var permissionCubit = context.watch<PermissionCubit>();
          permissionCubit.checkIfPermissionNeeded();
          if (state is AllPermissionsGranted || state is WaitingForPermission) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'OK! ',
                      style: context.textTheme.headlineLarge
                          ?.copyWith(color: appColor.success600),
                      children: [
                        TextSpan(
                          text: 'we need some access!',
                          style: context.textTheme.headlineLarge,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
                  resourceConstants(
                    context: context,
                    svg: AppSvg.location,
                    title: "Location Permission",
                    description:
                        "EXHILAR collects location data to enable location even when the app is Always in use. This background permission is required for attendance menu in our application we fetch the details for manage user location.",
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 60),
                  InkWell(
                    onTap: () async {
                      if (state.permissionRepository.isGranted == true) {
                        // BlocProvider.of<AuthenticationBloc>(context,
                        //         listen: false)
                        //     .add(const AppPermission(permission: true));
                        // debugPrint(
                        //     "=============| Permission : ${state.permissionRepository.isGranted.toString()} |=============");
                      } else {
                        return await permissionCubit.onRequestAllPermission();
                      }
                    },
                    borderRadius: Dimensions.kBorderRadiusAllLarger,
                    child: Container(
                      height: 58,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: appColor.success100,
                        borderRadius: Dimensions.kBorderRadiusAllLarger,
                      ),
                      child: Text(
                        'Allow All Access',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: appColor.success600,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  resourceConstants(
      {required BuildContext context,
      required String svg,
      required String title,
      required String description}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(svg,
            width: Dimensions.iconSizeSmall,
            colorFilter:
                ColorFilter.mode(appColor.success600, BlendMode.srcIn)),
        Dimensions.kHorizontalSpaceMedium,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(title, style: context.textTheme.headlineMedium),
              Dimensions.kVerticalSpaceSmallest,
              Text(
                description,
                style: context.textTheme.bodySmall?.copyWith(
                  color: appColor.gray800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
