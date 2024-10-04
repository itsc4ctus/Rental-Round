import 'package:flutter/material.dart';

class LatestDeals extends StatefulWidget {
  String cName;
  int amountRecieved;
  LatestDeals({
    required this.cName,
    required this.amountRecieved,
    super.key});

  @override
  State<LatestDeals> createState() => _LatestDealsState();
}

class _LatestDealsState extends State<LatestDeals> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 25,
          width: 150,

          child: Text(widget.cName),
        ),
        SizedBox(
          height: 25,
          width: 100,

          child: Text(": ${widget.amountRecieved.toString()}"),
        ),
      ],
    );
  }
}
