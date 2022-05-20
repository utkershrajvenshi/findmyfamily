import 'dart:async';

import 'package:findmyfamily/backend/group_details.dart';
import 'package:findmyfamily/backend/location_service.dart';
import 'package:findmyfamily/components/app_icon.dart';
import 'package:findmyfamily/components/map_bottom_card.dart';
import 'package:findmyfamily/constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home-screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // State-global controller for Google Map
  Completer<GoogleMapController> _controller = Completer();

  // Hashmap of all the markers in the map
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Position getInitialData() {
    return Position(
        longitude: 0,
        latitude: 0,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0);
  }

  CameraPosition constructCameraPosition(Position? snapshotPosition) =>
      CameraPosition(
          target:
              LatLng(snapshotPosition!.latitude, snapshotPosition.longitude),
          zoom: 16);

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
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.grey.shade200,
                child: FutureBuilder<Stream<Position>>(
                    future: LocationService().getLocationStream(),
                    builder: (context, futureSnapshot) {
                      if (!futureSnapshot.hasData) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("Loading Map"),
                              SizedBox(height: 40),
                              CircularProgressIndicator()
                            ],
                          ),
                        );
                      }
                      return StreamBuilder<Position>(
                        stream: futureSnapshot.data,
                        initialData: getInitialData(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          _animateToUser(snapshot.data);
                          _addMarker(snapshot.data);

                          return GoogleMap(
                            initialCameraPosition:
                                constructCameraPosition(getInitialData()),
                            myLocationEnabled: true,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                            markers: markers.values.toSet(),
                          );
                        },
                      );
                    }
                ),
                
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomCard(members: myGroup.getNumberOfMembers()),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _animateToUser(Position? myPosition) async {
    final GoogleMapController mapController = await _controller.future;

    // Animate mapCamera to the location and add a marker at the position
    mapController.animateCamera(
        CameraUpdate.newCameraPosition(constructCameraPosition(myPosition)));
  }

  void _addMarker(Position? myPosition) {
    MarkerId _markerId = const MarkerId('Lenovo device');
    Marker marker = Marker(
      markerId: _markerId,
      position: LatLng(myPosition!.latitude, myPosition.longitude),
    );

    markers[_markerId] = marker;
  }
}
