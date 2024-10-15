import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final Color? backgroundColor;
  final bool? centerTile;
  final List<Widget>? actions;
  const CustomAppBarWidget(
      {super.key,
      this.leading,
      this.title,
      this.backgroundColor,
      this.centerTile,
      this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      backgroundColor: backgroundColor,
      leading: leading,
      title: title,
      centerTitle: centerTile,
      actions: actions,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
