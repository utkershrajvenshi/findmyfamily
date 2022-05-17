import 'package:findmyfamily/backend/appwrite_init.dart';
import 'package:findmyfamily/components/app_icon.dart';
import 'package:findmyfamily/components/custom_button.dart';
import 'package:findmyfamily/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:findmyfamily/constants.dart';
import 'package:provider/provider.dart';

class GetStartedScreen extends StatelessWidget {
  static String routeName = '/get-started';
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.1,
            horizontal: MediaQuery.of(context).size.width * 0.1,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // This is for showing the application logo on startup screen
                const AppIcon(size: 120),
                // This is for the label 'FindMyFamily'
                Text("FindMyFamily",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: colorsMap[ProjectColors.appTitleColor],
                        fontWeight: FontWeight.bold)),
                CustomLabelledButton(
                  label: "Get Started",
                  color: colorsMap[ProjectColors.getStartedColor]!,
                  onPressed: () {
                    /*Provider.of<AppwriteInit>(context, listen: false)
                        .account
                        .deleteSessions();*/
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}
