import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    super.key,
    required this.title,
    this.white = false,
  });

  final String title;
  final bool white;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: white ? Colors.white : Colors.black,
        fontSize: 20,
      ),
    );
  }
}
