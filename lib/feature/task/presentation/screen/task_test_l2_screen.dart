import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../task.dart';

class TaskTestL2Screen extends StatefulWidget {
  const TaskTestL2Screen({super.key});

  @override
  State<TaskTestL2Screen> createState() => _TaskTestL2ScreenState();
}

class _TaskTestL2ScreenState extends State<TaskTestL2Screen>
    with InputValidationMixin {
  late TextEditingController searchController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final testL2Stream = sl<TaskTestL2Stream>();

  @override
  void initState() {
    super.initState();
    initialCallBack();
    testL2Stream.fetchInitialCallBack();
  }

  Future<void> initialCallBack() async {
    BlocProvider.of<TaskBarCubit>(context).taskBarItem(TaskItem.TESTINGL2);
    BlocProvider.of<StatusBasedTaskCubit>(context)
        .statusBasedTask(status: "Testing L2", search: searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCrudBloc, TaskCrudState>(
        listener: (context, state) {
      if (state is TaskCrudSuccess) {
        initialCallBack();
        AppAlerts.displaySnackBar(context, "Task Updated Successfully", true);
      }
      if (state is TaskCrudFailure) {
        AppAlerts.displaySnackBar(context, state.message, false);
      }
    }, builder: (context, state) {
      if (state is TaskCrudLoading) {
        return Center(
          child: CircularProgressIndicator(color: appColor.blue600),
        );
      }
      return _buildBodyUI();
    });
  }

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
                    itemBuilder: (_, i) => $TestL2TaskCardUI(task[i]),
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

  Widget $TestL2TaskCardUI(TaskPlanner task) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4).w,
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          AppRouterPath.taskTestL2UpdateScreen,
          arguments: TaskTestL2UpdateScreen(task: task),
        ).then((value) => initialCallBack()),
        child: Container(
          decoration: BoxDecoration(
            color: appColor.white,
            borderRadius: Dimensions.kBorderRadiusAllSmaller,
          ),
          child: Column(
            children: [
              Padding(
                padding: Dimensions.kPaddingAllMedium,
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
                              if (task.menu != null && task.menu != '') ...[
                                Dimensions.kVerticalSpaceSmallest,
                                Text(
                                  task.menu ?? '',
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
                  ],
                ),
              ),
              Divider(color: appColor.blue600.withOpacity(.1), height: 0),
              // Dimensions.kDivider,
              Padding(
                padding: const EdgeInsets.only(
                        left: 16, top: 12, bottom: 16, right: 16)
                    .w,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => onTimeHistoryModel(task),
                      child: Row(
                        children: [
                          Container(
                            padding: Dimensions.kPaddingAllSmall,
                            decoration: BoxDecoration(
                              color: appColor.blue600.withOpacity(.1),
                              borderRadius: Dimensions.kBorderRadiusAllSmaller,
                            ),
                            child: SvgPicture.asset(
                              AppSvg.time,
                              width: 16.w,
                              colorFilter: ColorFilter.mode(
                                  appColor.blue600, BlendMode.srcIn),
                            ),
                          ),
                          Dimensions.kHorizontalSpaceSmaller,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task.taskDate ?? '',
                                style: context.textTheme.labelMedium
                                    ?.copyWith(color: appColor.gray700),
                              ),
                              Text(
                                "Duration: ${task.duration ?? ''} min",
                                style: context.textTheme.labelMedium
                                    ?.copyWith(color: appColor.gray700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Dimensions.kSpacer,
                    ActionButton(
                      onPressed: () => onUpdateModel(task),
                      width: 120,
                      height: 40,
                      label: "UPDATE",
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onTimeHistoryModel(TaskPlanner task) {
    final time = task.taskTimeHistory;
    AppAlerts.displayContentListAlert(
      context: context,
      title: "Overall Time",
      child: Container(
        height: 300.h,
        alignment: Alignment.center,
        child: time!.isEmpty
            ? const EmptyScreen()
            : ListView.builder(
                itemCount: time!.length,
                padding: const EdgeInsets.all(0).w,
                itemBuilder: (_, i) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 16)
                              .w,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  time[i].taskStatus ?? "",
                                  style: context.textTheme.labelSmall
                                      ?.copyWith(color: appColor.gray800),
                                ),
                              ),
                              Dimensions.kHorizontalSpaceMedium,
                              Expanded(
                                child: Text(
                                  timeFormat(time[i].taskStartTime ?? ""),
                                  style: context.textTheme.labelSmall
                                      ?.copyWith(color: appColor.gray800),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  timeFormat(time[i].taskEndTime ?? ""),
                                  style: context.textTheme.labelSmall
                                      ?.copyWith(color: appColor.gray800),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  timeFormat(time[i].duration ?? ""),
                                  style: context.textTheme.labelSmall
                                      ?.copyWith(color: appColor.gray800),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (i != time.length - 1)
                          Divider(
                              color: appColor.blue600.withOpacity(.1),
                              height: 0),
                      ]);
                }),
      ),
    );
  }

  void onUpdateModel(TaskPlanner task) {
    AppAlerts.displayContentListAlert(
      context: context,
      title: "Task Update",
      child: Container(
        height: 370.h,
        padding: Dimensions.kPaddingAllMedium,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomStreamDropDownWidget(
                label: "Status",
                required: true,
                streamList: testL2Stream.statusList,
                valueListInit: testL2Stream.statusListInit,
                onChanged: (params) {
                  testL2Stream.status(params);
                  setState(() {});
                },
                validator: (val) {
                  if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                  return null;
                },
              ),
              Dimensions.kVerticalSpaceSmaller,
              StreamBuilder<CommonList>(
                  stream: testL2Stream.statusListInit,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    if (snapshot.data!.name != "Rework") {
                      return Container();
                    }
                    return Column(
                      children: [
                        CustomStreamDropDownWidget(
                          label: "Assign To",
                          required: true,
                          streamList: testL2Stream.userList,
                          valueListInit: testL2Stream.userListInit,
                          onChanged: (params) {
                            testL2Stream.assignTo(params);
                            setState(() {});
                          },
                          validator: (val) {
                            if (!isCheckTextFieldIsEmpty(val!)) {
                              return "required *";
                            }
                            return null;
                          },
                        ),
                        Dimensions.kVerticalSpaceSmaller,
                        CustomTextFormField(
                          label: "Description",
                          controller: testL2Stream.descriptionController,
                          required: true,
                          maxLines: 2,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (!isCheckTextFieldIsEmpty(val!)) {
                              return "required *";
                            }
                            return null;
                          },
                        ),
                      ],
                    );
                  }),
              Dimensions.kSpacer,
              ActionButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    testL2Stream.onSubmit(context, task);
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'UPDATE',
                  style: context.textTheme.labelLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int tLength(List<TaskTimeHistory> history) =>
      history.length - 1 < 6 ? history.length : 6;

  String getTimeHistory(TaskTimeHistory time) {
    final label =
        "${getTimeStatus(time.taskStatus ?? '')}: ${timeFormat(time.taskStartTime ?? '')} - ${timeFormat(time.taskEndTime ?? '')}";

    return label;
  }

  String timeFormat(String time) {
    final splitTime = time.split(' ').last.split('.').first.split(':');
    return "${splitTime[0]}:${splitTime[1]}";
  }

  String getTimeStatus(String label) {
    switch (label) {
      case 'In Progress':
        return 'IN';
      case 'Testing L1':
        return 'TL1';
      case 'Testing L2':
        return 'TL2';
      default:
        return 'T';
    }
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

class TaskTestL2UpdateScreen extends StatefulWidget {
  final TaskPlanner task;

  const TaskTestL2UpdateScreen({super.key, required this.task});

  @override
  State<TaskTestL2UpdateScreen> createState() => _TaskTestL2UpdateScreenState();
}

class _TaskTestL2UpdateScreenState extends State<TaskTestL2UpdateScreen>
    with InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final testL2Stream = sl<TaskTestL2Stream>();

  @override
  void initState() {
    super.initState();

    testL2Stream.fetchInitialCallBack();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appColor.gray50,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: "Testing L2 Task Details",
        ),
      ),
      body: BlocListener<TaskCrudBloc, TaskCrudState>(
        listener: (context, state) {
          if (state is TaskCrudSuccess) {
            Navigator.pop(context);
            AppAlerts.displaySnackBar(
                context, "Task Updated Successfully", true);
          }
          if (state is TaskCrudFailure) {
            AppAlerts.displaySnackBar(context, state.message, false);
          }
        },
        child: SingleChildScrollView(
            child: Form(key: _formKey, child: _buildBodyUI())),
      ),
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
                          Dimensions.kHorizontalSpaceSmall,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                badge(
                                    color: appColor.brand600,
                                    label:
                                        (task.projectName ?? "").toUpperCase()),
                                Dimensions.kVerticalSpaceSmallest,
                                Text(
                                  task.task ?? ' ',
                                  style: context.textTheme.bodySmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Dimensions.kVerticalSpaceSmallest,
                                if (isEmpty(task.menu))
                                  Text(
                                    "---- ${task.menu ?? ' '}",
                                    style: context.textTheme.labelLarge
                                        ?.copyWith(color: appColor.brand600),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Dimensions.kVerticalSpaceSmall,
                if (isEmpty(task.description)) ...[
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
                  label: 'Assigned To',
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
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16).w,
          child: Container(
            padding: Dimensions.kPaddingAllMedium,
            width: context.deviceSize.width,
            decoration: boxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomStreamDropDownWidget(
                  label: "Status",
                  required: true,
                  streamList: testL2Stream.statusList,
                  valueListInit: testL2Stream.statusListInit,
                  onChanged: (params) {
                    testL2Stream.status(params);
                    setState(() {});
                  },
                  validator: (val) {
                    if (!isCheckTextFieldIsEmpty(val!)) {
                      return "required *";
                    }
                    return null;
                  },
                ),
                Dimensions.kVerticalSpaceSmaller,
                StreamBuilder<CommonList>(
                    stream: testL2Stream.statusListInit,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.name == "Rework") {
                          return Column(
                            children: [
                              CustomStreamDropDownWidget(
                                label: "Assign To",
                                required: true,
                                streamList: testL2Stream.userList,
                                valueListInit: testL2Stream.userListInit,
                                onChanged: (params) {
                                  testL2Stream.assignTo(params);
                                  setState(() {});
                                },
                                validator: (val) {
                                  if (!isCheckTextFieldIsEmpty(val!)) {
                                    return "required *";
                                  }
                                  return null;
                                },
                              ),
                              Dimensions.kVerticalSpaceSmaller,
                              CustomTextFormField(
                                label: "Description",
                                controller: testL2Stream.descriptionController,
                                required: true,
                                keyboardType: TextInputType.text,
                                validator: (val) {
                                  if (!isCheckTextFieldIsEmpty(val!)) {
                                    return "required *";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          );
                        }
                      }
                      return Container();
                    }),
              ],
            ),
          ),
        ),
        BlocBuilder<TaskCrudBloc, TaskCrudState>(
          builder: (context, state) {
            if (state is TaskCrudLoading) {
              Container(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16).w,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16).w,
              child: Container(
                padding: Dimensions.kPaddingAllMedium,
                width: context.deviceSize.width,
                decoration: boxDecoration(),
                child: ActionButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      testL2Stream.onSubmit(context, task);
                    }
                  },
                  child: Text(
                    'UPDATE',
                    style: context.textTheme.labelLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
        Dimensions.kVerticalSpaceSmall,
      ],
    );
  }

  bool isEmpty(dynamic label) {
    if (label != '' && label != null) return true;
    return false;
  }

  int tLength(List<TaskTimeHistory> history) => history.length;

  String getTimeHistory(TaskTimeHistory time) {
    final label =
        "${getTimeStatus(time.taskStatus ?? '')}: ${timeFormat(time.taskStartTime ?? '')} - ${timeFormat(time.taskEndTime ?? '')}";

    return label;
  }

  String timeFormat(String time) {
    final splitTime = time.split(' ').last.split('.').first.split(':');
    return "${splitTime[0]}:${splitTime[1]}";
  }

  String getTimeStatus(String label) {
    switch (label) {
      case 'In Progress':
        return 'IN';
      case 'Testing L1':
        return 'TL1';
      case 'Testing L2':
        return 'TL2';
      default:
        return 'T';
    }
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
