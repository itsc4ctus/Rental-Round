import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class budgetCard{
 static Widget buildStatCard(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: 25, width: 150, child: Text(title)),
        SizedBox(height: 25, width: 100, child: Text(": $value")),
      ],
    );
  }

 static Widget buildInfoCard({required String title, required String subtitle, required Widget child}) {
    return Card(
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(10)
        ),
        
        padding: const EdgeInsets.all(12),
        width: 350,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title),
            ),
            if (subtitle.isNotEmpty) Text(subtitle),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}