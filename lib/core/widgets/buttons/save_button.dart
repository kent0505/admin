import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../action/loading_widget.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    required this.title,
    required this.loading,
    required this.onTap,
  });

  final String title;
  final bool loading;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: GestureDetector(
    //     onTapDown: (_) {
    //       setState(() {
    //         pressed = true;
    //       });
    //     },
    //     onTapCancel: () {
    //       setState(() {
    //         pressed = false;
    //       });
    //     },
    //     onTap: widget.onTap,
    //     child: AnimatedContainer(
    //       duration: const Duration(milliseconds: 200),
    //       height: 50,
    //       width: 200,
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(20),
    //         color: widget.title == Const.buttonAddText
    //             ? Colors.greenAccent
    //             : Colors.orangeAccent,
    //         boxShadow: pressed || widget.loading
    //             ? null
    //             : [
    //                 BoxShadow(
    //                   offset: const Offset(0, 1),
    //                   color: widget.title == Const.buttonAddText
    //                       ? Colors.greenAccent
    //                       : Colors.orangeAccent,
    //                   spreadRadius: 4,
    //                 ),
    //                 BoxShadow(
    //                   offset: const Offset(0, -1),
    //                   color: widget.title == Const.buttonAddText
    //                       ? Colors.greenAccent
    //                       : Colors.orangeAccent,
    //                   spreadRadius: 4,
    //                 ),
    //               ],
    //       ),
    //       child: Center(
    //         child: Text(
    //           pressed || widget.loading ? '' : widget.title,
    //           style: const TextStyle(
    //             fontSize: 18,
    //             fontWeight: FontWeight.w500,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          splashFactory: InkRipple.splashFactory,
          radius: 500,
          onTap: loading ? null : onTap,
          child: Ink(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
              color: title == Const.buttonAddText
                  ? Colors.greenAccent
                  : Colors.orangeAccent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: loading
                ? const LoadingWidget(type: 1)
                : Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
