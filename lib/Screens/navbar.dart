import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rentel_round/Authentication/Screens/login_page.dart';
import 'package:rentel_round/Screens/Drawer%20Screens/about_app.dart';
import 'package:rentel_round/Screens/Drawer%20Screens/privacy_policy.dart';
import 'package:rentel_round/Screens/Drawer%20Screens/profile_screen.dart';
import 'package:rentel_round/Screens/Customer/add_screen.dart';
import 'package:rentel_round/Screens/Budget%20Screen/budget_screen.dart';
import 'package:rentel_round/Screens/car_screen.dart';
import 'package:rentel_round/Screens/Status/status_screen.dart';
import 'package:rentel_round/Services/auth_services.dart';
import 'package:rentel_round/Services/car_services.dart';
import 'package:rentel_round/utils/car/Car%20Service/Car_Service.dart';
import '../Models/auth_model.dart';
import 'home_page.dart';


class NavBar extends StatefulWidget {

  final Auth auth;
   const NavBar({required this.auth,super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late Auth auth;
  List<Widget> screens = [];

  @override
  void initState() {
    super.initState();

    screens.add(const HomePage());
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
int _selectedIndex=0;
  @override
  Widget build(BuildContext context) {
final AuthServices authServices = AuthServices();



    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        centerTitle: true,
        title: const Text("RENTAL ROUND",

        ),
        actions: _selectedIndex == 3?[
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CarServiceScreen(),));
          }, icon: const Icon(Icons.car_repair))
        ] : null,
      ),
      drawer: Drawer(
child: Container(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const SizedBox(
        height: 50,
      ),
      const Text("RENTAL\nROUND",textAlign: TextAlign.center,
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
              leading: const Icon(CupertinoIcons.profile_circled),
              title: const Text("View Profile"),

            ),
            ListTile(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CarServiceScreen(),));
              },
              leading: const Icon(Icons.car_repair_rounded),
              title: const Text("Car Services"),
            ),
            const ListTile(
              leading: Icon(CupertinoIcons.settings_solid),
              title: Text("Settings"),
            ),
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyPolicy(),));
              },
              leading: const Icon(Icons.privacy_tip),
              title: const Text("Privacy Policy"),
            ),
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutApp()));
              },
              leading: const Icon(Icons.info_outline),
              title: const Text("About App"),
            ),
          ],
        ),

      ),
const SizedBox(
  height: 250,
),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 50),
          width:double.infinity,
          child: ElevatedButton(onPressed: ()async{
          _showDialogue("Do you want to Logout?", "Logout", (){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage(),));}, context);
          await authServices.setLoginStatus(false);
          await CarServices().cloaseBox();
          }, child: const Text("Log Out",
          style: TextStyle(
            color: Colors.white
          ),
          ))),
      const SizedBox(

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
