import 'dart:math';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/foundation.dart';
import 'package:findmyfamily/constants.dart';

class AppwriteInit extends ChangeNotifier {
	Client client = Client();
	late Account account;
	late Database database;
	late Storage storage;

	AppwriteInit() {
		client
				.setEndpoint(getEndpoint())
				.setSelfSigned(status: true)
				.setProject(getProjectId());

		// For using the Accounts API for user handling
		account = Account(client);
		// For using Database API for storing user information like, profile picture of a user, userID
		// Groups that the user is a part of, all the groups in the database
		database = Database(client);
		// For storing profile icons in storage bucket
		storage = Storage(client);
	}

	Future<void> oAuthSignIn(String provider) async {
		try {
			var result = await account.createOAuth2Session(
				provider: provider,
			);
			print(result);
		} catch (e) {
			print(":( Caught an exception : $e");
		}
	}

	Future<String> checkIfUserIsInAGroup(User user) async {
		DocumentList docsList = await database.listDocuments(
			collectionId: getUsersCollectionID(),
			queries: [
				Query.equal('userID', user.$id),
			],
		);

		// Check if group name for the user is "NA"
		String groupName = docsList.documents.first.data["group"];
		return groupName;
	}

	void createUserDocument(User user) async {
		String fileName = "icon${Random().nextInt(8)}.png";
		String fileID = await storage
				.listFiles(
						bucketId: getProfileIconsStorageID(), search: fileName, limit: 1)
				.then((value) => value.files[0].$id);

		database.createDocument(
				collectionId: getUsersCollectionID(),
				documentId: "unique()",
				data: {
					"userID": user.$id,
					"profilePic": fileID,
					"group": "NA"
				},
				read: [
					"role:all"
				],
				write: [
					"user:${user.$id}"
				]).then((value) => print("${value.$id} created."));
	}

	Future<Document> updateGroupOfUserDocument(
			String userID, Map<String, dynamic> data) async {
		// Getting the document ID of the required user
		DocumentList docsList = await database.listDocuments(
				collectionId: getUsersCollectionID(),
				queries: [Query.equal('userID', userID)]);

		String documentID = docsList.documents.first.$id;

		Document doc = await database.updateDocument(
			collectionId: getUsersCollectionID(),
			documentId: documentID,
			data: data,
		);
		print("Updated doc is : ${doc.toMap()}");
		return doc;
	}
}
