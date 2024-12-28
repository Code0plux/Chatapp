import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  // Function to open the LinkedIn URL

  Future<void> _launchLinkedIn() async {
    final Uri url =
        Uri.parse("https://www.linkedin.com/in/balaji-t-174611257/");

    await launchUrl(
      url,
      mode: LaunchMode
          .inAppBrowserView, // Forces it to open in an external app or browser
    );
  }

  Future<void> _launchGithub() async {
    final Uri url = Uri.parse("https://github.com/Code0plux");

    await launchUrl(
      url,
      mode: LaunchMode
          .inAppBrowserView, // Forces it to open in an external app or browser
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: _launchLinkedIn, // Call the function to open the URL
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin:
                          const EdgeInsets.only(left: 25, top: 10, right: 25),
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 25, bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          // LinkedIn Text
                          Text(
                            "Linked In",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Icon(Icons.link),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: _launchGithub, // Call the function to open the URL
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin:
                          const EdgeInsets.only(left: 25, top: 10, right: 25),
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 25, bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          // LinkedIn Text
                          Text(
                            "Git Hub",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Icon(Icons.code),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.only(left: 25, top: 10, right: 25),
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 25, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        // LinkedIn Text
                        Text(
                          "balajit1557@gmail.com",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Icon(Icons.mail),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
