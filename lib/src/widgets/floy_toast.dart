part of floy;

extension FloyToaster on BuildContext {
  void showToast({
    required Widget content,
    Duration? duration,
    FloyToastPosition? position,
    EdgeInsets? edgesPadding,
  }) =>
      FloyToast.to(this).show(
        content: content,
        duration: duration,
        position: position,
        edgesPadding: edgesPadding,
      );
}

enum FloyToastPosition {
  topLeft(CrossAxisAlignment.start, MainAxisAlignment.start),
  topCenter(CrossAxisAlignment.center, MainAxisAlignment.start),
  topRight(CrossAxisAlignment.end, MainAxisAlignment.start),
  centerLeft(CrossAxisAlignment.start, MainAxisAlignment.center),
  center(CrossAxisAlignment.center, MainAxisAlignment.center),
  centerRight(CrossAxisAlignment.end, MainAxisAlignment.center),
  bottomLeft(CrossAxisAlignment.start, MainAxisAlignment.end),
  bottomCenter(CrossAxisAlignment.center, MainAxisAlignment.end),
  bottomRight(CrossAxisAlignment.end, MainAxisAlignment.end);

  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  const FloyToastPosition(
    this.crossAxisAlignment,
    this.mainAxisAlignment,
  );
}

class FloyToast {
  final BuildContext context;
  late OverlayEntry entry;

  FloyToast.to(BuildContext ctx, {Key? key}) : context = ctx;

  show({
    required Widget content,
    Duration? duration,
    FloyToastPosition? position,
    EdgeInsets? edgesPadding,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final overlay = Overlay.of(context);
      entry = OverlayEntry(
          builder: (context) => Material(
                color: Colors.transparent,
                child: Padding(
                  padding: edgesPadding ?? const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment:
                        position != null ? position.crossAxisAlignment : CrossAxisAlignment.center,
                    mainAxisAlignment:
                        position != null ? position.mainAxisAlignment : MainAxisAlignment.end,
                    children: [
                      content,
                    ],
                  ),
                ),
              ));
      overlay?.insert(entry);
      Future.delayed(duration ?? const Duration(seconds: 2)).then((value) => entry.remove());
    });
  }
}
