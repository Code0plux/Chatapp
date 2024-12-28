import 'package:chatapp/service/chat/chat_services.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentuser;
  final String messageId;
  final String userId;

  const ChatBubble(
      {super.key,
      required this.message,
      required this.isCurrentuser,
      required this.messageId,
      required this.userId});

  void _showOptions(BuildContext context, String messageId, String userId) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.block),
                title: Text("Block"),
                onTap: () {
                  Navigator.pop(context);
                  _Blockmessage(context, userId);
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: Text("Cancel"),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ));
        });
  }

  void _Blockmessage(BuildContext context, String userId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Block User'),
              content:
                  const Text("Are you sure? Do you want to block this user?"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      ChatServices().blockuser(userId);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('User Blocked!')));
                    },
                    child: const Text("Block"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (!isCurrentuser) {
          _showOptions(context, messageId, userId);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isCurrentuser ? Colors.blue.shade400 : Colors.grey.shade400),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Text(
          message,
          style: TextStyle(color: isCurrentuser ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
