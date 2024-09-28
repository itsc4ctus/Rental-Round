

import 'package:flutter/material.dart';

class ViewCarTiles{

  Card BlueTile(String label,String value){
    return  Card(
      elevation: 15,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFF1E40AF), // Deep Blue
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              "$label",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              "$value",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
Text viewDate(DateTime _dateTime){
   List<String> months=["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec" ];
    return Text(
      "${_dateTime.day} - ${months[_dateTime.month-1]} - ${_dateTime.year}",
      style: TextStyle(fontSize: 24),
    );
}



}