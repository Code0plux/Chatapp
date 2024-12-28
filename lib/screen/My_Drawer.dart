import 'package:chatapp/screen/about.dart';
import 'package:chatapp/screen/login_page.dart';
import 'package:chatapp/screen/settings.dart';
import 'package:chatapp/service/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final AuthService _authService = AuthService();
  String findname() {
    String name = _authService.currentuser()!.displayName.toString();
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // DrawerHeader
            DrawerHeader(
              child: Column(
                children: [
                  Center(
                    child: Icon(
                      Icons.message,
                      size: 80,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "HI ${findname().toUpperCase()} :)",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  title: const Text("H O M E"),
                  leading: Icon(Icons.home),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  title: const Text("S E T T I N G S"),
                  leading: Icon(Icons.settings),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsPage(),
                        ));
                  },
                )),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  title: const Text("A B O U T  U S"),
                  leading: Icon(Icons.info_outline_rounded),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutUs(),
                        ));
                  },
                )),
            Padding(
              padding: EdgeInsets.only(
                  left: 20,
                  top: MediaQuery.of(context).size.height *
                      0.35), // Adjust top padding based on screen height
              child: ListTile(
                title: const Text("L O G O U T"),
                leading: Icon(Icons.login_sharp),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
