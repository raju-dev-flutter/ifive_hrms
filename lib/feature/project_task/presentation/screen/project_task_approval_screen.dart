import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../project_task.dart';

class ProjectTaskApprovalScreen extends StatefulWidget {
  const ProjectTaskApprovalScreen({super.key});

  @override
  State<ProjectTaskApprovalScreen> createState() =>
      _ProjectTaskApprovalScreenState();
}

class _ProjectTaskApprovalScreenState extends State<ProjectTaskApprovalScreen> {
  final ScrollController _scrollController = ScrollController();

  final int _perPage = 10;
  int _page = 1;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    refreshCallBack();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page++;
        initialCallBack();
      }
    });
  }

  Future<void> initialCallBack() async {
    context.read<CommonProjectTaskBloc>().add(FetchCommonProjectTask(
        type: "update",
        search: searchController.text,
        date: '',
        page: _page,
        perPage: _perPage));
  }

  Future<void> refreshCallBack() async {
    _page = 1;
    context.read<CommonProjectTaskBloc>().add(RefreshFetchCommonProjectTask(
        type: "update",
        search: searchController.text,
        date: '',
        page: _page,
        perPage: _perPage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor.gray100,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: "Task Approval",
        ),
      ),
      body: _buildBodyUI(),
    );
  }

  Widget _buildBodyUI() {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 6).w,
          child: TextFormField(
            controller: searchController,
            keyboardType: TextInputType.text,
            enableSuggestions: true,
            obscureText: false,
            enableInteractiveSelection: true,
            style: context.textTheme.bodySmall,
            onChanged: (val) => refreshCallBack(),
            decoration: inputDecoration(
                label: 'Search', onPressed: () => refreshCallBack()),
          ),
        ),
        BlocBuilder<CommonProjectTaskBloc, CommonProjectTaskState>(
          builder: (context, state) {
            if (state is CommonProjectTaskLoading && _page == 1) {
              return Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6).w,
                  itemBuilder: (_, i) {
                    return const TaskCardShimmerWidget();
                  },
                ),
              );
            }
            if (state is CommonProjectTaskFailed) {
              return Expanded(child: EmptyScreen(onPressed: refreshCallBack));
            }

            if (state is CommonProjectTaskLoaded) {
              if (state.task.isEmpty) {
                return Expanded(child: EmptyScreen(onPressed: refreshCallBack));
              }
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: refreshCallBack,
                  child: ListView.separated(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: Dimensions.kPaddingAllMedium.copyWith(top: 12),
                    itemCount: state.hasReachedMax
                        ? state.task.length
                        : state.task.length + 1,
                    itemBuilder: (_, i) {
                      if (i >= state.task.length) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ProjectTaskDetailCardWidget(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRouterPath.projectTaskApprovalFormScreen,
                            arguments: ProjectTaskApprovalFormScreen(
                                task: state.task[i]),
                          ).whenComplete(() => refreshCallBack());
                        },
                        task: state.task[i],
                      );
                    },
                    separatorBuilder: (_, __) =>
                        Dimensions.kVerticalSpaceSmaller,
                  ),
                ),
              );
            }

            return Container();
          },
        ),
      ],
    );
  }

  InputDecoration inputDecoration(
      {required String label, required Function() onPressed}) {
    return InputDecoration(
      suffixIcon: InkWell(onTap: onPressed, child: const Icon(Icons.search)),
      fillColor: appColor.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.gray200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.white.withOpacity(.4)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.purple600),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6).w,
        borderSide: BorderSide(color: appColor.error600),
      ),
      labelText: "$label...",
      labelStyle:
          context.textTheme.labelMedium?.copyWith(color: appColor.gray300),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0).w,
      errorStyle:
          context.textTheme.labelMedium?.copyWith(color: appColor.error600),
    );
  }
}
