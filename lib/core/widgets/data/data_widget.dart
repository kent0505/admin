import 'package:flutter/material.dart';

class DataWidget extends StatelessWidget {
  const DataWidget({
    super.key,
    this.type,
    required this.titles,
    required this.onTap,
  });

  final int? type;
  final List<String> titles;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).brightness == Brightness.light
        ? Colors.grey[300]!
        : Colors.grey[800]!;

    return InkWell(
      splashFactory: InkRipple.splashFactory,
      radius: 600,
      onTap: onTap,
      child: Ink(
        height: 30,
        color: titles[3] == '1' && type != 1 ? color : null,
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            _TitleText(title: titles[0]),
            Expanded(
              child: Text(
                titles[1],
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            _TitleText(title: titles[2]),
            _TitleText(title: titles[3]),
            if (type == 2) ...[
              _TitleText(title: titles[4]),
            ],
          ],
        ),
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Center(
        child: Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
