import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Homecontent extends StatefulWidget {
  static const routeName = '/Homecontent';

  const Homecontent({super.key});

  @override
  _HomecontentState createState() => _HomecontentState();
}

class _HomecontentState extends State<Homecontent> {
  GoogleMapController? _mapController;
  Completer<GoogleMapController> _controller = Completer();

  LatLng _initialPosition =
      LatLng(26.820553, 30.802498); // استبدل بالإحداثيات الخاصة بك
  LatLng _currentPosition =
      LatLng(26.820553, 30.802498); // يمكنك ضبط إحداثيات ثابتة هنا
  Marker? _currentMarker;
  bool _isLoading = false; // لإظهار الشريط التحميلي

  @override
  void initState() {
    super.initState();
    _updateMarker();
  }

  void _updateMarker() {
    setState(() {
      _currentMarker = Marker(
        markerId: MarkerId('currentLocation'),
        position: _currentPosition,
        infoWindow: InfoWindow(title: 'Your Location'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            // إضافة SingleChildScrollView
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height *
                      0.8, // تعيين حجم مناسب
                  width: double.infinity,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: 14.4746, // تعيين زوم مناسب
                    ),
                    markers: _currentMarker != null ? {_currentMarker!} : {},
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      _mapController = controller;
                    },
                    myLocationEnabled: false,
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
