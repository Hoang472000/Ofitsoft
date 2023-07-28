import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../resource/assets.dart';
import '../../resource/color.dart';

///Bkav TungDV: custom lại Appbar dùng chung cho cả App
class BkavAppBar extends AppBar {
  final BuildContext context;

  static Widget defaultBackButton(BuildContext context, Color color) {
    return Container(
      padding: const EdgeInsets.only(left: 6),
      child: IconButton(
        icon: SvgPicture.asset(
          IconAsset.icArrowLeft,
          height: 20,
          color:color.value==AppColor.main.value? AppColor.whiteF2:AppColor.whiteF2
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        color: Colors.white,
        padding: EdgeInsets.zero,
      ),
    );
  }

  BkavAppBar(
      this.context, {
        required bool showDefaultBackButton,
        bool hasBottom=false,
        bool centerTitle = false,
        double toolbarHeight = 56,
        double elevation = 0,
        Key? key,
        Widget? leading,
        bool automaticallyImplyLeading = false,
        Widget? title,
        List<Widget>? actions,
        Widget? flexibleSpace,
        PreferredSizeWidget? bottom,
        Color? shadowColor,
        ShapeBorder? shape,
        Color? backgroundColor = AppColor.main,
        Color? foregroundColor,
        Brightness? brightness,
        IconThemeData? iconTheme,
        IconThemeData? actionsIconTheme,
        TextTheme? textTheme,
        bool primary = true,
        bool excludeHeaderSemantics = false,
        double? titleSpacing,
        double toolbarOpacity = 1.0,
        // double bottomOpacity = 0.5,
        double? leadingWidth = 34,
        bool? backwardsCompatibility,
        TextStyle? toolbarTextStyle,
        TextStyle? titleTextStyle,
        SystemUiOverlayStyle? systemOverlayStyle = SystemUiOverlayStyle.dark,
      }) : super(
      key: key,
      leading:
      showDefaultBackButton ? defaultBackButton(context, backgroundColor??Colors.white) : leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: title,
      actions: actions,
      flexibleSpace: flexibleSpace ?? Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.main, AppColor.green99], // Đặt 2 màu ở đây
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
      bottom:hasBottom? bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.main, AppColor.green99], // Đặt 2 màu ở đây
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            height: 1,
          )),
      elevation: elevation,
      shadowColor: shadowColor,
      shape: shape,
      backgroundColor: backgroundColor,
      // foregroundColor: foregroundColor,
      //brightness: brightness,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      primary: primary,
      centerTitle: centerTitle,
      excludeHeaderSemantics: excludeHeaderSemantics,
      titleSpacing: titleSpacing,
      toolbarOpacity: toolbarOpacity,
      //bottomOpacity: bottomOpacity,
      toolbarHeight: toolbarHeight,
      leadingWidth: leadingWidth,
      toolbarTextStyle: toolbarTextStyle,
      titleTextStyle: titleTextStyle,
      systemOverlayStyle:
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark
      )
  );
}
