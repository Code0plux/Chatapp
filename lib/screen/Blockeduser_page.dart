import 'package:chatapp/screen/user_tile.dart';
import 'package:chatapp/service/auth/auth_service.dart';
import 'package:chatapp/service/chat/chat_services.dart';
import 'package:chatapp/util/snackbar.dart';
import 'package:flutter/material.dart';

class BlockeduserPage extends StatelessWidget {
  BlockeduserPage({super.key});

  final SnackbarUtil _snackbar = SnackbarUtil();
  final AuthService _authService = AuthService();
  final ChatServices _chatServices = ChatServices();

  void _showUnblockbox(BuildContext context, String userId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Unblock User"),
              content:
                  const Text("Are You sure? Do you want to unblock this user?"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () {
                      _chatServices.unblockuser(userId);
                      Navigator.pop(context);
                      SnackbarUtil.showSnackbar(context, "User Unblocked");
                    },
                    child: const Text("Unblock"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final String userId = _authService.currentuser()!.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text("Blocked Users"),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _chatServices.getBlockedUserStream(userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error Loading..."),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final blockeduser = snapshot.data ?? [];

          if (blockeduser.isEmpty) {
            return const Center(
              child: Text("No blocked User"),
            );
          }

          return ListView.builder(
              itemCount: blockeduser.length,
              itemBuilder: (context, index) {
                final user = blockeduser[index];
                return UserTile(
                    text: user['name'],
                    onTap: () => _showUnblockbox(context, user['uid']));
              });
        },
      ),
    );
  }
}
