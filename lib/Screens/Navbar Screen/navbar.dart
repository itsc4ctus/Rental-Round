import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rentel_round/Screens/Customer/add_screen.dart';
import 'package:rentel_round/Screens/Budget%20Screen/Budget%20screen/budget_screen.dart';
import 'package:rentel_round/Screens/Status/status_screen.dart';
import '../../Models/auth_model.dart';
import '../Car Screen/car_screen.dart';
import '../Home Screen/home_page.dart';


class NavBar extends StatefulWidget {
  final int index;
  final Auth auth;
    NavBar({required this.auth,super.key,this.index=0});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late Auth auth;
  List<Widget> screens = [];
late int _selectedIndex;
  @override
  void initState() {
    super.initState();
    _selectedIndex=widget.index;
    screens.add(HomePage(auth: widget.auth,));
    screens.add(const StatusScreen());
    screens.add(AddScreen(goToStatus: _goToStatus,));
    screens.add(const CarScreen());
    screens.add(const BudgetScreen());
  }
  void _goToStatus(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      bottomNavigationBar: GNav(
        selectedIndex: _selectedIndex,
        onTabChange: (index){
setState(() {
  _selectedIndex = index;
});
        },
        tabs:const [
        GButton(icon: Icons.home_filled,text: "Home",),
        GButton(icon: CupertinoIcons.flag_fill,text: "Status",),
        GButton(icon: CupertinoIcons.add_circled),
        GButton(icon: CupertinoIcons.car_detailed,text: "Cars",),
        GButton(icon: Icons.currency_exchange,text: "Budget",)
      ],
      gap: 8,
       padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 10),
        backgroundColor:  Colors.blue.shade900,
        tabBackgroundColor: Colors.white10,
        color: Colors.white,
        activeColor: Colors.white,
        rippleColor: Colors.white60,
      ),
body: screens[_selectedIndex],
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
