import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy policy"),
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: ListView(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text("RENTAL\nROUND",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: "jaro",
                    color: Colors.blue.shade900,
                  ),
                ),
                
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(12),
                  width: double.infinity,

                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),

                  ),
                  child: const Text("""
Last Updated: 19 - Sep - 2024

At RENTAL ROUND, we are committed to protecting your privacy. This Privacy Policy outlines how we collect, use, and safeguard your personal information when you use our car rental services through our app.

1. Information We Collect
We collect various types of information to provide and improve our services to you, including:

a. Personal Information
- Full name
- Contact details (email address, phone number)
- Driver's license details
- Payment information (credit card details, billing address)
- Location data (for tracking vehicle pickup and drop-off)
b. Usage Data
- Details of your interactions with our app, including your rental history, preferences, and navigation within the app.
- Log data such as your IP address, device type, browser type, and operating system.
c. Location Information
We may collect your location data to improve service delivery, such as providing nearby car rental options or assisting in vehicle tracking for pickup/drop-off purposes.

2. How We Use Your Information
We use the information we collect for the following purposes:

- To process your car rental bookings and manage your rentals.
- To verify your identity and eligibility to rent a vehicle.
- To handle payments and issue invoices.
- To send notifications related to your bookings, promotions, or updates.
- To improve our app, products, and services.
- For security and fraud prevention purposes.
- To comply with legal obligations.
3. Sharing Your Information
We do not sell, trade, or otherwise transfer your personal information to outside parties, except as described below:

- Service Providers: We may share your information with trusted third-party service providers who assist us in operating our app, processing payments, and delivering car rental services. These third parties are bound by confidentiality agreements.
- Legal Requirements: We may disclose your information if required to do so by law or in response to valid requests by public authorities (e.g., court orders or government agencies).
- Business Transfers: In the event of a merger, acquisition, or asset sale, your personal information may be transferred as part of the business transaction.
4. Data Security
We implement a variety of security measures to protect your personal information. This includes encryption, secure server infrastructure, and access controls. However, no method of transmission over the Internet or electronic storage is 100% secure, and we cannot guarantee its absolute security.

5. Your Data Protection Rights
You have the following rights regarding your personal information:

- Access: You can request access to the personal data we hold about you.
- Correction: You can request corrections to inaccurate or incomplete data.
- Deletion: You can request that we delete your personal data, subject to certain legal obligations.
- Restriction: You can request that we limit how we use your data.
- Objection: You can object to the processing of your data for certain purposes, such as marketing.
- To exercise these rights, please contact us at [Your Support Email].

6. Cookies and Tracking Technologies
Our app may use cookies and similar tracking technologies to enhance your experience. These may include:

Session cookies (to operate our service)
Analytics cookies (to analyze how our app is used and improve user experience)
You can control the use of cookies via your device settings or browser preferences.

7. Third-Party Links
Our app may contain links to third-party websites or services that are not operated by us. We are not responsible for the privacy practices of these third-party services. We encourage you to review their privacy policies when you visit them.

8. Changes to This Privacy Policy
- We may update our Privacy Policy from time to time. Any changes will be posted on this page, and the "Last Updated" date will be revised. We encourage you to review this Privacy Policy periodically for any updates.

9. Contact Us
If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at:

CACTUS COMPANY LIMITED,
cactus@gmail.com
+91 7356041058

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
