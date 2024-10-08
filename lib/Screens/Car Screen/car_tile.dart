import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarTile extends StatefulWidget {
  final String carName;
  final String vehicleNo;
  final int kmDriven;
  final int seatCapacity;
  final int cubicCapacity;
  final int rcNo;
  final DateTime pollutionDate;
  final String fuelType;
  final int amtPerDay;
  final String carImage;
  final String rcImage;
  final String pcImage;
  final String brandName;
  final String carType;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback viewCar;
  final bool availability;
  CarTile({
    super.key,
    required this.carName,
    required this.vehicleNo,
    required this.kmDriven,
    required this.seatCapacity,
    required this.cubicCapacity,
    required this.rcNo,
    required this.pollutionDate,
    required this.fuelType,
    required this.amtPerDay,
    required this.carImage,
    required this.brandName,
    required this.carType,
    required this.pcImage,
    required this.rcImage,
    required this.onDelete,
    required this.onEdit,
    required this.viewCar,
    required this.availability

  });

  @override
  State<CarTile> createState() => _CarTileState();
}

class _CarTileState extends State<CarTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 255,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 15,
                      width: 15,

                      decoration: BoxDecoration(
                        color:widget.availability? Colors.green:Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      height: 140,
                      width: 280,

                      child: Image(image: FileImage(File(widget.carImage))),
                    ),
                    Container(
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: widget.viewCar,
                            icon: const Icon(
                              CupertinoIcons.car_detailed,
                              color: Colors.black,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.blue.shade50,
                            ),
                          ),
                          IconButton(
                            onPressed: widget.onEdit,
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.blue.shade50,
                            ),
                          ),
                          IconButton(
                            onPressed: (){
                              _showDialogue("Do you want to delete?", "DELETE", widget.onDelete, context);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red.shade800,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.blue.shade50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.blue.shade50,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.brandName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        Text(
                          widget.carName,
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'fredoka',
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.vehicleNo.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.airline_seat_recline_extra,
                            color: Colors.green.shade900,
                            ),
                            Text(widget.seatCapacity.toString()),
                            const SizedBox(width: 15),
                            Text(
                              widget.carType,
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Container(

                              child: Center(
                                child: Text(
                                  widget.fuelType,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

void _showDialogue(String messege,String btnName,VoidCallback btnfn,BuildContext context){
    showDialog(context: context,builder: (context) {
      return AlertDialog(
        title: Text(messege),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text("CANCEL")),
          ElevatedButton(onPressed: btnfn, child: Text(btnName))
        ],
      );

    });

}
}
