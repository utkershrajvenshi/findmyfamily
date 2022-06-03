import 'package:appwrite/models.dart';
import 'package:findmyfamily/backend/appwrite_init.dart';
import 'package:findmyfamily/components/custom_button.dart';
import 'package:findmyfamily/components/custom_title_text.dart';
import 'package:findmyfamily/constants.dart';
import 'package:findmyfamily/screens/base_template.dart';
import 'package:findmyfamily/screens/create_join_group.dart';
import 'package:findmyfamily/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = '/login-screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(childrenWidgets: [
      const CustomTitleText(titleText: "Login to continue."),
      CustomLabelledButton(
        label: "Sign in with Google",
        onPressed: () async {
          AppwriteInit instance =
              Provider.of<AppwriteInit>(context, listen: false);
          await instance.oAuthSignIn('google');
          
          User user = await instance.account.get();

          if (await instance.checkIfUserIsInAGroup(user).then((value) => value!="NA")) {
            // Check signifies that the user has a group allocated to it, i.e onboarding flow was normal
            Navigator.popAndPushNamed(context, HomeScreen.routeName);
          } else {
            // Signifies that the user.group property still has value "NA" associated with it.
            // Means its a new user
            // Thus creating a user document before proceeding to the next screen
            instance.createUserDocument(user);
            Navigator.popAndPushNamed(context, CreateOrJoinGroup.routeName);
          }
        },
        color: colorsMap[ProjectColors.newGroupColor]!,
      ),
    ]);
  }
}
