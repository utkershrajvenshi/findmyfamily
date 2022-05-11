import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:findmyfamily/constants.dart';

class AppwriteInit extends ChangeNotifier{
  Client client = Client();
  late Account account;

  AppwriteInit(){
    client.setEndpoint(getEndpoint())
        .setSelfSigned(status: true)
        .setProject(getProjectId());

    account = Account(client);
  }

  void registerUser(String email, String password, String name){
    Future result = account.create(userId: 'unique()', email: email, password: password, name: name);
    result
        .then((response) => print(response))
        .catchError((onError) => print(onError));
  }

  void oAuthSignIn(String provider){
    Future result = account.createOAuth2Session(
      provider: provider,
    );
    result
        .then((response) => print(response))
        .catchError((onError) => print(onError));
  }
}
