import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentel_round/Screens/Home%20Screen/Widgets/filterItems.dart';
import 'package:rentel_round/Services/car_services.dart';
import '../../Models/car_model.dart';
import '../Car Screen/View Car/viewcar_screen.dart';
import '../Car Screen/car_tile.dart';
import '../Car Screen/editcar_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Search and filter variables
  String filterValue = "all";
  TextEditingController searchController = TextEditingController();
  List<Cars> homeCar = [];
  List<Cars> onHoldCars = [];
  List<Cars> filteredCar = [];

  // Initial filter state
  bool petrolSelected = false;
  bool dieselSelected = false;
  bool cngSelected = false;
  bool electricSelected = false;
  bool automaticSelected = false;
  bool manualSelected = false;
  int selectedSeats = 0; // Track the number of seats selected

  @override
  void initState() {
    _loadCars();
    searchController.addListener(_applyFilters); // Update filter on search
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Load cars from the service
  Future<void> _loadCars() async {
    List<Cars> car = await CarServices().getCar();
    List<Cars> onHCar = await CarServices().getOnHoldCar();
    for (var cars in car) {
      bool isOnHold =
          onHCar.any((onHoldCar) => onHoldCar.vehicleNo == cars.vehicleNo);
      cars.availability = !isOnHold;
    }
    setState(() {
      onHoldCars = onHCar;
      homeCar = car;
      filteredCar = homeCar;
    });
  }

  // Apply filters (search, fuel type, transmission, seat capacity)
  void _applyFilters() {
    String query = searchController.text.toLowerCase();

    filteredCar = homeCar.where((car) {
      bool matchesQuery = car.carName.toLowerCase().contains(query);

      // Fuel type filter
      bool matchesFuelType =
          (petrolSelected && car.fuelType.toLowerCase() == 'petrol') ||
              (dieselSelected && car.fuelType.toLowerCase() == 'diesel') ||
              (cngSelected && car.fuelType.toLowerCase() == 'cng') ||
              (electricSelected && car.fuelType.toLowerCase() == 'electric') ||
              (!petrolSelected &&
                  !dieselSelected &&
                  !cngSelected &&
                  !electricSelected);

      // Transmission type filter
      bool matchesTransmission =
          (automaticSelected && car.carType.toLowerCase() == 'automatic') ||
              (manualSelected && car.carType.toLowerCase() == 'manual') ||
              (!automaticSelected && !manualSelected);

      // Seat capacity filter
      bool matchesSeats =
          selectedSeats == 0 || car.seatCapacity == selectedSeats;

      return matchesQuery &&
          matchesFuelType &&
          matchesTransmission &&
          matchesSeats;
    }).toList();

    setState(() {});
  }

  // Handle car deletion
  Future<void> _deleteCars(String vehicleNo) async {
    bool carContains = onHoldCars.any((car) => car.vehicleNo == vehicleNo);
    if (carContains) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.yellow.shade600,
        content: const Text(
          "Can't delete, Car is On Hold!",
          style: TextStyle(color: Colors.black),
        ),
      ));
      Navigator.pop(context);
    } else {
      await CarServices().deleteCar(vehicleNo);
      await CarServices().deleteAvailableCar(vehicleNo);
      setState(() {
        _loadCars();
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          "Car Deleted!",
          style: TextStyle(color: Colors.white),
        ),
      ));
    }
  }

  // Handle car edit
  Future<void> _editCar(Cars editCar) async {
    bool carContain =
        onHoldCars.any((car) => car.vehicleNo == editCar.vehicleNo);
    if (carContain) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.yellow.shade600,
        content: const Text(
          "Can't edit, Car is On Hold!",
          style: TextStyle(color: Colors.black),
        ),
      ));
    } else {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditCarScreen(car: editCar)),
      );
      setState(() {
        _loadCars();
      });
    }
  }

  // View car details
  Future<void> _viewCar(Cars car) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewcarScreen(car: car)),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    bool tempPetrolSelected = petrolSelected;
    bool tempDieselSelected = dieselSelected;
    bool tempCngSelected = cngSelected;
    bool tempElectricSelected = electricSelected;
    bool tempAutomaticSelected = automaticSelected;
    bool tempManualSelected = manualSelected;
    int tempSelectedSeats = selectedSeats;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      const Text("FUEL TYPE"),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: Column(
                          children: [
                            filterItems.filterFeild("PETROL", tempPetrolSelected,
                                    (value) {
                                  setModalState(() {
                                    tempPetrolSelected = value!;
                                    petrolSelected = tempPetrolSelected;
                                    _applyFilters();
                                  });
                                }),
                            filterItems.filterFeild("DIESEL", tempDieselSelected,
                                    (value) {
                                  setModalState(() {
                                    tempDieselSelected = value!;
                                    dieselSelected = tempDieselSelected;
                                    _applyFilters();
                                  });
                                }),
                            filterItems.filterFeild("CNG", tempCngSelected, (value) {
                              setModalState(() {
                                tempCngSelected = value!;
                                cngSelected = tempCngSelected;
                                _applyFilters();
                              });
                            }),
                            filterItems.filterFeild("ELECTRIC", tempElectricSelected,
                                    (value) {
                                  setModalState(() {
                                    tempElectricSelected = value!;
                                    electricSelected = tempElectricSelected;
                                    _applyFilters();
                                  });
                                }),


                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text("TRANSMISSION TYPE"),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),

                ),
                child: Column(
                  children: [

                    SizedBox(
                      height: 10,
                    ),
                    filterItems.filterFeild("AUTOMATIC", tempAutomaticSelected,
                (value) {
              setModalState(() {
                tempAutomaticSelected = value!;
                automaticSelected = tempAutomaticSelected;
                _applyFilters();
              });
                        }),
                    filterItems.filterFeild("MANUAL", tempManualSelected,
                (value) {
              setModalState(() {
                tempManualSelected = value!;
                manualSelected = tempManualSelected;
                _applyFilters();
              });
                        }),
                  ],
                ),
              ),
                      const SizedBox(height: 10),
                      const Text("NUMBER OF SEATS"),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          filterItems.seatPicker(1, () {
                            setModalState(() {
                              tempSelectedSeats = 1;
                              selectedSeats = tempSelectedSeats;
                              _applyFilters();
                            });
                          }, "", tempSelectedSeats == 1),
                          filterItems.seatPicker(2, () {
                            setModalState(() {
                              tempSelectedSeats = 2;
                              selectedSeats = tempSelectedSeats;
                              _applyFilters();
                            });
                          }, "", tempSelectedSeats == 2),
                          filterItems.seatPicker(3, () {
                            setModalState(() {
                              tempSelectedSeats = 3;
                              selectedSeats = tempSelectedSeats;
                              _applyFilters();
                            });
                          }, "", tempSelectedSeats == 3),
                          filterItems.seatPicker(4, () {
                            setModalState(() {
                              tempSelectedSeats = 4;
                              selectedSeats = tempSelectedSeats;
                              _applyFilters();
                            });
                          }, "", tempSelectedSeats == 4),
                          filterItems.seatPicker(5, () {
                            setModalState(() {
                              tempSelectedSeats = 5;
                              selectedSeats = tempSelectedSeats;
                              _applyFilters();
                            });
                          }, "", tempSelectedSeats == 5),
                          filterItems.seatPicker(6, () {
                            setModalState(() {
                              tempSelectedSeats = 6;
                              selectedSeats = tempSelectedSeats;
                              _applyFilters();
                            });
                          }, "", tempSelectedSeats == 6),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setModalState(() {
                              tempPetrolSelected = false;
                              tempDieselSelected = false;
                              tempCngSelected = false;
                              tempElectricSelected = false;
                              tempAutomaticSelected = false;
                              tempManualSelected = false;
                              tempSelectedSeats = 0;
                            });
                            setState(() {
                              petrolSelected = false;
                              dieselSelected = false;
                              cngSelected = false;
                              electricSelected = false;
                              automaticSelected = false;
                              manualSelected = false;
                              selectedSeats = 0;
                            });
                            _applyFilters();
                            Navigator.pop(context);
                          },
                          child: Text("RESET"))
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: homeCar.isEmpty
            ? const Center(child: Text("Add Car to Display!"))
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: searchController,
                            decoration: const InputDecoration(
                              labelText: "Search",
                              hintText: "Search...",
                              border: OutlineInputBorder(),
                              suffixIcon:
                                  Icon(CupertinoIcons.search_circle_fill),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _showFilterBottomSheet(context),
                        icon:
                            Icon(Icons.filter_alt, color: Colors.blue.shade900),
                      ),
                    ],
                  ),
                  Expanded(
                    child: filteredCar.isEmpty
                        ? const Center(child: Text("No cars to display"))
                        : ListView.builder(
                            itemCount: filteredCar.length,
                            itemBuilder: (context, index) => CarTile(
                              carName: filteredCar[index].carName,
                              vehicleNo: filteredCar[index].vehicleNo,
                              kmDriven: filteredCar[index].kmDriven,
                              seatCapacity: filteredCar[index].seatCapacity,
                              cubicCapacity: filteredCar[index].rcNo,
                              pollutionDate: filteredCar[index].pollutionDate,
                              fuelType: filteredCar[index].fuelType,
                              amtPerDay: filteredCar[index].amtPerDay,
                              carImage: filteredCar[index].carImage,
                              brandName: filteredCar[index].brandName,
                              carType: filteredCar[index].carType,
                              pcImage: filteredCar[index].pcImage,
                              rcImage: filteredCar[index].rcImage,
                              rcNo: filteredCar[index].rcNo,
                              onDelete: () =>
                                  _deleteCars(filteredCar[index].vehicleNo),
                              onEdit: () => _editCar(filteredCar[index]),
                              viewCar: () => _viewCar(filteredCar[index]),
                              availability: filteredCar[index].availability,
                            ),
                          ),
                  ),
                ],
              ),
      ),
    );
  }
}
