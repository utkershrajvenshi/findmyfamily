import 'package:findmyfamily/backend/group_details.dart';
import 'package:findmyfamily/components/app_icon.dart';
import 'package:findmyfamily/components/map_bottom_card.dart';
import 'package:findmyfamily/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home-screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<GroupDetails>(
        builder: (context, myGroup, child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            titleTextStyle: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            elevation: 7,
            leading: const Center(child: AppIcon(size: 24)),
            backgroundColor: colorsMap[ProjectColors.proceedButtonColor],
            title: Text(myGroup.getGroupName()),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.settings_rounded)),
            ],
            actionsIconTheme:
                const IconThemeData(color: Colors.white, size: 24),
          ),
          body: Stack(
            children: [
              // * Container for storing MapView
              Expanded(
                child: Container(
                  //width: MediaQuery.of(context).size.width,
                  //height: MediaQuery.of(context).size.height - 50,
                  color: Colors.grey.shade200,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomCard(members: myGroup.getNumberOfMembers() ?? 0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
