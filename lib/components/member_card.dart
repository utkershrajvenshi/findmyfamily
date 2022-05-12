import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget {
  final User user;
  const MemberCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.0)
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 15.0,
            backgroundImage: AssetImage("images/app_logo.png"),
          ),
          Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              user.name,
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ))
        ],
      ),
    );
  }
}
