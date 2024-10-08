
import 'package:flutter/cupertino.dart';

class headingTile extends StatelessWidget {
  final String heading;
  headingTile({
    required this.heading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: TextStyle(
        fontSize: 14,
        color: Color(0xFF1E3A8A),
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    );
  }
}
