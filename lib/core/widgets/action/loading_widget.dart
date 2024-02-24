import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_animate/flutter_animate.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.type});

  final int? type;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitThreeBounce(
        color: type == 1 ? Colors.white : Colors.blueGrey,
        size: 20,
      ),
    );
    // return Center(
    //   child: AnimatedContainer(
    //     duration: const Duration(milliseconds: 500),
    //     height: 40,
    //     width: 40,
    //     alignment: Alignment.center,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(50),
    //       // color: Colors.blueGrey,
    //     ),
    //     child: Animate(
    //       effects: const [
    //         // FadeEffect(),
    //         ScaleEffect(end: Offset(2, 2)),
    //       ],
    //       delay: 500.ms,
    //       onComplete: (controller) => controller.repeat(
    //         period: 500.ms,
    //         reverse: true,
    //       ),
    //       child: const Text('⭕️'),
    //     ),
    //   ),
    // );
  }
}
