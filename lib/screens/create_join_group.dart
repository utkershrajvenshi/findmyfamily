import 'package:findmyfamily/components/custom_button.dart';
import 'package:findmyfamily/components/custom_title_text.dart';
import 'package:findmyfamily/constants.dart';
import 'package:findmyfamily/screens/base_template.dart';
import 'package:findmyfamily/screens/group_created_screen.dart';
import 'package:findmyfamily/screens/join_group.dart';
import 'package:flutter/material.dart';

class CreateOrJoinGroup extends StatelessWidget {
  static String routeName = "/create-or-join-group";

  const CreateOrJoinGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
      horizontalPadding: MediaQuery.of(context).size.width * 0.2,
      childrenWidgets: [
        const CustomTitleText(titleText: "Create or join a family group"),
        CustomLabelledButton(
          label: "Create a group",
          onPressed: () {
            Navigator.pushNamed(context, GroupCreated.routeName);
          },
          color: colorsMap[ProjectColors.newGroupColor]!,
        ),
        CustomLabelledButton(
          label: "Join a group",
          onPressed: () {
            Navigator.pushNamed(context, JoinGroup.routeName);
          },
          color: colorsMap[ProjectColors.joinGroupColor]!,
        ),
      ],
    );
  }
}
