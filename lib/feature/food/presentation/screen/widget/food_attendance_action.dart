import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../food.dart';

class FoodAttendanceAction extends StatelessWidget {
  const FoodAttendanceAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Dimensions.kPaddingAllMedium,
      child: BlocBuilder<FoodAttendanceStatusCubit, FoodAttendanceStatusState>(
        builder: (context, state) {
          if (state is FoodAttendanceStatusLoading) {
            return const FoodAttendanceActionLoading();
          }
          if (state is FoodAttendanceStatusLoaded) {
            if (state.foodAttendanceResponse.message == "") {
              if (PickDateTime().checkAvailableTime(TimeOfDay.now())) {
                return BlocBuilder<FoodAttendanceBloc, FoodAttendanceState>(
                  builder: (context, state) {
                    if (state is UpdateFoodAttendanceLoading) {
                      return const FoodAttendanceActionLoading();
                    }
                    return Row(
                      children: [
                        Expanded(
                          child: ActionButton(
                            onPressed: () => onSubmit(context, "Need"),
                            label: 'NEED',
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: ActionButton(
                            onPressed: () => onSubmit(context, "No Need"),
                            label: 'NO NEED',
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else {
                return inActiveActionButton();
              }
            } else if (state.foodAttendanceResponse.message != "") {
              if (PickDateTime().checkAvailableTime(TimeOfDay.now())) {
                return BlocBuilder<FoodAttendanceBloc, FoodAttendanceState>(
                  builder: (context, state) {
                    if (state is UpdateFoodAttendanceLoading) {
                      return const FoodAttendanceActionLoading();
                    }

                    return Row(
                      children: [
                        Expanded(
                          child: BlocBuilder<FoodAttendanceStatusCubit,
                              FoodAttendanceStatusState>(
                            builder: (context, state) {
                              if (state is FoodAttendanceStatusLoaded) {
                                if (state.foodAttendanceResponse.message !=
                                    "Need") {
                                  return ActionButton(
                                    onPressed: () => onSubmit(context, "Need"),
                                    label: "NEED",
                                  );
                                } else {
                                  return const DefaultActionButton(
                                      label: 'NEED');
                                }
                              }
                              return const DefaultActionButton(label: 'NEED');
                            },
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: BlocBuilder<FoodAttendanceStatusCubit,
                              FoodAttendanceStatusState>(
                            builder: (context, state) {
                              if (state is FoodAttendanceStatusLoaded) {
                                if (state.foodAttendanceResponse.message !=
                                    "No Need") {
                                  return ActionButton(
                                    onPressed: () =>
                                        onSubmit(context, "No Need"),
                                    label: "NO NEED",
                                  );
                                } else {
                                  return const DefaultActionButton(
                                      label: 'NO NEED');
                                }
                              }
                              return const DefaultActionButton(
                                  label: 'NO NEED');
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else {
                return inActiveActionButton();
              }
            } else {
              return inActiveActionButton();
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget inActiveActionButton() {
    return Row(
      children: [
        const Expanded(child: DefaultActionButton(label: 'NEED')),
        SizedBox(width: 6.w),
        const Expanded(child: DefaultActionButton(label: 'NO NEED')),
      ],
    );
  }

  void onSubmit(BuildContext context, label) {
    if (PickDateTime().checkAvailableTime(TimeOfDay.now())) {
      foodAttendanceSubmit(context, label);
    } else {
      showFoodAttendanceOverTimeAlert(context);
    }
  }

  void showFoodAttendanceOverTimeAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: appColor.white,
          alignment: Alignment.center,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Dimensions.kVerticalSpaceSmaller,
              SvgPicture.asset(
                AppSvg.foodFill,
                colorFilter:
                    ColorFilter.mode(appColor.warning600, BlendMode.srcIn),
              ),
              Dimensions.kVerticalSpaceSmall,
              Text(
                "Sorry! you can't request food?",
                textAlign: TextAlign.center,
                style: context.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Dimensions.kVerticalSpaceSmall,
            ],
          ),
        );
      },
    );
  }

  void foodAttendanceSubmit(BuildContext context, String status) {
    BlocProvider.of<FoodAttendanceBloc>(context)
        .add(UpdateFoodAttendanceEvent(status: status));
  }
}

class FoodAttendanceActionLoading extends StatelessWidget {
  const FoodAttendanceActionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: appColor.gray300.withOpacity(.4),
                  ),
                  child: Text(
                    'NEED',
                    style: context.textTheme.labelLarge?.copyWith(
                        color: appColor.gray300, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: appColor.gray300.withOpacity(.4),
                  ),
                  child: Text(
                    'NO NEED',
                    style: context.textTheme.labelLarge?.copyWith(
                        color: appColor.gray300, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
