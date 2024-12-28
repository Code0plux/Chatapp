import 'dart:io';

import 'package:chatapp/screen/Chat_page.dart';
import 'package:chatapp/screen/My_Drawer.dart';
import 'package:chatapp/screen/login_page.dart';
import 'package:chatapp/screen/user_tile.dart';
import 'package:chatapp/service/auth/auth_gate.dart';
import 'package:chatapp/service/auth/auth_service.dart';
import 'package:chatapp/service/chat/chat_services.dart';
import 'package:chatapp/util/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final ChatServices _chatServices = ChatServices();
  final AuthService _authService = AuthService();
  final AuthGate _authGate = AuthGate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        title: const Text("Message"),
      ),
      body: _showuser(),
      drawer: MyDrawer(),
    );
  }

  Widget _showuser() {
    return StreamBuilder(
        stream: _chatServices.getuserstream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!
                .map<Widget>((userData) => _showuserItem(userData, context))
                .toList(),
          );
        });
  }

  Widget _showuserItem(Map<String, dynamic> user, BuildContext context) {
    final currentuserEmail = _authService.currentuser()?.email;
    if (user["email"] != currentuserEmail) {
      return UserTile(
        text: user["name"],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        reciverEmail: user["name"],
                        reciverId: user['uid'],
                      )));
        },
      );
    } else {
      return Container();
    }
  }
}
