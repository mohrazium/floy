part of flayout;

int _selectedItem = 0;
int _hoveredItem = 0;

class FMenu extends StatefulWidget {
  final List<FMenuItem> items;
  final BorderRadius? itemsBorderRadius;
  final BorderRadius? borderRadius;
  final BorderRadius? badgeBorderRadius;
  final EdgeInsets? itemsPadding;
  final Widget? header;
  final Widget? footer;
  final Color? itemsBackgroundColor;
  final Color? backgroundColor;

  const FMenu({
    Key? key,
    required this.items,
    this.itemsBorderRadius,
    this.borderRadius,
    this.badgeBorderRadius,
    this.itemsPadding,
    this.header,
    this.footer,
    this.itemsBackgroundColor,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<FMenu> createState() => _FMenuState();
}

class _FMenuState extends State<FMenu> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.backgroundColor,
      borderRadius: widget.borderRadius,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.header ?? Container(),
            Expanded(
              child: ListView(
                children: widget.items.asMap().entries.map((item) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FMenuButton(
                      badgeBorderRadius: widget.badgeBorderRadius,
                      borderRadius: widget.itemsBorderRadius,
                      padding: widget.itemsPadding,
                      item: item.value,
                      backgroundColor: widget.itemsBackgroundColor,
                      onPressed: () {
                        item.value.onTap();
                        setState(() {
                          _selectedItem = item.key;
                        });

                        if (fLayoutScaffoldKey.currentState!.isDrawerOpen) {
                          fLayoutScaffoldKey.currentState?.closeDrawer();
                        }
                        if (fLayoutScaffoldKey.currentState!.isEndDrawerOpen) {
                          fLayoutScaffoldKey.currentState?.closeEndDrawer();
                        }
                      },
                      isSelected: _selectedItem == item.key,
                      onHover: (isHovered) {
                        setState(() {
                          if (isHovered) {
                            _hoveredItem = item.key;
                          } else {
                            _hoveredItem = _selectedItem;
                          }
                        });
                      },
                      isHovered: _hoveredItem == item.key,
                    ),
                  );
                }).toList(),
              ),
            ),
            widget.footer ?? Container(),
          ],
        ),
      ),
    );
  }
}

class FMenuItem {
  final String title;
  final String name;
  final String? description;
  final IconData? icon;
  final double? iconSize;
  final IconData? activeIcon;
  final Function() onTap;
  final int? totalNotify;

  FMenuItem({
    required this.title,
    required this.name,
    this.description,
    this.icon,
    this.iconSize = 24,
    this.activeIcon,
    required this.onTap,
    this.totalNotify,
  });
}

class FMenuButton extends StatelessWidget {
  final bool isSelected;
  final bool isHovered;
  final FMenuItem item;
  final Function() onPressed;
  final Function(bool) onHover;
  final BorderRadius? borderRadius;
  final BorderRadius? badgeBorderRadius;
  final EdgeInsets? padding;
  final Color? backgroundColor;

  const FMenuButton({
    Key? key,
    required this.isSelected,
    required this.isHovered,
    required this.item,
    required this.onPressed,
    required this.onHover,
    this.borderRadius,
    this.badgeBorderRadius,
    this.padding,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        animationDuration: const Duration(milliseconds: 500),
        color: _onColorChanged(context)?.withOpacity(0.1) ?? Colors.transparent,
        borderRadius: borderRadius,
        child: item.description != null
            ? Tooltip(
                message: item.description,
                waitDuration: const Duration(seconds: 5),
                showDuration: const Duration(seconds: 2),
                child: _buildInkButton(context),
              )
            : _buildInkButton(context));
  }

  Widget _buildInkButton(context) {
    return InkWell(
      onTap: onPressed,
      onHover: (isHovered) => onHover(isHovered),
      borderRadius: borderRadius,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(15),
        child: FResponsive.isLargeScreen(context)
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIndicator(context, (item.iconSize ?? 24) * 2),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: 5),
                        _buildNotify(
                          context,
                          Column(
                            children: [
                              _buildIcon(context),
                              const SizedBox(width: 5),
                              _buildLabel(context),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5.0),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildIndicator(context, item.iconSize),
                  const SizedBox(width: 5.0),
                  Row(
                    children: [
                      _buildIcon(context),
                      const SizedBox(width: 5),
                      _buildLabel(context),
                    ],
                  ),
                  const Spacer(),
                  _buildNotify(context),
                ],
              ),
      ),
    );
  }

  Color? _onColorChanged(context) {
    if (isSelected) {
      return Theme.of(context).primaryColor;
    } else if (isHovered) {
      return Theme.of(context).primaryColor;
    }
    return backgroundColor;
  }

  Widget _buildIcon(context) {
    return Icon(
        (isSelected)
            ? item.activeIcon ?? Icons.account_tree
            : item.icon ?? Icons.account_tree_outlined,
        size: item.iconSize,
        color: _onColorChanged(context));
  }

  Widget _buildLabel(context) {
    return Text(
      item.title,
      style: TextStyle(
        color: _onColorChanged(context),
        fontWeight: FontWeight.bold,
        letterSpacing: .8,
        fontSize: 14,
      ),
    );
  }

  Widget _buildNotify(context, [Widget? child]) {
    if (item.totalNotify != null) {
      if (item.totalNotify! > 0) {
        return Badge(
            elevation: 0,
            toAnimate: false,
            alignment: Alignment.topLeft,
            shape: BadgeShape.square,
            position: const BadgePosition(top: -10, end: -25),
            borderRadius: badgeBorderRadius ?? const BorderRadius.all(Radius.circular(10)),
            badgeColor: Colors.orangeAccent,
            badgeContent: Text(
              (item.totalNotify! >= 100) ? "99+" : "${item.totalNotify}",
              style: TextStyle(
                  color: Colors.white, fontSize: Theme.of(context).textTheme.caption?.fontSize),
            ),
            child: child);
      }
    }

    return Container(child: child);
  }

  Widget _buildIndicator(context, size) {
    return AnimatedContainer(
      width: isSelected ? 5 : 0,
      height: isSelected ? size : 0,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(15)),
      ),
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }
}
