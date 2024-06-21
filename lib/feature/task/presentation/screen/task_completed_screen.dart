import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../task.dart';

class TaskCompletedScreen extends StatefulWidget {
  const TaskCompletedScreen({super.key});

  @override
  State<TaskCompletedScreen> createState() => _TaskCompletedScreenState();
}

class _TaskCompletedScreenState extends State<TaskCompletedScreen> {
  late TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialCallBack();
  }

  Future<void> initialCallBack() async {
    BlocProvider.of<TaskBarCubit>(context).taskBarItem(TaskItem.COMPLETED);
    BlocProvider.of<StatusBasedTaskCubit>(context)
        .statusBasedTask(status: "Completed", search: searchController.text);
  }

  @override
  Widget build(BuildContext context) => _buildBodyUI();

  Widget _buildBodyUI() {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6).w,
          child: TextFormField(
            controller: searchController,
            keyboardType: TextInputType.text,
            enableSuggestions: true,
            obscureText: false,
            enableInteractiveSelection: true,
            style: context.textTheme.bodySmall,
            onChanged: (val) => initialCallBack(),
            decoration:
                inputDecoration(label: 'Search', onPressed: initialCallBack),
          ),
        ),
        Expanded(
          child: BlocBuilder<StatusBasedTaskCubit, StatusBasedTaskState>(
            builder: (context, state) {
              if (state is StatusBasedTaskLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is StatusBasedTaskLoaded) {
                final task = state.taskPlannerModel.taskPlanner;
                if (task!.isEmpty) {
                  return Center(child: EmptyScreen(onPressed: initialCallBack));
                }
                return RefreshIndicator(
                  onRefresh: initialCallBack,
                  child: ListView.builder(
                    itemCount: task.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 6, bottom: 16)
                        .w,
                    itemBuilder: (_, i) => $CompletedTaskCardUI(task[i]),
                  ),
                );
              }
              if (state is StatusBasedTaskFailure) {
                return Center(child: EmptyScreen(onPressed: initialCallBack));
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }

  Widget $CompletedTaskCardUI(TaskPlanner task) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4).w,
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          AppRouterPath.taskCompletedDetailScreen,
          arguments: TaskCompletedDetailScreen(task: task),
        ).then((value) => initialCallBack()),
        borderRadius: Dimensions.kBorderRadiusAllSmaller,
        child: Container(
          padding: Dimensions.kPaddingAllMedium,
          decoration: BoxDecoration(
            color: appColor.white,
            borderRadius: Dimensions.kBorderRadiusAllSmaller,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  badge(
                      color: appColor.warning500,
                      label: (task.priority ?? "").toUpperCase()),

                  Dimensions.kHorizontalSpaceSmaller,
                  badge(
                      color: appColor.brand600,
                      label: (task.projectName ?? "").toUpperCase()),
                  // badge(
                  //     color: appColor.blue600,
                  //     label: (task.status ?? "").toUpperCase()),
                  Dimensions.kSpacer,
                  if (task.taskType != null && task.taskType == "Reword")
                    badge(
                      color: appColor.blue600,
                      child: Icon(
                        Icons.restart_alt,
                        size: Dimensions.iconSizeSmallest,
                        color: appColor.blue600,
                      ),
                    ),
                ],
              ),
              Dimensions.kVerticalSpaceSmaller,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.task ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.labelLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        if (task.description != null &&
                            task.description != '') ...[
                          Dimensions.kVerticalSpaceSmallest,
                          Text(
                            task.description ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.labelMedium
                                ?.copyWith(color: appColor.gray500),
                          ),
                        ]
                      ],
                    ),
                  ),
                  Dimensions.kHorizontalSpaceSmaller,
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 46.w,
                        height: 46.h,
                        child: CircularProgressIndicator(
                          value: (task.percentage ?? 0).toDouble() / 100,
                          backgroundColor: appColor.gray100,
                          color: appColor.gray100,
                          valueColor: AlwaysStoppedAnimation<Color?>(
                              appColor.success600),
                          strokeWidth: 10,
                          strokeCap: StrokeCap.butt,
                        ),
                      ),
                      Positioned(
                          child: Text(
                        "${task.percentage ?? ''} %",
                        style: context.textTheme.labelMedium?.copyWith(
                            color: appColor.gray500,
                            fontWeight: FontWeight.bold),
                      )),
                    ],
                  ),
                ],
              ),
              // Dimensions.kVerticalSpaceSmaller,
              // RichText(
              //   text: TextSpan(
              //     text: "${task.percentage ?? 0}% ",
              //     style: context.textTheme.labelLarge?.copyWith(
              //         fontWeight: FontWeight.bold, color: appColor.gray800),
              //     children: [
              //       TextSpan(
              //         text: "Completed",
              //         style: context.textTheme.labelLarge
              //             ?.copyWith(color: appColor.gray600),
              //       ),
              //     ],
              //   ),
              // ),
              // Dimensions.kVerticalSpaceSmallest,
              // LinearProgressIndicator(
              //   semanticsLabel: "Task Completed Status",
              //   semanticsValue: "${task.percentage ?? 0} %",
              //   value: (task.percentage ?? 0).toDouble() / 100,
              //   backgroundColor: appColor.gray200,
              //   valueColor: AlwaysStoppedAnimation<Color>(appColor.success600),
              //   minHeight: 10.h,
              //   borderRadius: Dimensions.kBorderRadiusAllSmall,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(
      {required String label, required Function() onPressed}) {
    return InputDecoration(
      suffixIcon: InkWell(
        onTap: onPressed,
        child: Icon(Icons.search, color: appColor.gray400),
      ),
      fillColor: appColor.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.gray400),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.gray100),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.blue600),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.error600),
      ),
      labelText: "$label...",
      labelStyle:
          context.textTheme.labelMedium?.copyWith(color: appColor.gray400),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0).w,
      errorStyle:
          context.textTheme.labelMedium?.copyWith(color: appColor.error400),
    );
  }

  Widget badge({Color? color, String? label, Widget? child}) {
    return Container(
      padding: Dimensions.kPaddingAllSmaller,
      decoration: BoxDecoration(
        color: (color ?? appColor.blue100).withOpacity(.2),
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
      ),
      child: child ??
          Text(
            label ?? "",
            style: context.textTheme.labelSmall?.copyWith(
                color: color ?? appColor.blue100, fontWeight: FontWeight.bold),
          ),
    );
  }
}

