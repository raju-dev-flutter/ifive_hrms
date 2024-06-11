import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../task.dart';

class CreateSupportTaskScreen extends StatelessWidget {
  const CreateSupportTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: appColor.gray50,
        appBar: PreferredSize(
          preferredSize: Size(context.deviceSize.width, 92.h),
          child: CustomAppBar(
            onPressed: () => Navigator.pop(context),
            title: "Create Support Task",
            bottom: PreferredSize(
              preferredSize: Size(context.deviceSize.width, 1),
              child: TabBar(
                labelStyle: context.textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w500),
                unselectedLabelStyle: context.textTheme.labelLarge,
                labelColor: appColor.blue600,
                unselectedLabelColor: appColor.gray600,
                dragStartBehavior: DragStartBehavior.start,
                tabs: const [
                  Tab(child: Text('SELF')),
                  Tab(child: Text('ASSIGN'))
                ],
              ),
            ),
          ),
        ),
        body: BlocListener<TaskCrudBloc, TaskCrudState>(
          listener: (context, state) {
            if (state is TaskCrudSuccess) {
              AppAlerts.displaySnackBar(
                  context, "Support Task Successfully Created", true);
              Navigator.pop(context);
            }
            if (state is TaskCrudFailure) {
              AppAlerts.displaySnackBar(context, state.message, false);
            }
          },
          child: const TabBarView(
            children: [SelfTaskFormUI(), AssignTaskFormUI()],
          ),
        ),
      ),
    );
  }
}

class SelfTaskFormUI extends StatefulWidget {
  const SelfTaskFormUI({super.key});

  @override
  State<SelfTaskFormUI> createState() => _SelfTaskFormUIState();
}

