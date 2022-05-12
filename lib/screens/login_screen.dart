import 'package:findmyfamily/components/app_icon.dart';
import 'package:findmyfamily/components/custom_button.dart';
import 'package:findmyfamily/components/custom_title_text.dart';
import 'package:findmyfamily/constants.dart';
import 'package:findmyfamily/screens/create_join_group.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = '/login-screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
              top: 16.0, bottom: MediaQuery.of(context).size.height * 0.5),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const AppIcon(size: 54),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.0),
                    child: CustomTitleText(
                      titleText: "Login to continue.",
                    )),
                const SizedBox(
                  height: 40.0,
                ),
                CustomLabelledButton(
                  label: "Sign in with Google",
                  onPressed: () {
                    Navigator.popAndPushNamed(
                        context, CreateOrJoinGroup.routeName);
                  },
                  color: colorsMap[ProjectColors.newGroupColor]!,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
