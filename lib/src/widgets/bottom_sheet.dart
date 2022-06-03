part of flayout;

class FBottomSheet extends StatelessWidget {
  final double size;
  final double elevation;
  final List<Widget> actions;
  final Color? color;
  const FBottomSheet({
    Key? key,
    this.size = 30,
    required this.actions,
    this.color,
    this.elevation = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size,
        child: Material(
          elevation: elevation,
          color: color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: actions,
          ),
        ));
  }
}