class _SelfTaskFormUIState extends State<SelfTaskFormUI>
    with InputValidationMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final supportTaskStream = sl<SupportTaskStream>();

  @override
  void initState() {
    super.initState();
    supportTaskStream.fetchInitialCallBack();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Dimensions.kPaddingAllMedium,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFormField(
              label: "Task",
              controller: supportTaskStream.taskController,
              required: true,
              keyboardType: TextInputType.text,
              validator: (val) {
                if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                return null;
              },
            ),
            Dimensions.kVerticalSpaceSmaller,
            CustomStreamDropDownWidget(
              label: "Project",
              required: true,
              streamList: supportTaskStream.projectList,
              valueListInit: supportTaskStream.projectListInit,
              onChanged: (params) {
                supportTaskStream.project(params);
                setState(() {});
              },
              validator: (val) {
                if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                return null;
              },
            ),
            Dimensions.kVerticalSpaceSmaller,
            CustomStreamDropDownWidget(
              label: "Project Type",
              required: true,
              streamList: supportTaskStream.typeList,
              valueListInit: supportTaskStream.typeListInit,
              onChanged: (params) {
                supportTaskStream.type(params);
                setState(() {});
              },
              validator: (val) {
                if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                return null;
              },
            ),
            Dimensions.kVerticalSpaceSmaller,
            CustomStreamDropDownWidget(
              label: "Status",
              required: true,
              streamList: supportTaskStream.statusList,
              valueListInit: supportTaskStream.statusListInit,
              onChanged: (params) {
                supportTaskStream.status(params);
                setState(() {});
              },
              validator: (val) {
                if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                return null;
              },
            ),
            Dimensions.kVerticalSpaceSmaller,
            StreamBuilder<CommonList>(
                stream: supportTaskStream.statusListInit,
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.name != "Completed") {
                    return Container();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10).h,
                    child: CustomDateTimeTextFormField(
                      label: 'Task Start Date',
                      required: true,
                      controller: TextEditingController(
                        text:
                            supportTaskStream.selectStartDate.valueOrNull ?? '',
                      ),
                      validator: (val) {
                        if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                        return null;
                      },
                      onPressed: () async {
                        DateTime date = await PickDateTime.date(
                          context,
                          selectedDate: supportTaskStream.startDate.valueOrNull,
                          startDate: DateTime.now(),
                        );
                        supportTaskStream.selectedStartDate(date, context);
                        setState(() {});
                      },
                    ),
                  );
                }),
            CustomDateTimeTextFormField(
              label: 'Task End Date',
              required: true,
              controller: TextEditingController(
                  text: supportTaskStream.selectEndDate.valueOrNull ?? ''),
              validator: (val) {
                if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                return null;
              },
              onPressed: () async {
                DateTime date = await PickDateTime.date(context,
                    selectedDate: supportTaskStream.endDate.valueOrNull,
                    startDate: DateTime.now());
                supportTaskStream.selectedEndDate(date, context);
                setState(() {});
              },
            ),

            Dimensions.kVerticalSpaceSmaller,
            StreamBuilder<CommonList>(
                stream: supportTaskStream.statusListInit,
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.name != "Completed") {
                    return Container();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10).h,
                    child: CustomDateTimeTextFormField(
                      label: 'Start Time',
                      hint: 'SELECT TIME',
                      required: true,
                      controller: TextEditingController(
                        text:
                            supportTaskStream.selectStartTime.valueOrNull ?? '',
                      ),
                      validator: (val) {
                        if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                        return null;
                      },
                      onPressed: () async {
                        DateTime date = await PickDateTime.date(context,
                            selectedDate: null, startDate: null);
                        TimeOfDay time = await PickDateTime.time(context);
                        supportTaskStream.selectedStartTime(
                            context, date, time);
                        setState(() {});
                      },
                    ),
                  );
                }),
            StreamBuilder<CommonList>(
                stream: supportTaskStream.statusListInit,
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.name != "Completed") {
                    return Container();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10).h,
                    child: CustomDateTimeTextFormField(
                      label: 'End Time',
                      hint: 'SELECT TIME',
                      required: true,
                      controller: TextEditingController(
                        text: supportTaskStream.selectEndTime.valueOrNull ?? '',
                      ),
                      validator: (val) {
                        if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                        return null;
                      },
                      onPressed: () async {
                        DateTime date = await PickDateTime.date(context,
                            selectedDate: null, startDate: null);
                        TimeOfDay time = await PickDateTime.time(context);
                        supportTaskStream.selectedToTime(context, date, time);
                        setState(() {});
                      },
                    ),
                  );
                }),
            CustomStreamDropDownWidget(
              label: "Priority",
              required: true,
              streamList: supportTaskStream.priorityList,
              valueListInit: supportTaskStream.priorityListInit,
              onChanged: (params) {
                supportTaskStream.priority(params);
                setState(() {});
              },
            ),
            // Dimensions.kVerticalSpaceSmaller,
            // CustomStreamDropDownWidget(
            //   label: "Team",
            //   required: true,
            //   streamList: supportTaskStream.teamList,
            //   valueListInit: supportTaskStream.teamListInit,
            //   onChanged: (params) {
            //     supportTaskStream.team(params);
            //     setState(() {});
            //   },
            //   validator: (val) {
            //     if (!isCheckTextFieldIsEmpty(val!)) return "required *";
            //     return null;
            //   },
            // ),
            // Dimensions.kVerticalSpaceSmaller,
            // CustomStreamDropDownWidget(
            //   label: "Task Given By",
            //   required: true,
            //   streamList: supportTaskStream.assignList,
            //   valueListInit: supportTaskStream.assignListInit,
            //   onChanged: (params) {
            //     supportTaskStream.assignTo(params);
            //     setState(() {});
            //   },
            //   validator: (val) {
            //     if (!isCheckTextFieldIsEmpty(val!)) return "required *";
            //     return null;
            //   },
            // ),
            Dimensions.kVerticalSpaceSmaller,
            CustomStreamDropDownWidget(
              label: "Discuss",
              required: true,
              streamList: supportTaskStream.discussList,
              valueListInit: supportTaskStream.discussListInit,
              onChanged: (params) {
                supportTaskStream.discuss(params);
                setState(() {});
              },
              validator: (val) {
                if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                return null;
              },
            ),
            Dimensions.kVerticalSpaceSmaller,
            CustomTextFormField(
              label: "Description",
              controller: supportTaskStream.descriptionController,
              required: true,
              maxLines: 4,
              keyboardType: TextInputType.text,
              validator: (val) {
                if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                return null;
              },
            ),
            Dimensions.kVerticalSpaceSmaller,

            ///
            Dimensions.kVerticalSpaceLarge,
            BlocBuilder<TaskCrudBloc, TaskCrudState>(
              builder: (context, state) {
                if (state is TaskCrudLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ActionButton(
                  onPressed: () => {
                    if (_formKey.currentState!.validate())
                      {supportTaskStream.onSelfTaskSubmit(context)}
                  },
                  label: 'SUBMIT',
                );
              },
            ),
            Dimensions.kVerticalSpaceSmall,
          ],
        ),
      ),
    );
  }
}

