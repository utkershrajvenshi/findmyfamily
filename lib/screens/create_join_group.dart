import 'package:findmyfamily/components/app_icon.dart';
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
    /*return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: MediaQuery.of(context).size.width * 0.2),
          child: Center(
            child: Column(
              children: [
                const AppIcon(height: 54, width: 54),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.0),
                    child: CustomTitleText(
                        titleText: "Create or join a family group")),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: CustomLabelledButton(
                    label: "Create a group",
                    onPressed: () {
                      Navigator.pushNamed(context, GroupCreated.routeName);
                    },
                    color: colorsMap[ProjectColors.newGroupColor]!,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: CustomLabelledButton(
                    label: "Join a group",
                    onPressed: () {
                      Navigator.pushNamed(context, JoinGroup.routeName);
                    },
                    color: colorsMap[ProjectColors.joinGroupColor]!,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );*/

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
