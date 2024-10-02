import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentel_round/Models/car_model.dart';
import 'package:rentel_round/Models/status_model.dart';
import 'package:rentel_round/Screens/Customer/bottomsheetcar_tile.dart';
import 'package:rentel_round/Services/car_services.dart';

class CompletedCustomer extends StatefulWidget {
  final status customer;
  const CompletedCustomer({required this.customer, super.key});

  @override
  State<CompletedCustomer> createState() => _CompletedCustomerState();
}

class _CompletedCustomerState extends State<CompletedCustomer> {
  late DateTime dateNow;
  late DateTime lastdateTime;
  List<Cars> listCar = [];
  late Cars carSelected;
  TextEditingController cnameController = TextEditingController();
  TextEditingController cidController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController extraAmtController = TextEditingController();
  ImagePicker picker = ImagePicker();
  XFile? proofImg;

  @override
  void initState() {
    super.initState();
    _loadCars();
    cnameController.text = widget.customer.cName;
    cidController.text = widget.customer.cId;
    amountController.text = widget.customer.advAmount.toString();
    extraAmtController.text = widget.customer.extraAmount.toString();
    dateNow = widget.customer.startDate;
    lastdateTime = widget.customer.endDate;
    carSelected = widget.customer.selectedCar;
    proofImg = XFile(widget.customer.proofImage);
  }

  void _loadCars() async {
    List<Cars> car = await CarServices().getAvailableCar();
    setState(() {
      listCar = car;
    });
  }

  List<String> month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

  String monthToWords(int wid) {
    return month[wid - 1];
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = lastdateTime.difference(dateNow);
    int noOfDays = duration.inDays + 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customer.cName, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ClipRRect(
                child: SizedBox(
                  height: 150,
                  width: 200,

                  child: Image(image:proofImg != null
                      ? FileImage(File(proofImg!.path))
                      : FileImage(File(widget.customer.proofImage)),),
                ),
              ),

              const SizedBox(height: 20),

              // Customer Information Card
              _buildDetailCard("Customer Information", [
                displayDetail("Name", widget.customer.cName),
                displayDetail("ID", widget.customer.cId),
                displayDetail("Advanced Amount", widget.customer.advAmount.toString()),
                displayDetail("Extra Amount", widget.customer.extraAmount.toString()),
              ]),

              const SizedBox(height: 20),


              _buildDetailCard("Car Used", [
                BottomSheetCarTile(
                  carName: carSelected.carName,
                  vehicleNo: carSelected.vehicleNo,
                  kmDriven: carSelected.kmDriven,
                  seatCapacity: carSelected.seatCapacity,
                  cubicCapacity: carSelected.cubicCapacity,
                  rcNo: carSelected.rcNo,
                  pollutionDate: carSelected.pollutionDate,
                  fuelType: carSelected.fuelType,
                  amtPerDay: carSelected.amtPerDay,
                  carImage: carSelected.carImage,
                  brandName: carSelected.brandName,
                  carType: carSelected.carType,
                  pcImage: carSelected.pcImage,
                  rcImage: carSelected.rcImage,
                ),
              ]),

              const SizedBox(height: 20),


              _buildDetailCard("Rental Period", [
                displayDetail("Start Date", "${widget.customer.startDate.day}-${monthToWords(widget.customer.startDate.month)}-${widget.customer.startDate.year}"),
                displayDetail("Returned Date", "${lastdateTime.day}-${monthToWords(widget.customer.endDate.month)}-${lastdateTime.year}"),
              ]),

              const SizedBox(height: 20),


              _buildDetailCard("Payment", [
                displayDetail("Total Amount", "${calculateTotal(noOfDays, carSelected)} for $noOfDays days"),
                displayDetail("Amount Paid", widget.customer.amountReceived.toString()),
              ]),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget displayDetail(String fieldName, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(fieldName, style: const TextStyle(fontWeight: FontWeight.w600)),
        Text(value, style: const TextStyle(color: Colors.black54)),
      ],
    );
  }

  Widget _buildDetailCard(String title, List<Widget> children) {
    return Card(
      color: Colors.blue.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ],
        ),
      ),
    );
  }

  int calculateTotal(int noOfDays, Cars selectedCar) {
    int amtPerDay = selectedCar.amtPerDay;
    int total = amtPerDay * noOfDays;
    return total;
  }
}
