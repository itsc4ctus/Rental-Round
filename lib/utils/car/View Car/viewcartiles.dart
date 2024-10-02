

import 'package:flutter/material.dart';

class ViewCarTiles{

  Card BlueTile(String label,String value){
    return  Card(
      elevation: 15,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1E40AF), // Deep Blue
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              value,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
Text viewDate(DateTime dateTime){
   List<String> months=["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec" ];
    return Text(
      "${dateTime.day} - ${months[dateTime.month-1]} - ${dateTime.year}",
      style: TextStyle(fontSize: 24,
      color: dateTime.isBefore(DateTime.now())?Colors.red :Colors.green,
      ),
    );
}



}