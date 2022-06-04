part of flayout;

final GlobalKey<ScaffoldState> fLayoutScaffoldKey = GlobalKey();

class FLayout extends StatelessWidget {
  final AppBar? appBar;
  final FResponsive content;
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
    this.appBar,
    this.rightPanel,
    this.leftPanel,
    this.bottomSheet,
    required this.content,
    this.extendBodyBehindAppBar = false,
    this.flexes = 1,
    this.drawerIcon,
    this.drawerToolTip,
    this.endDrawerIcon,
    this.endDrawerToolTip,
  }) : super(key: key);

  List<Widget>? getActions(context) {
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

  @override
  Widget build(BuildContext context) {
    Widget? _handleDrawer() {
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

    return Scaffold(
      key: fLayoutScaffoldKey,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar:
          FAppBar.copyWith(appBar: appBar!, leading: _handleDrawer(), actions: getActions(context)),
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
      body: AnimatedContainer(
          duration: const Duration(milliseconds: 5000),
          child: Row(
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
                  child: content),
              if (rightPanel != null &&
                  (FResponsive.isLargeScreen(context) ||
                      FResponsive.isXLargeScreen(context) ||
                      FResponsive.isXXLargeScreen(context)))
                Expanded(child: rightPanel!)
            ],
          )),
      bottomSheet: bottomSheet,
    );
  }
}
