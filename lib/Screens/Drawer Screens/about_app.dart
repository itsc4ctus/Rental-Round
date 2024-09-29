import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About App"),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: double.infinity,
            child: ListView(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text("About Rental Round",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: "jaro",
                    color: Colors.blue.shade900,
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(12),
                  width: double.infinity,

                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),

                  ),
                  child: Text("""
Rental Round is a car rental app built for shop owners, providing an efficient way to manage vehicle rentals. Whether it’s for deliveries, transporting goods, or daily business operations, Rental Round is designed to simplify rental management.

How It Works:
Easy Account Setup: Shop owners can easily register by providing business details, gaining immediate access to the app's features for managing rentals.

Browse and Filter Vehicles: Shop owners can explore a variety of vehicles suited for their business needs. The app includes a feature to filter vehicles by fuel type (petrol, diesel, electric), allowing users to select the most suitable options.

Add New Customers: Users can add and manage customer details directly in the app, making it easy to keep track of who has rented a vehicle and for how long.

No Booking and Payment System: Unlike traditional rental apps, Rental Round does not have a built-in booking or payment system. Instead, it focuses on streamlining vehicle selection, customer management, and rental details.

Budget Tracking: A built-in budget tracker helps shop owners keep an eye on income and expenses related to rentals, providing a clear overview of profitability and financial management.

Customer Support: Our support team is available to assist with any issues, ensuring a smooth experience when using the app.

With Rental Round, shop owners can manage vehicle rentals effectively, track budgets, add new customers, and filter cars by fuel type—all in one easy-to-use platform.
                  """),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
