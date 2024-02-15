import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.type,
  });

  final int type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _TitleTextWidget(title: 'ID'),
        const _TitleTextWidget(title: 'TITLE'),
        const Spacer(),
        const _TitleTextWidget(title: 'INDEX'),
        if (type == 0) ...[
          const _TitleTextWidget(title: 'TYPE'),
        ] else if (type == 1) ...[
          const _TitleTextWidget(title: 'CID'),
        ] else if (type == 2) ...[
          const _TitleTextWidget(title: 'IMAGE'),
          const _TitleTextWidget(title: 'BID'),
        ]
      ],
    );
  }
}

class _TitleTextWidget extends StatelessWidget {
  const _TitleTextWidget({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: title == 'TITLE'
          ? Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            )
          : Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
    );
  }
}
