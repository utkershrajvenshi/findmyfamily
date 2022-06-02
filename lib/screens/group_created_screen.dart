import 'package:appwrite/models.dart';
import 'package:findmyfamily/backend/appwrite_init.dart';
import 'package:findmyfamily/backend/group_details.dart';
import 'package:findmyfamily/backend/id_generator.dart';
import 'package:findmyfamily/components/app_icon.dart';
import 'package:findmyfamily/components/custom_button.dart';
import 'package:findmyfamily/components/custom_textfield.dart';
import 'package:findmyfamily/components/custom_title_text.dart';
import 'package:findmyfamily/constants.dart';
import 'package:findmyfamily/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class GroupCreated extends StatefulWidget {
	static String routeName = '/group-created';
	const GroupCreated({Key? key}) : super(key: key);

	@override
	State<GroupCreated> createState() => _GroupCreatedState();
}

class _GroupCreatedState extends State<GroupCreated> {
	TextEditingController _groupNameController = TextEditingController();
	late String groupID;

	@override
	void initState() {
		super.initState();
		groupID = IDGenerator.generateRoomID();
	}

	@override
	Widget build(BuildContext context) {
		return SafeArea(
			child: Scaffold(
				body: Padding(
					padding: EdgeInsets.symmetric(
						vertical: 16.0,
						horizontal: MediaQuery.of(context).size.width * 0.2,
					),
					child: Center(
						child: Column(
							children: [
								const AppIcon(size: 54),
								const Padding(
									padding: EdgeInsets.symmetric(vertical: 40.0),
									child: CustomTitleText(
										titleText: "Your family group ID is ready.",
									),
								),
								Padding(
									padding: const EdgeInsets.symmetric(vertical: 16.0),
									child: CustomTextField(
											controller: _groupNameController,
											hintText: "Enter Group Name"),
								),
								Padding(
									padding: const EdgeInsets.symmetric(vertical: 20.0),
									child: Text(
										"Valid for 2 days",
										style: Theme.of(context).textTheme.bodyMedium?.copyWith(
												color: colorsMap[ProjectColors.hintTextColor]),
									),
								),
								Text(
									groupID,
									style: Theme.of(context).textTheme.headline3?.copyWith(
											fontWeight: FontWeight.bold,
											color: colorsMap[ProjectColors.proceedButtonColor]),
								),
								TextButton.icon(
									onPressed: () {
										Clipboard.setData(ClipboardData(text: groupID))
												.then((value) {
											ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
													content: Text(
															"Group ID successfully copied to clipboard.")));
										});
									},
									icon: const Icon(
										Icons.copy_rounded,
									),
									label: const Text("Copy"),
								),
								Padding(
									padding: const EdgeInsets.only(top: 20.0),
									child: Consumer<GroupDetails>(
										builder: (context, value, child) => CustomLabelledButton(
											label: "Proceed",
											onPressed: () async {
												value.setGroupName(_groupNameController.text);
												value.setGroupID(groupID);
												// Adding present user to the list of members in the GroupDetails object
												String userID = "*";
												AppwriteInit instance =
														Provider.of<AppwriteInit>(context, listen: false);
												try {
													User user = await instance.account.get();

													userID = user.$id;
													print("User with id ${user.$id}");
													value.addGroupMembers(userID: user.$id);
													print("GroupDetails now: ${value.toMap()}");
												} catch (e) {
													print("Exception occurred: ${e}");
												}
												// Creating a document in 'groups' collection
												String createdGroupID;
												try {
													var createdDoc = await instance.database
															.createDocument(
																	collectionId: getGroupsCollectionID(),
																	documentId: "unique()",
																	data: value.toMap(),
																	read: ["role:all"],
																	write: ["user:$userID"]);

													// Also adding the groupID in the db's user.groups section
													createdGroupID = createdDoc.$id;
													Document updatedDoc = await instance
															.updateGroupOfUserDocument(
																	userID, {"group": createdGroupID});

													print("Created document ${createdDoc.toMap()}");
													print(
															"Updated user document of $userID. Updated document: $updatedDoc");
												} catch (e) {
													print("Error while creating document: $e");
												}
												Navigator.popAndPushNamed(
														context, HomeScreen.routeName);
											},
											color: colorsMap[ProjectColors.proceedButtonColor]!,
										),
									),
								),
							],
						),
					),
				),
			),
		);
	}
}