class TaskCompletedDetailScreen extends StatefulWidget {
  final TaskPlanner task;

  const TaskCompletedDetailScreen({super.key, required this.task});

  @override
  State<TaskCompletedDetailScreen> createState() =>
      _TaskCompletedDetailScreenState();
}

class _TaskCompletedDetailScreenState extends State<TaskCompletedDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appColor.gray50,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: "Task Completed Details",
        ),
      ),
      body: SingleChildScrollView(child: _buildBodyUI()),
    );
  }

  Widget _buildBodyUI() {
    final task = widget.task;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8).w,
          child: Container(
            padding: Dimensions.kPaddingAllMedium,
            decoration: boxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppSvg.taskFill,
                            width: 22.w,
                            colorFilter: ColorFilter.mode(
                                appColor.blue600, BlendMode.srcIn),
                          ),
                          Dimensions.kHorizontalSpaceMedium,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.projectName ?? ' ',
                                  style: context.textTheme.bodySmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Dimensions.kVerticalSpaceSmallest,
                                Text(
                                  task.task ?? ' ',
                                  style: context.textTheme.labelLarge,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (isEmpty(task.description)) ...[
                  Dimensions.kVerticalSpaceSmall,
                  Text(
                    "Task Description:",
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelLarge
                        ?.copyWith(color: appColor.gray500),
                  ),
                  Dimensions.kVerticalSpaceSmallest,
                  Text(
                    task.description ?? "",
                    style: context.textTheme.labelLarge
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
                if (isEmpty(task.reworkRemarks)) ...[
                  Dimensions.kVerticalSpaceSmall,
                  Text(
                    "Rework Task Description:",
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelLarge
                        ?.copyWith(color: appColor.gray500),
                  ),
                  Dimensions.kVerticalSpaceSmallest,
                  Text(
                    task.reworkRemarks ?? "",
                    style: context.textTheme.labelLarge
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
                Dimensions.kVerticalSpaceSmaller,
                taskProperty(
                  icon: Icons.people,
                  label: 'Assigned',
                  value: task.taskGivenByName ?? "",
                ),
                Dimensions.kVerticalSpaceSmaller,
                taskProperty(
                  icon: Icons.timeline,
                  label: 'Timeline',
                  value: task.taskDate ?? "",
                ),
                Dimensions.kVerticalSpaceSmaller,
                taskProperty(
                  icon: Icons.task,
                  label: 'Project Type',
                  value: task.type ?? "",
                ),
                Dimensions.kVerticalSpaceSmaller,
                taskProperty(
                  icon: Icons.low_priority_rounded,
                  label: 'Priority',
                  value: task.priority ?? '',
                ),
                Dimensions.kVerticalSpaceSmaller,
                taskProperty(
                  icon: Icons.percent_rounded,
                  label: 'Status',
                  value: task.status ?? '',
                ),
              ],
            ),
          ),
        ),
        if (isEmpty(task.taskGivenByName) ||
            isEmpty(task.assignToName) ||
            isEmpty(task.supportName) ||
            isEmpty(task.testedByName) ||
            isEmpty(task.deliveryTeamName))
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8).w,
            child: Container(
              padding: Dimensions.kPaddingAllMedium,
              width: context.deviceSize.width,
              decoration: boxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Team",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: context.textTheme.labelLarge,
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        if (isEmpty(task.taskGivenByName))
                          teamCard(
                            name: (task.taskGivenByName ?? "").toUpperCase(),
                            role: "Dev",
                            label: "Task Given By",
                          ),
                        if (isEmpty(task.assignToName))
                          teamCard(
                            name: (task.assignToName ?? "").toUpperCase(),
                            role: "Dev",
                            label: "Assigned By",
                          ),
                        if (isEmpty(task.supportName))
                          teamCard(
                            name: (task.supportName ?? "").toUpperCase(),
                            role: "Dev",
                            label: "Supported By",
                          ),
                        if (isEmpty(task.testedByName))
                          teamCard(
                            name: (task.testedByName ?? "").toUpperCase(),
                            role: "Dev",
                            label: "L1 Tested By",
                          ),
                        if (isEmpty(task.deliveryTeamName))
                          teamCard(
                            name: (task.deliveryTeamName ?? "").toUpperCase(),
                            role: "Delivery",
                            label: "L2 Tested By",
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (task.taskTimeHistory!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16).w,
            child: Container(
              padding: Dimensions.kPaddingAllMedium,
              width: context.deviceSize.width,
              decoration: boxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Task Time History",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: context.textTheme.labelLarge,
                  ),
                  Dimensions.kVerticalSpaceSmaller,
                  SizedBox(
                    height: 130,
                    child: ListView.builder(
                      itemCount: tLength(task.taskTimeHistory!),
                      itemBuilder: (_, i) {
                        final time = task.taskTimeHistory![i];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0).w,
                          // child: timeHistory(task.taskTimeHistory![i]),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      time.taskStatus ?? '',
                                      style: context.textTheme.labelMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: appColor.blue600),
                                    ),
                                  ),
                                  Dimensions.kHorizontalSpaceMedium,
                                  Expanded(
                                    child: Text(
                                      "S: ${timeFormat(time.taskStartTime ?? '')}",
                                      style: context.textTheme.labelMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: appColor.gray700),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "E: ${timeFormat(time.taskEndTime ?? '')}",
                                      style: context.textTheme.labelMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: appColor.gray700),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "D: ${timeFormat(time.taskEndTime ?? '')}",
                                      style: context.textTheme.labelMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: appColor.gray700),
                                    ),
                                  ),
                                ],
                              ),
                              if (i != task.taskTimeHistory!.length - 1)
                                Divider(height: 16.h, color: appColor.blue200),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  bool isEmpty(dynamic label) {
    if (label != '' && label != null) return true;
    return false;
  }

  int tLength(List<TaskTimeHistory> history) => history.length;

  String timeFormat(String time) {
    final splitTime = time.split(' ').last.split('.').first.split(':');
    return "${splitTime[0]}:${splitTime[1]}";
  }

  String getTimeStatus(String label) {
    final Map<String, String> statusMap = {
      'In Progress': 'IN',
      'Testing L1': 'TL1',
      'Testing L2': 'TL2',
    };

    return statusMap[label] ?? 'T';
  }

  Widget teamCard({required label, required name, required role}) {
    return Padding(
      padding: const EdgeInsets.only(right: 16).w,
      child: Column(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: appColor.gray100,
              borderRadius: BorderRadius.circular(30).w,
            ),
            child: Icon(
              Icons.people,
              color: appColor.blue600,
            ),
          ),
          Dimensions.kVerticalSpaceSmaller,
          Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.labelSmall
                ?.copyWith(color: appColor.gray600, fontSize: 8.sp),
          ),
          SizedBox(height: 4.h),
          Text(
            name,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.labelMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          Text(
            role,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w500, color: appColor.gray600),
          )
        ],
      ),
    );
  }

  Widget badge({Color? color, required String label}) {
    return Container(
      padding: Dimensions.kPaddingAllSmaller,
      decoration: BoxDecoration(
        color: (color ?? appColor.blue100).withOpacity(.2),
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
      ),
      child: Text(
        label,
        style: context.textTheme.labelSmall?.copyWith(
            color: color ?? appColor.blue100, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget taskProperty(
      {required IconData icon, required String label, required String value}) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Icon(icon, size: 16.w, color: appColor.blue600),
              Dimensions.kHorizontalSpaceSmaller,
              Text(
                label,
                style: context.textTheme.labelLarge
                    ?.copyWith(color: appColor.gray500),
              ),
            ],
          ),
        ),
        Dimensions.kHorizontalSpaceSmallest,
        Expanded(
          flex: 3,
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: context.textTheme.labelLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: const Color(0xFFFFFFFF),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0800366D),
          offset: Offset(0, 3),
          blurRadius: 6,
        ),
      ],
    );
  }
}
