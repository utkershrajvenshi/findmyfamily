import 'package:findmyfamily/backend/id_generator.dart';
import 'package:flutter/cupertino.dart';

class GroupDetails extends ChangeNotifier {
  late String _groupName;
  late String _groupID;
  late DateTime _expirationOfID;
  List<String> _members = [];

  GroupDetails() {
    _members = [];
  }

  void setFromJson(Map<dynamic, dynamic> json) {
    String groupName = json["groupName"];
    String groupId = json["groupID"];
    DateTime expiry = DateTime.parse(json["expirationDate"]);
    List<String> members = List<String>.from(json["members"]);

    _groupName = groupName;
    _groupID = groupId;
    _expirationOfID = expiry;
    _members = members;
  }

  // Setter functions for GroupDetails fields
  void setGroupName(String groupName) {
    _groupName = groupName;
    notifyListeners();
  }

  void setGroupID(String groupID) {
    _groupID = groupID;
    _expirationOfID = DateTime.now().add(const Duration(days: 2));
    notifyListeners();
  }

  void addGroupMembers({required String userID}) {
    _members.add(userID);
    notifyListeners();
  }

  // Getter functions for GroupDetails parameters
  String getGroupName() => _groupName;
  String getGroupID() {
    if (_expirationOfID.isAfter(DateTime.now())) {
      return _groupID;
    } else {
      setGroupID(IDGenerator.generateRoomID());
      return _groupID;
    }
  }

  List? getGroupMembers() => _members;
  int getNumberOfMembers() => _members.length;

  Map<String, dynamic> toMap() {
    return {
      "groupName": _groupName,
      "groupID": _groupID,
      "expirationDate": _expirationOfID.toString(),
      "members": _members
    };
  }
}
