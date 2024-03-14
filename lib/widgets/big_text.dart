import 'package:flutter/cupertino.dart';

class BigText extends StatelessWidget {

  final Color? color;
  final String text;
  double size;
  TextOverflow overflow;

  BigText({super.key,
    required this.text,
    this.color = const Color(0xFF332d2b),
    this.size = 20,
    this.overflow = TextOverflow.ellipsis
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        fontSize: size
      ),
    );
  }
}
