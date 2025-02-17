import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../chat.dart';

class ChatMessageScreen extends StatefulWidget {
  final ChatContact contact;

  const ChatMessageScreen({super.key, required this.contact});

  @override
  State<ChatMessageScreen> createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends State<ChatMessageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  bool _isUserScrolling = false;

  @override
  void initState() {
    super.initState();
    initialCallBack();
    _startPeriodicFetch();
    _scrollController.addListener(_scrollListener);
  }

  void initialCallBack() {
    BlocProvider.of<MessageContentCubit>(context, listen: false)
        .fetchMessageContent(widget.contact.employeeId ?? 0);
  }

  void _startPeriodicFetch() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        BlocProvider.of<MessageContentCubit>(context, listen: false)
            .refreshMessageContent(widget.contact.employeeId ?? 0);
      }
    });
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection !=
        ScrollDirection.idle) {
      setState(() => _isUserScrolling = true);
    } else {
      setState(() => _isUserScrolling = false);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
    if (_scrollController.hasClients && !_isUserScrolling) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 10),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appColor.gray50,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 56.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          centerTitle: false,
          titleWidget: _buildTitleWidgetUI(),
        ),
      ),
      body: BlocListener<ChatCrudBloc, ChatCrudState>(
        listener: (context, state) {
          if (state is ChatCrudSuccess) {
            messageController.clear();
            initialCallBack();
          }
        },
        child: _buildBodyUI(),
      ),
    );
  }

  Widget _buildTitleWidgetUI() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: appColor.brand100.withOpacity(.7),
          backgroundImage: widget.contact.avatar == null
              ? null
              : CachedNetworkImageProvider(
                  "${ApiUrl.baseUrl}public/${widget.contact.avatar}"),
          child: widget.contact.avatar == null
              ? Text(
                  widget.contact.employeeName!.split('').first.toUpperCase(),
                  style: context.textTheme.headlineSmall
                      ?.copyWith(color: appColor.brand700),
                )
              : null,
        ),
        Dimensions.kHorizontalSpaceSmaller,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.contact.employeeName ?? "",
                style: context.textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w500)),
            SizedBox(height: 1.h),
            Text(widget.contact.departmentName ?? "",
                style: context.textTheme.labelMedium
                    ?.copyWith(color: appColor.gray600)),
          ],
        ),
      ],
    );
  }

  Widget _buildBodyUI() {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<MessageContentCubit, MessageContentState>(
            builder: (context, state) {
              if (state is MessageContentLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is MessageContentLoaded) {
                final messages = state.message.messageContent;
                if (messages!.isEmpty) {
                  return Container();
                }
                WidgetsBinding.instance
                    .addPostFrameCallback((_) => _scrollToEnd());
                return ListView.separated(
                  controller: _scrollController,
                  padding: Dimensions.kPaddingAllMedium,
                  physics: const AlwaysScrollableScrollPhysics(),
                  dragStartBehavior: DragStartBehavior.down,
                  itemBuilder: (_, i) {
                    return Message(message: messages[i]);
                  },
                  separatorBuilder: (_, i) {
                    return Dimensions.kVerticalSpaceSmaller;
                  },
                  itemCount: messages.length,
                );
              }
              return Container();
            },
          ),
        ),
        ChatInputField(
          messageController: messageController,
          onPressed: onSubmit,
        ),
      ],
    );
  }

  void onSubmit() {
    if (messageController.text.isNotEmpty) {
      final body = {
        "message_content": messageController.text,
        "receiver_id": widget.contact.employeeId ?? 0,
      };

      Logger().t("Submit Body: $body");

      BlocProvider.of<ChatCrudBloc>(context).add(SaveMessageEvent(body: body));
    }
  }
}
