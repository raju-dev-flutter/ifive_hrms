part of 'widget.dart';

class LeadTaskScreen extends StatefulWidget {
  const LeadTaskScreen({super.key});

  @override
  State<LeadTaskScreen> createState() => _LeadTaskScreenState();
}

class _LeadTaskScreenState extends State<LeadTaskScreen> {
  final searchController = TextEditingController();

  List<TaskLeadData> filterUserList = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TaskLeadCubit>(context).taskLead();
  }

  void initialCallBack(String filter, List<TaskLeadData> taskList) {
    filterUserList = taskList.where((task) {
      bool isProjectName = false;
      bool isTask = false;
      bool isStatus = false;

      if (task.projectName != null) {
        isProjectName =
            task.projectName!.toLowerCase().contains(filter.toLowerCase());
      }
      if (task.task != null) {
        isTask = task.task!.toLowerCase().contains(filter.toLowerCase());
      }
      if (task.status != null) {
        isStatus = task.status!.toLowerCase().contains(filter.toLowerCase());
      }

      return (isProjectName || isTask || isStatus);
    }).toList();

    // Update UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor.gray50,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: "Lead Task",
        ),
      ),
      body: _buildBodyUI(),
    );
  }

  Widget _buildBodyUI() {
    return BlocConsumer<TaskLeadCubit, TaskLeadState>(
      listener: (context, state) {
        if (state is TaskLeadLoaded) {
          initialCallBack("", state.taskLead);
        }
      },
      builder: (context, state) {
        if (state is TaskLeadLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TaskLeadLoaded) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 6)
                    .w,
                child: TextFormField(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  enableSuggestions: true,
                  obscureText: false,
                  enableInteractiveSelection: true,
                  style: context.textTheme.bodySmall,
                  onChanged: (val) => initialCallBack(val, state.taskLead),
                  decoration: inputDecoration(
                    label: 'Search',
                    onPressed: () =>
                        initialCallBack(searchController.text, state.taskLead),
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: Dimensions.kPaddingAllMedium,
                  itemBuilder: (_, i) {
                    return _TaskLeadDetailWidget(task: filterUserList[i]);
                  },
                  separatorBuilder: (_, i) => Dimensions.kVerticalSpaceSmaller,
                  itemCount: filterUserList.length,
                ),
              ),
            ],
          );
        }
        if (state is TaskLeadFailed) {}
        return Container();
      },
    );
  }

  InputDecoration inputDecoration(
      {required String label, required Function() onPressed}) {
    return InputDecoration(
      suffixIcon: InkWell(
        onTap: onPressed,
        child: const Icon(Icons.search),
      ),
      fillColor: appColor.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.gray200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.gray200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.brand600),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.error600),
      ),
      // labelText: "$label...",
      hintText: "Project , Task, Status...",
      hintStyle:
          context.textTheme.labelMedium?.copyWith(color: appColor.gray400),
      labelStyle:
          context.textTheme.labelMedium?.copyWith(color: appColor.gray400),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0).w,
      errorStyle:
          context.textTheme.labelMedium?.copyWith(color: appColor.error600),
    );
  }
}

class _TaskLeadDetailWidget extends StatelessWidget {
  final TaskLeadData task;

  const _TaskLeadDetailWidget({required this.task});

  Color getColor(String label) {
    switch (label.toUpperCase()) {
      case "INITIATED":
        return appColor.warning600;
      case "PENDING":
        return appColor.indigo600;
      case "IN PROGRESS":
        return appColor.fuchsia600;
      case "APPROVE":
        return appColor.success600;
      case "TESTING L1" || "TESTING L2":
        return appColor.grayBlue600;
      case "REJECT" || "REJECTED" || "CANCELLED":
        return appColor.error600;
    }

    return appColor.success600;
  }

  @override
  Widget build(BuildContext context) {
    final color = getColor(task.status ?? '');
    return Container(
      padding: Dimensions.kPaddingAllSmall,
      decoration: BoxDecoration(
        color: appColor.white,
        borderRadius: BorderRadius.circular(8).w,
        border: Border.all(
            width: 1,
            color: color.withOpacity(.2),
            strokeAlign: BorderSide.strokeAlignCenter),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF5F5F5).withOpacity(.2),
            blurRadius: 12,
            offset: const Offset(0, 3),
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Project',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: context.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        letterSpacing: .5,
                        color: appColor.brand800),
                  ),
                  Text(
                    task.projectName ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: context.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600, letterSpacing: .5),
                  ),
                ],
              ),
              Dimensions.kSpacer,
              leaveTag(
                context,
                label: (task.status ?? "").toUpperCase(),
                color: color,
              ),
            ],
          ),
          Dimensions.kVerticalSpaceSmaller,
          Text(
            'Task',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: context.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w400,
                letterSpacing: .5,
                color: appColor.brand800),
          ),
          Text(
            task.task ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: 6,
            style: context.textTheme.labelLarge
                ?.copyWith(fontWeight: FontWeight.w500, letterSpacing: .5),
          ),
          Dimensions.kVerticalSpaceSmaller,
          Row(
            children: [
              SvgPicture.asset(
                AppSvg.calendar,
                width: 16,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
              Dimensions.kHorizontalSpaceSmaller,
              Text('Task Date :',
                  style: context.textTheme.labelMedium
                      ?.copyWith(fontWeight: FontWeight.bold, color: color)),
              Dimensions.kHorizontalSpaceSmall,
              Text(task.taskDate ?? '',
                  style: context.textTheme.labelMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          Dimensions.kVerticalSpaceSmallest,
          Row(
            children: [
              SvgPicture.asset(
                AppSvg.calendar,
                width: 16,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
              Dimensions.kHorizontalSpaceSmaller,
              Text('Target Date :',
                  style: context.textTheme.labelMedium
                      ?.copyWith(fontWeight: FontWeight.bold, color: color)),
              Dimensions.kHorizontalSpaceSmall,
              Text(task.targetDate ?? '',
                  style: context.textTheme.labelMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: appColor.white,
      borderRadius: Dimensions.kBorderRadiusAllSmallest,
      border: Border.all(width: 1, color: appColor.gray400),
    );
  }

  Widget leaveTag(BuildContext context,
      {required Color color, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4).w,
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(8).w,
      ),
      child: Text(
        label,
        style: context.textTheme.labelMedium
            ?.copyWith(fontWeight: FontWeight.w500, color: color),
      ),
    );
  }
}
