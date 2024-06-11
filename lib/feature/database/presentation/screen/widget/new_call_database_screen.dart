import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../feature.dart';

class NewCallDatabaseScreen extends StatefulWidget {
  const NewCallDatabaseScreen({super.key});

  @override
  State<NewCallDatabaseScreen> createState() => _NewCallDatabaseScreenState();
}

class _NewCallDatabaseScreenState extends State<NewCallDatabaseScreen> {
  final ScrollController _scrollController = ScrollController();

  final int _perPage = 10;
  int _page = 1;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialCallBack();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page++;
        initialCallBack();
      }
    });
  }

  Future<void> initialCallBack() async {
    context.read<NewCallDatabaseBloc>().add(FetchNewCall(
        search: searchController.text, page: _page, perPage: _perPage));
  }

  Future<void> refreshCallBack() async {
    _page = 1;
    context.read<NewCallDatabaseBloc>().add(RefreshFetchNewCall(
        search: searchController.text, page: _page, perPage: _perPage));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DatabaseSearchWidget(
          controller: searchController,
          onPressed: refreshCallBack,
          onChanged: (val) => refreshCallBack(),
        ),
        BlocBuilder<NewCallDatabaseBloc, NewCallDatabaseState>(
          builder: (context, state) {
            if (state is NewCallDatabaseLoading && _page == 1) {
              return const Expanded(child: DatabaseCardShimmerWidget());
            }
            if (state is NewCallDatabaseFailed) {
              return EmptyScreen(onPressed: refreshCallBack);
            }
            if (state is NewCallDatabaseLoaded) {
              if (state.database.isEmpty) {
                return EmptyScreen(onPressed: refreshCallBack);
              }
              // if (state.hasReachedMax) {
              //   Fluttertoast.showToast(msg: 'End of list');
              // }
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: refreshCallBack,
                  child: ListView.separated(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: Dimensions.kPaddingAllMedium.copyWith(top: 12),
                    itemCount: state.hasReachedMax
                        ? state.database.length
                        : state.database.length + 1,
                    itemBuilder: (_, i) {
                      if (i >= state.database.length) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return DatabaseCardWidget(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          AppRouterPath.newCallDatabaseUpdateScreen,
                          arguments: NewCallDatabaseUpdateScreen(
                              database: state.database[i]),
                        ).then((value) => refreshCallBack()),
                        database: state.database[i],
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
}
