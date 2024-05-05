import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../action/loading_widget.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.title,
    required this.loading,
    required this.onPressed,
  });

  final String title;
  final bool loading;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: loading ? null : onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: loading
            ? const LoadingWidget()
            : Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
      ),
    );
  }
}
