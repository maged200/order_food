import 'dart:async';
import 'package:flutter/material.dart';
import 'package:order_food/src/pages/locations.dart' as locations;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _toggleServiceStatusStream();
  // }

  // ignore: unused_element
  // PopupMenuButton _createActions() {
  //   return PopupMenuButton(
  //     elevation: 40,
  //     onSelected: (value) async {
  //       switch (value) {
  //         case 1:
  //           _getLocationAccuracy();
  //           break;
  //         case 2:
  //           _requestTemporaryFullAccuracy();
  //           break;
  //         case 3:
  //           _openAppSettings();
  //           break;
  //         case 4:
  //           _openLocationSettings();
  //           break;
  //         case 5:
  //           setState(_positionItems.clear);
  //           break;
  //         default:
  //           break;
  //       }
  //     },
  //     itemBuilder: (context) => [
  //       if (Platform.isIOS)
  //         const PopupMenuItem(
  //           child: Text("Get Location Accuracy"),
  //           value: 1,
  //         ),
  //       if (Platform.isIOS)
  //         const PopupMenuItem(
  //           child: Text("Request Temporary Full Accuracy"),
  //           value: 2,
  //         ),
  //       const PopupMenuItem(
  //         child: Text("Open App Settings"),
  //         value: 3,
  //       ),
  //       if (Platform.isAndroid)
  //         const PopupMenuItem(
  //           child: Text("Open Location Settings"),
  //           value: 4,
  //         ),
  //       const PopupMenuItem(
  //         child: Text("Clear"),
  //         value: 5,
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // const sizedBox = SizedBox(
    //   height: 10,
    // );

    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(0, 0),
          zoom: 2,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }
}
//   Future<void> _getCurrentPosition() async {
//     final hasPermission = await _handlePermission();

//     if (!hasPermission) {
//       return;
//     }

//     final position = await _geolocatorPlatform.getCurrentPosition();
//     _updatePositionList(
//       _PositionItemType.position,
//       position.toString(),
//     );
//     print("position.toString(),   ${position.toString()}");
//     setState(() {
//       _kGooglePlex = CameraPosition(
//         target: LatLng(position.latitude, position.longitude),
//         zoom: 11.0,
//         tilt: 0,
//         bearing: 0,
//       );
//     });
//   }

//   Future<bool> _handlePermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled.
//     serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       _updatePositionList(
//         _PositionItemType.log,
//         _kLocationServicesDisabledMessage,
//       );

//       return false;
//     }

//     permission = await _geolocatorPlatform.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await _geolocatorPlatform.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         _updatePositionList(
//           _PositionItemType.log,
//           _kPermissionDeniedMessage,
//         );

//         return false;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       _updatePositionList(
//         _PositionItemType.log,
//         _kPermissionDeniedForeverMessage,
//       );

//       return false;
//     }

//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     _updatePositionList(
//       _PositionItemType.log,
//       _kPermissionGrantedMessage,
//     );
//     return true;
//   }

//   void _updatePositionList(_PositionItemType type, String displayValue) {
//     _positionItems.add(_PositionItem(type, displayValue));
//     setState(() {});
//   }

//   bool _isListening() => !(_positionStreamSubscription == null ||
//       _positionStreamSubscription!.isPaused);

//   Color _determineButtonColor() {
//     return _isListening() ? Colors.green : Colors.red;
//   }

//   void _toggleServiceStatusStream() {
//     if (_serviceStatusStreamSubscription == null) {
//       final serviceStatusStream = _geolocatorPlatform.getServiceStatusStream();
//       _serviceStatusStreamSubscription =
//           serviceStatusStream.handleError((error) {
//         _serviceStatusStreamSubscription?.cancel();
//         _serviceStatusStreamSubscription = null;
//       }).listen((serviceStatus) {
//         String serviceStatusValue;
//         if (serviceStatus == ServiceStatus.enabled) {
//           if (positionStreamStarted) {
//             _toggleListening();
//           }
//           serviceStatusValue = 'enabled';
//         } else {
//           if (_positionStreamSubscription != null) {
//             setState(() {
//               _positionStreamSubscription?.cancel();
//               _positionStreamSubscription = null;
//               _updatePositionList(
//                   _PositionItemType.log, 'Position Stream has been canceled');
//             });
//           }
//           serviceStatusValue = 'disabled';
//         }
//         _updatePositionList(
//           _PositionItemType.log,
//           'Location service has been $serviceStatusValue',
//         );
//       });
//     }
//   }

