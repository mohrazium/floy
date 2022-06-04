part of flayout;

class FMenu extends StatefulWidget {
  final List<FMenuItem> items;
  final BorderRadius? itemsBorderRadius;
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

int _selectedItem = 0;
int _hoveredItem = 0;

class _FMenuState extends State<FMenu> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: widget.backgroundColor,
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
                      },
                      isSelected: _selectedItem == item.key,
                      onHover: (isHovered) {
                        setState(() {
                          if (isHovered) {
                            _hoveredItem = item.key;
                          } else {
                            _hoveredItem = 0;
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
    this.iconSize,
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
    final button = InkWell(
      onTap: onPressed,
      onHover: (isHovered) => onHover(isHovered),
      borderRadius: borderRadius,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(15),
        child: FResponsive.isLargeScreen(context)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _buildIcon(context),
                      const SizedBox(width: 5),
                      _buildLabel(context),
                    ],
                  ),
                  _buildNotify(context),
                ],
              ),
      ),
    );
    return Material(
        color: _onColorChanged(context)?.withOpacity(0.1) ?? Colors.transparent,
        borderRadius: borderRadius,
        child: item.description != null
            ? Tooltip(
                message: item.description,
                waitDuration: const Duration(seconds: 5),
                showDuration: const Duration(seconds: 2),
                child: button,
              )
            : button);
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

    return Container();
  }
}
