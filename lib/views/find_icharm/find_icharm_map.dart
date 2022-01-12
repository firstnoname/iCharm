import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_charm/models/models.dart';
import 'package:i_charm/services/services.dart';
import 'package:location/location.dart';
import 'package:map_launcher/map_launcher.dart' as mapLauncher;

class FindICharmMap extends StatefulWidget {
  const FindICharmMap({Key? key}) : super(key: key);

  @override
  _FindICharmMapState createState() => _FindICharmMapState();
}

class _FindICharmMapState extends State<FindICharmMap> {
  final Completer<GoogleMapController> _controller = Completer();

  final ValueNotifier<Set<Marker>> _markerNotifier =
      ValueNotifier<Set<Marker>>({});
  final Location location = Location();

  Future<LocationData?> getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }

  Future<Set<Marker>> getMarker() async {
    Set<Marker> markers = {};
    // markers.add(Marker(markerId: ));
    List<Clinic> clinics = await ClinicAPI().getAllClinics();
    clinics.forEach((clinic) {
      markers.add(
        Marker(
          markerId: MarkerId(clinic.id!),
          infoWindow: InfoWindow(title: clinic.clinicName),
          icon: BitmapDescriptor.defaultMarker,
          position:
              LatLng(clinic.location!.latitude!, clinic.location!.longitude!),
          onTap: () async {
            final availableMaps = await mapLauncher.MapLauncher.installedMaps;

            await availableMaps.first.showMarker(
                coords: mapLauncher.Coords(
                  clinic.location!.latitude!,
                  clinic.location!.longitude!,
                ),
                title: clinic.clinicName ?? '');
          },
        ),
      );
    });

    _markerNotifier.value = markers;

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children;
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: getLocation(),
          builder: (context, AsyncSnapshot<LocationData?> snapshot) {
            if (snapshot.hasData) {
              LatLng currentLatLng = LatLng(snapshot.data?.latitude ?? 0.0,
                  snapshot.data?.longitude ?? 0.0);
              getMarker();
              children = <Widget>[
                Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: _markerNotifier,
                      builder: (context, Set<Marker> value, child) {
                        return GoogleMap(
                          markers: value,
                          mapType: MapType.normal,
                          initialCameraPosition:
                              CameraPosition(target: currentLatLng, zoom: 15),
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                        );
                      }),
                )
              ];
            } else if (snapshot.hasError) {
              children = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ];
            } else {
              children = const <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                )
              ];
            }
            return Center(
              child: Column(
                children: children,
              ),
            );
          }),
    );
  }
}
