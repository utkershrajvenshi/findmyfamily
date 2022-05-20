import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class LocationService extends ChangeNotifier {
  Future<bool> checkForPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Means the user has turned off location sharing in their device
      // Redirect the user to Location Settings page
      await Geolocator.openLocationSettings();
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // User has denied giving permission to the app for tracking location
      // Asking again
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // User has again denied permission
        // Should ideally show a UI explaining why the permissions are being requested, but for now return an error
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // User has permanently denied permission for location tracking
      // Can't do anything unless user resets permissions or reinstalls app
      /*return Future.error(
          "Location permissions are denied forever. Please allow permission manually to use the app.");
      */

      // * Redirect user to App settings page
      await Geolocator.openAppSettings();
      return false;
    }

    // Handled all possibilities of permission denial
    // Now permissions are granted either in the form of LocationPermission.always or LocationPermissions.whileInUse
    // Access the position of the device
    return true;
  }

  Future<Position> getLocation() async {
    bool hasPermissions = await checkForPermissions();
    while (!hasPermissions) {
      hasPermissions = await checkForPermissions();
    }

    return Geolocator.getCurrentPosition();
  }
  

  Future<Stream<Position>> getLocationStream() async {
    bool hasPermissions = await checkForPermissions();
    while (!hasPermissions) {
      hasPermissions = await checkForPermissions();
    }

    LocationSettings locationSettings =
        const LocationSettings(distanceFilter: 0);
    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }
}
