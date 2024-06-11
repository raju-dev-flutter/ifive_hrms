import 'package:flutter/material.dart';

import '../../config/config.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback onPressed;
  final String? title;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final Widget? titleWidget;
  final bool? centerTitle;

  const CustomAppBar(
      {super.key,
      required this.onPressed,
      this.title,
      this.bottom,
      this.actions,
      this.centerTitle,
      this.titleWidget});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appColor.white,
      leading: IconButton(
        onPressed: onPressed,
        icon: Icon(Icons.arrow_back, color: appColor.gray600),
      ),
      actions: actions,
      centerTitle: centerTitle ?? true,
      title: titleWidget ??
          Text(title ?? "", style: context.textTheme.headlineSmall),
      bottom: bottom ??
          PreferredSize(
            preferredSize: Size(context.deviceSize.width, 1),
            child: Container(
              height: 1,
              width: context.deviceSize.width,
              color: appColor.gray300.withOpacity(.3),
            ),
          ),
    );
  }
}
