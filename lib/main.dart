import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:findmyfamily/backend/appwrite_init.dart';
import 'package:findmyfamily/backend/group_details.dart';
import 'package:findmyfamily/components/app_icon.dart';
import 'package:findmyfamily/constants.dart';
import 'package:findmyfamily/screens/create_join_group.dart';
import 'package:findmyfamily/screens/get_started_screen.dart';
import 'package:findmyfamily/screens/group_created_screen.dart';
import 'package:findmyfamily/screens/home_screen.dart';
import 'package:findmyfamily/screens/join_group.dart';
import 'package:findmyfamily/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
	runApp(MultiProvider(
		providers: [
			ChangeNotifierProvider(create: (context) => AppwriteInit()),
			ChangeNotifierProvider(create: (context) => GroupDetails())
		],
		child: const MyApp(),
	));
}

class MyApp extends StatelessWidget {
	const MyApp({Key? key}) : super(key: key);

	// This widget is the root of your application.
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Flutter Demo',
			theme: ThemeData(
				// This is the theme of your application.
				//
				// Try running your application with "flutter run". You'll see the
				// application has a blue toolbar. Then, without quitting the app, try
				// changing the primarySwatch below to Colors.green and then invoke
				// "hot reload" (press "r" in the console where you ran "flutter run",
				// or simply save your changes to "hot reload" in a Flutter IDE).
				// Notice that the counter didn't reset back to zero; the application
				// is not restarted.
				primarySwatch: Colors.blue,
				fontFamily: 'Inter',
			),
			initialRoute: InitApp.routeName,
			routes: {
				InitApp.routeName: (context) => const InitApp(),
				GetStartedScreen.routeName: (context) => const GetStartedScreen(),
				LoginScreen.routeName: ((context) => const LoginScreen()),
				CreateOrJoinGroup.routeName: (context) => const CreateOrJoinGroup(),
				GroupCreated.routeName: (context) => const GroupCreated(),
				JoinGroup.routeName: (context) => JoinGroup(),
				HomeScreen.routeName: (context) => const HomeScreen(),
			},
		);
	}
}

class InitApp extends StatelessWidget {
	static String routeName = '/init-app';
	const InitApp({Key? key}) : super(key: key);

	Future<String> checkForLogin(BuildContext buildContext) async {
		AppwriteInit instance =
				Provider.of<AppwriteInit>(buildContext, listen: false);
		try {
			User userValue = await instance.account.get();
			print(userValue.email);
			// If no error is thrown that means that a user is logged in.
			// Now check if the user is a part of any group or not
			String groupName = await instance.checkIfUserIsInAGroup(userValue);

			if (groupName != "NA") {
				// If result is true, navigate to HomeScreen
				// groupName now contains the name of the group the user is already a member of.
				// We have already specified the provider at the root of the application and subscribing to it
				// in HomeScreen. Hence update the value of the GroupDetails object before navigating to HomeScreen
				GroupDetails myGroup =
						Provider.of<GroupDetails>(buildContext, listen: false);

				// Get the document from the groups collection
				Document groupDoc = await instance.database.getDocument(
						collectionId: getGroupsCollectionID(), documentId: groupName);

				print(groupDoc.toMap());
				myGroup.setFromJson(groupDoc.data);
				print(myGroup.toMap());

				// myGroup should now contain new values from groupDoc.data
				// Navigating now to HomeScreen
				return HomeScreen.routeName;
			} else {
				// Navigate to the Create/Join Group if result is false

				return CreateOrJoinGroup.routeName;
			}
		} catch (e) {
			// If an error is thrown, it means the app was unable to find a currently logged in user
			// Navigate to the GetStarted screen in this case
			print("Error: $e");
			if (e is AppwriteException && e.code == 400) {
				// Index Not found error raised. Occurred because no documents were created or the
				// selected attributes were not in the document
				// Thus, creating a user document and then redirecting to Create/Join Group
				instance.createUserDocument(await instance.account.get());
				return CreateOrJoinGroup.routeName;
			}
		}
		return GetStartedScreen.routeName;
	}

	@override
	Widget build(BuildContext context) {
		checkForLogin(context).then((value) {
			Navigator.popAndPushNamed(context, value);
		});
		return Scaffold(
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: const [
						AppIcon(size: 100.0),
						Padding(
							padding: EdgeInsets.symmetric(vertical: 20.0),
							child: CircularProgressIndicator(),
						),
					],
				),
			),
		);
	}
}
