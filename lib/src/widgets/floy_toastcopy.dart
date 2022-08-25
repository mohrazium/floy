// ignore: file_names
// import 'package:flutter/material.dart';
// import 'package:flutter/src/scheduler/ticker.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:flutter_triple/flutter_triple.dart';
// import 'package:get/get.dart';

// extension FloyToaster on BuildContext {
//   void showToast({
//     required Widget content,
//     int? seconds,
//     FloyToastPosition? position,
//     EdgeInsets? edgesPadding,
//   }) =>
//       FloyToast.to(this).show(
//         child: content,
//         seconds: seconds,
//         position: position,
//         edgesPadding: edgesPadding,
//       );
// }

// enum FloyToastPosition {
//   topLeft(CrossAxisAlignment.start, MainAxisAlignment.start),
//   topCenter(CrossAxisAlignment.center, MainAxisAlignment.start),
//   topRight(CrossAxisAlignment.end, MainAxisAlignment.start),
//   centerLeft(CrossAxisAlignment.start, MainAxisAlignment.center),
//   center(CrossAxisAlignment.center, MainAxisAlignment.center),
//   centerRight(CrossAxisAlignment.end, MainAxisAlignment.center),
//   bottomLeft(CrossAxisAlignment.start, MainAxisAlignment.end),
//   bottomCenter(CrossAxisAlignment.center, MainAxisAlignment.end),
//   bottomRight(CrossAxisAlignment.end, MainAxisAlignment.end);

//   final CrossAxisAlignment crossAxisAlignment;
//   final MainAxisAlignment mainAxisAlignment;
//   const FloyToastPosition(
//     this.crossAxisAlignment,
//     this.mainAxisAlignment,
//   );
// }

// class FloyToast {
//   final BuildContext context;
//   late OverlayEntry _entry;
//   late OverlayState? _overlay;
//   bool _isShow = false;

//   FloyToast.to(BuildContext ctx, {Key? key}) : context = ctx {
//     onInit();
//   }

//   void onInit() {}

//   show({
//     required Widget child,
//     int? seconds,
//     FloyToastPosition? position,
//     EdgeInsets? edgesPadding,
//   }) {
//     double visibility = 0.0;
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _overlay = Overlay.of(context);
//       _entry = OverlayEntry(
//           maintainState: true,
//           builder: (ctx) {
//             // final renderBox = ctx.findRenderObject();
//             // print(renderBox.runtimeType);

//             return Padding(
//               padding: edgesPadding ?? const EdgeInsets.all(30.0),
//               child: Material(
//                 color: Colors.transparent,
//                 child: AnimatedOpacity(
//                   opacity: visibility,
//                   duration: const Duration(milliseconds: 100),
//                   child: Column(
//                     crossAxisAlignment:
//                         position != null ? position.crossAxisAlignment : CrossAxisAlignment.center,
//                     mainAxisAlignment:
//                         position != null ? position.mainAxisAlignment : MainAxisAlignment.end,
//                     children: [child],
//                   ),
//                 ),
//               ),
//             );
//           });

//       if (!_isShow) {
//         _overlay?.insert(_entry);
//         _isShow = true;
//       }
//       int milliseconds = seconds != null ? seconds * 1000 : 1500;
//       Future.delayed(const Duration(milliseconds: 150)).then((s) {
//         visibility = 1.0;
//         _entry.markNeedsBuild();
//       });
//       Future.delayed(Duration(milliseconds: milliseconds)).then((s) {
//         visibility = 0.0;
//         _entry.markNeedsBuild();
//       });

//       Future.delayed(Duration(milliseconds: milliseconds + 150)).then((value) {
//         _entry.markNeedsBuild();
//         _entry.remove();
//         _isShow = false;
//         // _overlay?.dispose();
//         _overlay = null;
//       });
//     });
//   }
// }

// // class AnimatedContent extends StatefulWidget {
// //   final Widget content;
// //   final EdgeInsets? edgesPadding;
// //   final FloyToastPosition? position;

// //   const AnimatedContent({Key? key, required this.content, this.edgesPadding, this.position})
// //       : super(key: key);

// //   @override
// //   State<AnimatedContent> createState() => _AnimatedContentState();
// // }

// // class _AnimatedContentState extends State<AnimatedContent> {
// //   double visibility = 0.0;
// //   @override
// //   void initState() {
// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return AnimatedOpacity(
// //       opacity: visibility,
// //       duration: const Duration(milliseconds: 250),
// //       child: Padding(
// //         padding: edgesPadding ?? const EdgeInsets.all(30.0),
// //         child: Column(
// //           crossAxisAlignment:
// //               position != null ? position!.crossAxisAlignment : CrossAxisAlignment.center,
// //           mainAxisAlignment: position != null ? position!.mainAxisAlignment : MainAxisAlignment.end,
// //           children: [content],
// //         ),
// //       ),
// //     );
// //   }
// // }
