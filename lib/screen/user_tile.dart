import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color.fromARGB(218, 172, 166, 166),
          ),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                Icons.account_circle,
                size: 30,
              ),
              const SizedBox(
                width: 25,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
        ));
  }
}
