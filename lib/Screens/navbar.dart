import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rentel_round/Authentication/Screens/login_page.dart';
import 'package:rentel_round/Screens/Drawer%20Screens/profile_screen.dart';
import 'package:rentel_round/Screens/Customer/add_screen.dart';
import 'package:rentel_round/Screens/budget_screen.dart';
import 'package:rentel_round/Screens/car_screen.dart';
import 'package:rentel_round/Screens/Status/status_screen.dart';
import 'package:rentel_round/Services/auth_services.dart';
import 'package:rentel_round/Services/car_services.dart';

import '../Models/auth_model.dart';
import 'home_page.dart';

class NavBar extends StatefulWidget {

  final Auth auth;
   NavBar({required this.auth,super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late Auth auth;
  List<Widget> screens = [];

  @override
  void initState() {
    super.initState();

    screens.add(HomePage());
    screens.add(StatusScreen());
    screens.add(AddScreen(goToStatus: _goToStatus,));
    screens.add(CarScreen());
    screens.add(BudgetScreen());
  }
  void _goToStatus(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
int _selectedIndex=0;
  @override
  Widget build(BuildContext context) {
final AuthServices authServices = AuthServices();



    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        centerTitle: true,
        title: Text("RENTAL ROUND",

        ),
      ),
      drawer: Drawer(
child: Container(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        height: 50,
      ),
      Text("RENTAL\nROUND",textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "jaro",
            fontSize: 24,
            color: Colors.black
        ),),



      Container(
        child: Column(
          children: [
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(auth: widget.auth)));
              },
              leading: Icon(CupertinoIcons.profile_circled),
              title: Text("View Profile"),

            ),
            ListTile(
              leading: Icon(CupertinoIcons.car_detailed),
              title: Text("Show All Cars"),
            ),
            ListTile(
              leading: Icon(CupertinoIcons.location),
              title: Text("Share Location"),
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text("Privacy Policy"),
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("Privacy Policy"),
            ),
          ],
        ),

      ),
SizedBox(
  height: 250,
),
      Container(
        padding: EdgeInsets.symmetric(vertical: 0,horizontal: 50),
          width:double.infinity,
          child: ElevatedButton(onPressed: ()async{

          _showDialogue("Do you want to Logout?", "Logout", (){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));}, context);
          await authServices.setLoginStatus(false);
          await CarServices().cloaseBox();
          }, child: Text("Log Out",
          style: TextStyle(
            color: Colors.white
          ),
          ))),
      SizedBox(

        width: 50,
      )
    ],
  ),
),
      ),
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
       padding: EdgeInsets.symmetric(vertical: 16,horizontal: 10),
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
        title: Text("$messege"),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("CANCEL")),
          ElevatedButton(onPressed: btnfn, child: Text("$btnName"))
        ],
      );

    });

  }
}
