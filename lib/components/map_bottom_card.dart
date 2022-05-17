import 'package:findmyfamily/constants.dart';
import 'package:flutter/material.dart';

class BottomCard extends StatelessWidget {
  final int members;
  const BottomCard({ Key? key, required this.members }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: colorsMap[ProjectColors.membersCardColor]!,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(14.0))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            members!=1 ? "$members members in the group" : "$members member in the group",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.black,)
        ],
      ),
    );
  }
}