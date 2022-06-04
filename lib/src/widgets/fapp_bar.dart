part of flayout;

class FAppBar {
  static AppBar copyWith({
    required AppBar appBar,
    double? toolbarHeight,
    Widget? leading,
    bool? automaticallyImplyLeading,
    Widget? title,
    List<Widget>? actions,
    Widget? flexibleSpace,
    PreferredSizeWidget? bottom,
    double? elevation,
    double? scrolledUnderElevation,
    Color? shadowColor,
    Color? surfaceTintColor,
    ShapeBorder? shape,
    Color? backgroundColor,
    Color? foregroundColor,
    Brightness? brightness,
    IconThemeData? iconTheme,
    IconThemeData? actionsIconTheme,
    TextTheme? textTheme,
    bool? primary,
    bool? centerTitle,
    bool? excludeHeaderSemantics,
    double? titleSpacing,
    double? toolbarOpacity,
    double? bottomOpacity,
    double? leadingWidth,
    bool? backwardsCompatibility,
    TextStyle? toolbarTextStyle,
    TextStyle? titleTextStyle,
    SystemUiOverlayStyle? systemOverlayStyle,
    bool? forceElevated,
    double? expandedHeight,
    double? collapsedHeight,
    double? topPadding,
    bool? floating,
    bool? pinned,
  }) {
    return AppBar(
      toolbarHeight: toolbarHeight ?? appBar.toolbarHeight,
      leading: leading ?? appBar.leading,
      automaticallyImplyLeading: automaticallyImplyLeading ?? appBar.automaticallyImplyLeading,
      title: title ?? appBar.title,
      actions: actions ?? appBar.actions,
      flexibleSpace: flexibleSpace ?? appBar.flexibleSpace,
      bottom: bottom ?? appBar.bottom,
      elevation: elevation ?? appBar.elevation,
      scrolledUnderElevation: scrolledUnderElevation ?? appBar.scrolledUnderElevation,
      shadowColor: shadowColor ?? appBar.shadowColor,
      surfaceTintColor: surfaceTintColor ?? appBar.surfaceTintColor,
      shape: shape ?? appBar.shape,
      backgroundColor: backgroundColor ?? appBar.backgroundColor,
      foregroundColor: foregroundColor ?? appBar.foregroundColor,
      // ignore: deprecated_member_use
      brightness: brightness ?? appBar.brightness,
      iconTheme: iconTheme ?? appBar.iconTheme,
      actionsIconTheme: actionsIconTheme ?? appBar.actionsIconTheme,
      // ignore: deprecated_member_use
      textTheme: textTheme ?? appBar.textTheme,
      primary: primary ?? appBar.primary,
      centerTitle: centerTitle ?? appBar.centerTitle,
      excludeHeaderSemantics: excludeHeaderSemantics ?? appBar.excludeHeaderSemantics,
      titleSpacing: titleSpacing ?? appBar.titleSpacing,
      toolbarOpacity: toolbarOpacity ?? appBar.toolbarOpacity,
      bottomOpacity: bottomOpacity ?? appBar.bottomOpacity,
      leadingWidth: leadingWidth ?? appBar.leadingWidth,
      // ignore: deprecated_member_use
      backwardsCompatibility: backwardsCompatibility ?? appBar.backwardsCompatibility,
      toolbarTextStyle: toolbarTextStyle ?? appBar.toolbarTextStyle,
      titleTextStyle: titleTextStyle ?? appBar.titleTextStyle,
      systemOverlayStyle: systemOverlayStyle ?? appBar.systemOverlayStyle,
    );
  }
}

 //TODO: Add Sliver app bar
    // required appBar.leading,
    // required appBar.automaticallyImplyLeading,
    // required appBar.title,
    // required appBar.actions,
    // required appBar.flexibleSpace,
    // required appBar.bottom,
    // required appBar.elevation,
    // required appBar.scrolledUnderElevation,
    // required appBar.shadowColor,
    // required appBar.surfaceTintColor,
    // required appBar.forceElevated,
    // required appBar.backgroundColor,
    // required appBar.foregroundColor,
    // required appBar.brightness,
    // required appBar.iconTheme,
    // required appBar.actionsIconTheme,
    // required appBar.textTheme,
    // required appBar.primary,
    // required appBar.centerTitle,
    // required appBar.excludeHeaderSemantics,
    // required appBar.titleSpacing,
    // required appBar.expandedHeight,
    // required appBar.collapsedHeight,
    // required appBar.topPadding,
    // required appBar.floating,
    // required appBar.pinned,
    // required appBar.vsync,
    // required appBar.snapConfiguration,
    // required appBar.stretchConfiguration,
    // required appBar.showOnScreenConfiguration,
    // required appBar.shape,
    // required appBar.toolbarHeight,
    // required appBar.leadingWidth,
    // required appBar.backwardsCompatibility,
    // required appBar.toolbarTextStyle,
    // required appBar.titleTextStyle,
    // required appBar.systemOverlayStyle,

// final Widget? leading;
//   final bool automaticallyImplyLeading;
//   final Widget? title;
//   final List<Widget>? actions;
//   final Widget? flexibleSpace;
//   final PreferredSizeWidget? bottom;
//   final double? elevation;
//   final double? scrolledUnderElevation;
//   final Color? shadowColor;
//   final Color? surfaceTintColor;
//   final bool forceElevated;
//   final Color? backgroundColor;
//   final Color? foregroundColor;
//   final Brightness? brightness;
//   final IconThemeData? iconTheme;
//   final IconThemeData? actionsIconTheme;
//   final TextTheme? textTheme;
//   final bool primary;
//   final bool? centerTitle;
//   final bool excludeHeaderSemantics;
//   final double? titleSpacing;
//   final double? expandedHeight;
//   final double collapsedHeight;
//   final double topPadding;
//   final bool floating;
//   final bool pinned;
//   final ShapeBorder? shape;
//   final double? toolbarHeight;
//   final double? leadingWidth;
//   final bool? backwardsCompatibility;
//   final TextStyle? toolbarTextStyle;
//   final TextStyle? titleTextStyle;
//   final SystemUiOverlayStyle? systemOverlayStyle;
//   final double _bottomHeight;