part of flayout;

final GlobalKey<ScaffoldState> fLayoutScaffoldKey = GlobalKey();

class FLayout extends StatelessWidget {
  final AppBar? appBar;
  final FResponsive content;
  final Widget? rightPanel;
  final Widget? leftPanel;
  final bool extendBodyBehindAppBar;
  final FBottomSheet? bottomSheet;
  final int flexes;

  const FLayout({
    Key? key,
    this.appBar,
    this.rightPanel,
    this.leftPanel,
    this.bottomSheet,
    required this.content,
    this.extendBodyBehindAppBar = false,
    this.flexes = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: fLayoutScaffoldKey,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: appBar,
      drawer: leftPanel != null
          ? FResponsive.isMediumSmallScreen(context) ||
                  FResponsive.isMediumScreen(context) ||
                  FResponsive.isSmallScreen(context) ||
                  FResponsive.isXSmallScreen(context)
              ? Drawer(child: leftPanel)
              : null
          : null,
      endDrawer: rightPanel != null
          ? FResponsive.isMediumSmallScreen(context) ||
                  FResponsive.isMediumScreen(context) ||
                  FResponsive.isSmallScreen(context) ||
                  FResponsive.isXSmallScreen(context)
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
              child: content),
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
}
