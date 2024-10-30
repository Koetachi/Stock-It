import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final String text;
  final IconData ico;
  final VoidCallback onPress;
  const Buttons(
      {Key? key, required this.text, required this.ico, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(ico),
            const SizedBox(width: 6),
            Text(text),
          ],
        ),
      ),
    );
  }
}
