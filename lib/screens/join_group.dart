import 'package:findmyfamily/components/app_icon.dart';
import 'package:findmyfamily/components/custom_button.dart';
import 'package:findmyfamily/components/custom_textfield.dart';
import 'package:findmyfamily/components/custom_title_text.dart';
import 'package:findmyfamily/constants.dart';
import 'package:findmyfamily/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'base_template.dart';

class JoinGroup extends StatelessWidget {
  static String routeName = "/join-group";
  JoinGroup({Key? key}) : super(key: key);

  final TextEditingController _groupIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // ! Fixme
    // FIXME: perform validation check for correct room id here
    return BaseTemplate(
        horizontalPadding: MediaQuery.of(context).size.width * 0.2,
        childrenWidgets: [
          const CustomTitleText(titleText: "Enter family group ID"),
          CustomTextField(
              controller: _groupIdController, hintText: "Enter group ID"),
          CustomLabelledButton(
              label: "Proceed",
              onPressed: () {
                Navigator.popAndPushNamed(context, HomeScreen.routeName);
              },
              color: colorsMap[ProjectColors.proceedButtonColor]!),
        ]);
  }
}
