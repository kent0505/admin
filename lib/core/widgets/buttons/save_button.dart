import 'package:flutter/cupertino.dart';
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
    return CupertinoButton(
      onPressed: onTap,
      child: Container(
        height: 50,
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
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
      ),
    );
    // return Center(
    //   child: Material(
    //     borderRadius: BorderRadius.circular(20),
    //     elevation: 2,
    //     child: InkWell(
    //       borderRadius: BorderRadius.circular(20),
    //       splashFactory: InkRipple.splashFactory,
    //       radius: 500,
    //       onTap: loading ? null : onTap,
    //       child: Ink(
    //         height: 50,
    //         width: 200,
    //         decoration: BoxDecoration(
    //           color: title == Const.buttonAddText
    //               ? Colors.greenAccent
    //               : Colors.orangeAccent,
    //           borderRadius: BorderRadius.circular(20),
    //         ),
    //         child: loading
    //             ? const LoadingWidget(type: 1)
    //             : Center(
    //                 child: Text(
    //                   title,
    //                   style: const TextStyle(
    //                     fontSize: 18,
    //                     fontWeight: FontWeight.w500,
    //                   ),
    //                 ),
    //               ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