//   void _toggleListening() {
//     if (_positionStreamSubscription == null) {
//       final positionStream = _geolocatorPlatform.getPositionStream();
//       _positionStreamSubscription = positionStream.handleError((error) {
//         _positionStreamSubscription?.cancel();
//         _positionStreamSubscription = null;
//       }).listen((position) => _updatePositionList(
//             _PositionItemType.position,
//             position.toString(),
//           ));
//       _positionStreamSubscription?.pause();
//     }

//     setState(() {
//       if (_positionStreamSubscription == null) {
//         return;
//       }

//       String statusDisplayValue;
//       if (_positionStreamSubscription!.isPaused) {
//         _positionStreamSubscription!.resume();
//         statusDisplayValue = 'resumed';
//       } else {
//         _positionStreamSubscription!.pause();
//         statusDisplayValue = 'paused';
//       }

//       _updatePositionList(
//         _PositionItemType.log,
//         'Listening for position updates $statusDisplayValue',
//       );
//     });
//   }

//   @override
//   void dispose() {
//     if (_positionStreamSubscription != null) {
//       _positionStreamSubscription!.cancel();
//       _positionStreamSubscription = null;
//     }

//     super.dispose();
//   }

//   void _getLastKnownPosition() async {
//     final position = await _geolocatorPlatform.getLastKnownPosition();
//     if (position != null) {
//       _updatePositionList(
//         _PositionItemType.position,
//         position.toString(),
//       );
//     } else {
//       _updatePositionList(
//         _PositionItemType.log,
//         'No last known position available',
//       );
//     }
//   }

//   void _getLocationAccuracy() async {
//     final status = await _geolocatorPlatform.getLocationAccuracy();
//     _handleLocationAccuracyStatus(status);
//   }

//   void _requestTemporaryFullAccuracy() async {
//     final status = await _geolocatorPlatform.requestTemporaryFullAccuracy(
//       purposeKey: "TemporaryPreciseAccuracy",
//     );
//     _handleLocationAccuracyStatus(status);
//   }

//   void _handleLocationAccuracyStatus(LocationAccuracyStatus status) {
//     String locationAccuracyStatusValue;
//     if (status == LocationAccuracyStatus.precise) {
//       locationAccuracyStatusValue = 'Precise';
//     } else if (status == LocationAccuracyStatus.reduced) {
//       locationAccuracyStatusValue = 'Reduced';
//     } else {
//       locationAccuracyStatusValue = 'Unknown';
//     }
//     _updatePositionList(
//       _PositionItemType.log,
//       '$locationAccuracyStatusValue location accuracy granted.',
//     );
//   }

//   void _openAppSettings() async {
//     final opened = await _geolocatorPlatform.openAppSettings();
//     String displayValue;

//     if (opened) {
//       displayValue = 'Opened Application Settings.';
//     } else {
//       displayValue = 'Error opening Application Settings.';
//     }

//     _updatePositionList(
//       _PositionItemType.log,
//       displayValue,
//     );
//   }

//   void _openLocationSettings() async {
//     final opened = await _geolocatorPlatform.openLocationSettings();
//     String displayValue;

//     if (opened) {
//       displayValue = 'Opened Location Settings';
//     } else {
//       displayValue = 'Error opening Location Settings';
//     }

//     _updatePositionList(
//       _PositionItemType.log,
//       displayValue,
//     );
//   }
// }

// enum _PositionItemType {
//   log,
//   position,
// }

// class _PositionItem {
//   _PositionItem(this.type, this.displayValue);

//   final _PositionItemType type;
//   final String displayValue;
// }
