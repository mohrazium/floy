part of flayout;

const int _extraSmallSize = 414;
const int _smallSize = 640;
const int _mediumSmallSize = 768;
const int _mediumSize = 1024;
const int _largeSize = 1366;
const int _xLargeSize = 1920;

class FResponsive extends StatelessWidget {
  final Widget? extraSmallPage;
  final Widget? smallPage;
  final Widget? mediumSmallPage;
  final Widget mediumPage;
  final Widget? largePage;
  final Widget? xLargePage;
  final Widget? xxLargePage;

  const FResponsive({
    Key? key,
    this.extraSmallPage,
    this.smallPage,
    this.mediumSmallPage,
    required this.mediumPage,
    this.largePage,
    this.xLargePage,
    this.xxLargePage,
  }) : super(key: key);

  static bool isXSmallScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < _extraSmallSize;
  }

  static bool isSmallScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= _extraSmallSize && width < _smallSize;
  }

  static bool isMediumSmallScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= _smallSize && width < _mediumSmallSize;
  }

  static bool isMediumScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= _mediumSmallSize && width < _mediumSize;
  }

  static bool isLargeScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= _mediumSize && width < _largeSize;
  }

  static bool isXLargeScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= _largeSize && width <= _xLargeSize;
  }

  static bool isXXLargeScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width > _xLargeSize;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < _extraSmallSize) {
        //! Extra Small Page
        return extraSmallPage ?? mediumPage;
      } else if (constraints.maxWidth >= _extraSmallSize && constraints.maxWidth < _smallSize) {
        //! Small Page
        return smallPage ?? mediumPage;
      } else if (constraints.maxWidth >= _smallSize && constraints.maxWidth < _mediumSmallSize) {
        //! Medium Small Page
        return mediumSmallPage ?? mediumPage;
      } else if (constraints.maxWidth >= _mediumSmallSize && constraints.maxWidth < _mediumSize) {
        //! Medium Page
        return mediumPage;
      } else if (constraints.maxWidth >= _mediumSize && constraints.maxWidth < _largeSize) {
        //! Large Page
        return largePage ?? mediumPage;
      } else if (constraints.maxWidth >= _largeSize && constraints.maxWidth <= _xLargeSize) {
        //! Extra Large Page
        return xLargePage ?? mediumPage;
      } else if (constraints.maxWidth > _xLargeSize) {
        //! 2Extra Large Page
        return xxLargePage ?? mediumPage;
      } else {
        //! Default

        return mediumPage;
      }
    });
  }
}
