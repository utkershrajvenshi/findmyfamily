import 'package:findmyfamily/backend/id_generator.dart';
import 'package:flutter/cupertino.dart';

class GroupDetails extends ChangeNotifier {
  late String _groupName;
  late String _groupID;
  late DateTime _expirationOfID;
  List? _members;

  // Setter functions for GroupDetails fields
  void setGroupName(String groupName) {
    _groupName = groupName;
  }

  void setGroupID(String groupID) {
    _groupID = groupID;
    _expirationOfID = DateTime.now().add(const Duration(days: 2));
  }

  void addGroupMembers({required String userName}) {
    _members?.add(userName);
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
  int? getNumberOfMembers() => _members?.length;
}