class AssignTaskFormUI extends StatefulWidget {
  const AssignTaskFormUI({super.key});

  @override
  State<AssignTaskFormUI> createState() => _AssignTaskFormUIState();
}

class _AssignTaskFormUIState extends State<AssignTaskFormUI>
    with InputValidationMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final supportTaskStream = sl<SupportTaskStream>();

  @override
  void initState() {
    super.initState();
    supportTaskStream.fetchInitialCallBack();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Dimensions.kPaddingAllMedium,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFormField(
              label: "Task",
              controller: supportTaskStream.taskController,
              required: true,
              keyboardType: TextInputType.text,
              validator: (val) {
                if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                return null;
              },
            ),
            Dimensions.kVerticalSpaceSmaller,
            CustomStreamDropDownWidget(
              label: "Project",
              required: true,
              streamList: supportTaskStream.projectList,
              valueListInit: supportTaskStream.projectListInit,
              onChanged: (params) {
                supportTaskStream.project(params);
              },
              validator: (val) {
                if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                return null;
              },
            ),
            Dimensions.kVerticalSpaceSmaller,
            CustomStreamDropDownWidget(
              label: "Project Type",
              required: true,
              streamList: supportTaskStream.typeList,
              valueListInit: supportTaskStream.typeListInit,
              onChanged: (params) {
                supportTaskStream.type(params);
              },
              validator: (val) {
                if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                return null;
              },
            ),
            Dimensions.kVerticalSpaceSmaller,
            CustomStreamDropDownWidget(
              label: "Status",
              required: true,
              streamList: supportTaskStream.statusList,
              valueListInit: supportTaskStream.statusListInit,
              onChanged: (params) {
                supportTaskStream.status(params);
                setState(() {});
              },
              validator: (val) {
                if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                return null;
              },
            ),
            Dimensions.kVerticalSpaceSmaller,
            StreamBuilder<CommonList>(
                stream: supportTaskStream.statusListInit,
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.name != "Completed") {
                    return Container();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10).h,
                    child: CustomDateTimeTextFormField(
                      label: 'Task Start Date',
                      required: true,
                      controller: TextEditingController(
                        text:
                            supportTaskStream.selectStartDate.valueOrNull ?? '',
                      ),
                      validator: (val) {
                        if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                        return null;
                      },
                      onPressed: () async {
                        DateTime date = await PickDateTime.date(
                          context,
                          selectedDate: supportTaskStream.startDate.valueOrNull,
                          startDate: DateTime.now(),
                        );
                        supportTaskStream.selectedStartDate(date, context);
                        setState(() {});
                      },
                    ),
                  );
                }),
            CustomDateTimeTextFormField(
              label: 'Task End Date',
              required: true,
              controller: TextEditingController(
                  text: supportTaskStream.selectEndDate.valueOrNull ?? ''),
              validator: (val) {
                if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                return null;
              },
              onPressed: () async {
                DateTime date = await PickDateTime.date(context,
                    selectedDate: supportTaskStream.endDate.valueOrNull,
                    startDate: DateTime.now());
                supportTaskStream.selectedEndDate(date, context);
                setState(() {});
              },
            ),

            Dimensions.kVerticalSpaceSmaller,
            StreamBuilder<CommonList>(
                stream: supportTaskStream.statusListInit,
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.name != "Completed") {
                    return Container();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10).h,
                    child: CustomDateTimeTextFormField(
                      label: 'Start Time',
                      hint: 'SELECT TIME',
                      required: true,
                      controller: TextEditingController(
                        text:
                            supportTaskStream.selectStartTime.valueOrNull ?? '',
                      ),
                      validator: (val) {
                        if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                        return null;
                      },
                      onPressed: () async {
                        DateTime date = await PickDateTime.date(context,
                            selectedDate: null, startDate: null);
                        TimeOfDay time = await PickDateTime.time(context);
                        supportTaskStream.selectedStartTime(
                            context, date, time);
                        setState(() {});
                      },
                    ),
                  );
                }),
            StreamBuilder<CommonList>(
                stream: supportTaskStream.statusListInit,
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.name != "Completed") {
                    return Container();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10).h,
                    child: CustomDateTimeTextFormField(
                      label: 'End Time',
                      hint: 'SELECT TIME',
                      required: true,
                      controller: TextEditingController(
                        text: supportTaskStream.selectEndTime.valueOrNull ?? '',
                      ),
                      validator: (val) {
                        if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                        return null;
                      },
                      onPressed: () async {
                        DateTime date = await PickDateTime.date(context,
                            selectedDate: null, startDate: null);
                        TimeOfDay time = await PickDateTime.time(context);
                        supportTaskStream.selectedToTime(context, date, time);
                        setState(() {});
                      },
                    ),
                  );
                }),
            CustomStreamDropDownWidget(
              label: "Priority",
              required: true,
              streamList: supportTaskStream.priorityList,
              valueListInit: supportTaskStream.priorityListInit,
              onChanged: (params) => supportTaskStream.priority(params),
            ),
            Dimensions.kVerticalSpaceSmaller,
            CustomStreamDropDownWidget(
              label: "Assign To",
              required: true,
              streamList: supportTaskStream.assignList,
              valueListInit: supportTaskStream.assignListInit,
              onChanged: (params) => supportTaskStream.assignTo(params),
              validator: (val) {
                if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                return null;
              },
            ),
            // Dimensions.kVerticalSpaceSmaller,
            // CustomStreamDropDownWidget(
            //   label: "Team",
            //   required: true,
            //   streamList: supportTaskStream.teamList,
            //   valueListInit: supportTaskStream.teamListInit,
            //   onChanged: (params) => supportTaskStream.team(params),
            //   validator: (val) {
            //     if (!isCheckTextFieldIsEmpty(val!)) return "required *";
            //     return null;
            //   },
            // ),
            // Dimensions.kVerticalSpaceSmaller,
            // CustomStreamDropDownWidget(
            //   label: "Task Given By",
            //   required: true,
            //   streamList: supportTaskStream.givenByList,
            //   valueListInit: supportTaskStream.givenByListInit,
            //   onChanged: (params) => supportTaskStream.givenBy(params),
            //   validator: (val) {
            //     if (!isCheckTextFieldIsEmpty(val!)) return "required *";
            //     return null;
            //   },
            // ),
            Dimensions.kVerticalSpaceSmaller,
            CustomStreamDropDownWidget(
              label: "Discuss",
              required: true,
              streamList: supportTaskStream.discussList,
              valueListInit: supportTaskStream.discussListInit,
              onChanged: (params) => supportTaskStream.discuss(params),
              validator: (val) {
                if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                return null;
              },
            ),
            Dimensions.kVerticalSpaceSmaller,
            CustomTextFormField(
              label: "Description",
              controller: supportTaskStream.descriptionController,
              required: true,
              maxLines: 4,
              keyboardType: TextInputType.text,
              validator: (val) {
                if (!isCheckTextFieldIsEmpty(val!)) return "required *";
                return null;
              },
            ),
            Dimensions.kVerticalSpaceSmaller,

            ///
            Dimensions.kVerticalSpaceLarge,
            BlocBuilder<TaskCrudBloc, TaskCrudState>(
              builder: (context, state) {
                if (state is TaskCrudLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ActionButton(
                  onPressed: () => {
                    if (_formKey.currentState!.validate())
                      {supportTaskStream.onAssignTaskSubmit(context)}
                  },
                  label: 'SUBMIT',
                );
              },
            ),
            Dimensions.kVerticalSpaceSmall,
          ],
        ),
      ),
    );
  }
}
