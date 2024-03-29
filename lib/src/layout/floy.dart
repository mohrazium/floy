part of floy;

class Floy extends StatelessWidget {
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  static GlobalKey<NavigatorState> outletNavigatorKey = GlobalKey();

  final String? title;
  final Object? appBar;
  final Widget routerWidget;
  final Widget? rightPanel;
  final Widget? leftPanel;
  final bool extendBodyBehindAppBar;
  final FloyBottomSheet? bottomSheet;
  final double flexes;
  final Icon? drawerIcon;
  final String? drawerToolTip;
  final Icon? endDrawerIcon;
  final String? endDrawerToolTip;

  const Floy({
    Key? key,
    this.title,
    this.appBar,
    required this.routerWidget,
    this.rightPanel,
    this.leftPanel,
    this.extendBodyBehindAppBar = false,
    this.bottomSheet,
    this.flexes = 1,
    this.drawerIcon,
    this.drawerToolTip,
    this.endDrawerIcon,
    this.endDrawerToolTip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: getAppBar(context),
      drawer: leftPanel.isNotNull()
          ? isPanelsInDrawer(context)
              ? Drawer(child: leftPanel)
              : null
          : null,
      endDrawer: rightPanel.isNotNull()
          ? isPanelsInDrawer(context) && rightPanel.isNotNull()
              ? Drawer(child: rightPanel)
              : null
          : null,
      body: Row(
        children: [
          if (leftPanel.isNotNull() &&
              (FloyResponsive.isLargeScreen(context) ||
                  FloyResponsive.isXLargeScreen(context) ||
                  FloyResponsive.isXXLargeScreen(context)))
            Expanded(child: leftPanel!)
          else
            Container(),
          Expanded(
              flex: leftPanel.isNotNull() && rightPanel.isNotNull()
                  ? 4 ~/ flexes
                  : leftPanel.isNotNull() || rightPanel.isNotNull()
                      ? 5 ~/ flexes
                      : 1,
              child: routerWidget),
          if (rightPanel.isNotNull() &&
              (FloyResponsive.isLargeScreen(context) ||
                  FloyResponsive.isXLargeScreen(context) ||
                  FloyResponsive.isXXLargeScreen(context)))
            Expanded(child: rightPanel!)
        ],
      ),
      bottomSheet: bottomSheet,
    );
  }

  PreferredSizeWidget? getAppBar(context) {
    if (appBar != null && appBar is AppBar) {
      final castedAppBar = appBar! as AppBar;
      return FloyAppBar.copyWith(
          appBar: castedAppBar,
          leading: _handleDrawer(context),
          actions: _getActions(context, castedAppBar));
    } else if (appBar != null && appBar is SliverAppBar) {
      final sAppBar = appBar! as SliverAppBar;
      return FloySliverAppBar.copyWith(
        sliverAppBar: sAppBar,
        leading: _handleDrawer(context),
        actions: _getActions(context, sAppBar),
      ) as PreferredSizeWidget?;
    }
    return null;
  }

  List<Widget>? _getActions(context, appBar) {
    List<Widget>? actions = List.empty(growable: true);
    if (appBar != null && appBar?.actions != null) actions.addAll(appBar!.actions!);
    if (isPanelsInDrawer(context) && rightPanel.isNotNull()) {
      actions.add(IconButton(
        icon: endDrawerIcon ?? const Icon(Icons.more_vert),
        onPressed: () {
          scaffoldKey.currentState?.openEndDrawer();
        },
        tooltip: endDrawerToolTip ?? MaterialLocalizations.of(context).openAppDrawerTooltip,
      ));
    } else {
      scaffoldKey.currentState?.closeEndDrawer();
      if (appBar?.actions != null) actions.addAll(appBar!.actions!);
    }
    return actions;
  }

  bool isPanelsInDrawer(context) =>
      FloyResponsive.isMediumSmallScreen(context) ||
      FloyResponsive.isMediumScreen(context) ||
      FloyResponsive.isSmallScreen(context) ||
      FloyResponsive.isXSmallScreen(context);

  Widget? _handleDrawer(context) {
    if (isPanelsInDrawer(context) && leftPanel.isNotNull()) {
      return IconButton(
        icon: drawerIcon ?? const Icon(Icons.menu),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
        tooltip: drawerToolTip ?? MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    } else {
      scaffoldKey.currentState?.closeDrawer();
      return null;
    }
  }
}
