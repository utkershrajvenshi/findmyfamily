import 'package:findmyfamily/backend/appwrite_init.dart';
import 'package:findmyfamily/backend/group_details.dart';
import 'package:findmyfamily/components/app_icon.dart';
import 'package:findmyfamily/components/custom_button.dart';
import 'package:findmyfamily/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:findmyfamily/constants.dart';
import 'package:provider/provider.dart';

class GetStartedScreen extends StatefulWidget {
  static String routeName = "/get-started";

  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  bool _isLoggedIn = false;

  Future<void> checkForLogin(BuildContext context) async {
    AppwriteInit instance = Provider.of<AppwriteInit>(context, listen: false);
    await instance.account.get().then((value) {
      _isLoggedIn = true;
    }).catchError((onError) {
      if (onError.code == 401) {
        print(onError);
        _isLoggedIn = false;
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //checkForLogin(context);
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
                // For determining if we need to show the get started button or not
                // Checking if any session is active right now. If not, show the button to login.
                // If yes, check if user has joined a group. If he has skip to the show Map screen, else create/join group
                if (!_isLoggedIn)
                  CustomLabelledButton(
                    label: "Get Started",
                    color: colorsMap[ProjectColors.getStartedColor]!,
                    onPressed: () {
                      Navigator.popAndPushNamed(context, LoginScreen.routeName);
                    },
                  )
                // else if(_isLoggedIn && )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
