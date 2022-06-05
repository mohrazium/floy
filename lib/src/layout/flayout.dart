part of flayout;

final GlobalKey<ScaffoldState> fLayoutScaffoldKey = GlobalKey();

class FLayout extends StatelessWidget {
  final String? title;
  final AppBar? appBar;
  final Widget materialAppHolder;
  final Widget? rightPanel;
  final Widget? leftPanel;
  final bool extendBodyBehindAppBar;
  final FBottomSheet? bottomSheet;
  final double flexes;
  final Icon? drawerIcon;
  final String? drawerToolTip;
  final Icon? endDrawerIcon;
  final String? endDrawerToolTip;

  const FLayout({
    Key? key,
    this.title,
    this.appBar,
    required this.materialAppHolder,
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
      key: fLayoutScaffoldKey,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: FAppBar.copyWith(
          appBar: appBar!, leading: _handleDrawer(context), actions: _getActions(context)),
      drawer: leftPanel != null
          ? isPanelsInDrawer(context)
              ? Drawer(child: leftPanel)
              : null
          : null,
      endDrawer: rightPanel != null
          ? isPanelsInDrawer(context)
              ? Drawer(child: rightPanel)
              : null
          : null,
      body: Row(
        children: [
          if (leftPanel != null &&
              (FResponsive.isLargeScreen(context) ||
                  FResponsive.isXLargeScreen(context) ||
                  FResponsive.isXXLargeScreen(context)))
            Expanded(child: leftPanel!)
          else
            Container(),
          Expanded(
              flex: leftPanel != null && rightPanel != null
                  ? 4 ~/ flexes
                  : leftPanel != null || rightPanel != null
                      ? 5 ~/ flexes
                      : 1,
              child: materialAppHolder),
          if (rightPanel != null &&
              (FResponsive.isLargeScreen(context) ||
                  FResponsive.isXLargeScreen(context) ||
                  FResponsive.isXXLargeScreen(context)))
            Expanded(child: rightPanel!)
        ],
      ),
      bottomSheet: bottomSheet,
    );
  }

  List<Widget>? _getActions(context) {
    List<Widget>? actions = List.empty(growable: true);
    if (appBar?.actions != null) actions.addAll(appBar!.actions!);
    if (isPanelsInDrawer(context) && rightPanel != null) {
      actions.add(IconButton(
        icon: endDrawerIcon ?? const Icon(Icons.more_vert),
        onPressed: () {
          fLayoutScaffoldKey.currentState?.openEndDrawer();
        },
        tooltip: endDrawerToolTip ?? MaterialLocalizations.of(context).openAppDrawerTooltip,
      ));
    } else {
      fLayoutScaffoldKey.currentState?.closeEndDrawer();
      if (appBar?.actions != null) actions.addAll(appBar!.actions!);
    }
    return actions;
  }

  bool isPanelsInDrawer(context) =>
      FResponsive.isMediumSmallScreen(context) ||
      FResponsive.isMediumScreen(context) ||
      FResponsive.isSmallScreen(context) ||
      FResponsive.isXSmallScreen(context);

  Widget? _handleDrawer(context) {
    if (isPanelsInDrawer(context)) {
      return IconButton(
        icon: drawerIcon ?? const Icon(Icons.menu),
        onPressed: () {
          fLayoutScaffoldKey.currentState?.openDrawer();
        },
        tooltip: drawerToolTip ?? MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    } else {
      fLayoutScaffoldKey.currentState?.closeDrawer();
      return null;
    }
  }
}
