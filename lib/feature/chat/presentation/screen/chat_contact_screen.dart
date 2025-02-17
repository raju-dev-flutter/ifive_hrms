import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../chat.dart';

class ChatContactScreen extends StatefulWidget {
  const ChatContactScreen({super.key});

  @override
  State<ChatContactScreen> createState() => _ChatContactScreenState();
}

class _ChatContactScreenState extends State<ChatContactScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    initialCallBack();
  }

  void initialCallBack() {
    BlocProvider.of<ChatContactCubit>(context, listen: false)
        .fetchChatContact();
  }

  Future<void> _onRefresh() async {
    BlocProvider.of<ChatContactCubit>(context, listen: false)
        .fetchChatContact();
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
          centerTitle: false,
          titleWidget: BlocBuilder<ChatContactCubit, ChatContactState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select Contact", style: context.textTheme.bodySmall),
                  if (state is ChatContactLoaded)
                    Text(
                      "${state.chatContactModel.chatContactCount} Contacts",
                      style: context.textTheme.labelSmall,
                    ),
                ],
              );
            },
          ),
        ),
      ),
      body: _buildBodyUI(),
    );
  }

  _buildBodyUI() {
    return BlocBuilder<ChatContactCubit, ChatContactState>(
      builder: (context, state) {
        if (state is ChatContactLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ChatContactLoaded) {
          final chatContact = state.chatContactModel.chatContact;
          if (chatContact!.isEmpty) {
            return Center(child: EmptyScreen(onPressed: _onRefresh));
          }
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.separated(
              padding: Dimensions.kPaddingAllMedium,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (_, i) {
                return _buildContactDetail(chatContact[i]);
              },
              separatorBuilder: (_, i) {
                return Dimensions.kVerticalSpaceMedium;
              },
              itemCount: chatContact.length,
            ),
          );
        }
        if (state is ChatContactFailure) {
          return Center(child: EmptyScreen(onPressed: _onRefresh));
        }
        return Container();
      },
    );
  }

  _buildContactDetail(ChatContact contact) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRouterPath.chatMessageScreen,
            arguments: ChatMessageScreen(contact: contact));
      },
      hoverColor: appColor.gray50,
      highlightColor: appColor.gray50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: appColor.brand100.withOpacity(.7),
            backgroundImage: contact.avatar == null
                ? null
                : CachedNetworkImageProvider(
                    "${ApiUrl.baseUrl}public/${contact.avatar}"),
            child: contact.avatar == null
                ? Text(
                    contact.employeeName!.split('').first.toUpperCase(),
                    style: context.textTheme.headlineSmall
                        ?.copyWith(color: appColor.brand700),
                  )
                : null,
          ),
          Dimensions.kHorizontalSpaceSmall,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(contact.employeeName ?? "",
                  style: context.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w500)),
              SizedBox(height: 1.h),
              Text(contact.departmentName ?? "",
                  style: context.textTheme.labelLarge
                      ?.copyWith(color: appColor.gray600)),
            ],
          ),
        ],
      ),
    );
  }
}
