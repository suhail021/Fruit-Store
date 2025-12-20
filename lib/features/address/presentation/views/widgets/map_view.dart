import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myapp/core/utils/app_colors.dart';

class MapView extends StatefulWidget {
  static const String routeName = 'MapView';
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController? _mapController;
  LatLng _initialPosition = const LatLng(24.7136, 46.6753); // Riyadh Default
  LatLng? _selectedPosition; // This will track the center of the map
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) setState(() => _isLoading = false);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    final position = await Geolocator.getCurrentPosition();
    if (mounted) {
      setState(() {
        _initialPosition = LatLng(position.latitude, position.longitude);
        _selectedPosition = _initialPosition;
        _isLoading = false;
      });
    }

    _mapController?.animateCamera(CameraUpdate.newLatLng(_initialPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حدد موقعك'),
        actions: [
          TextButton(
            onPressed:
                _selectedPosition == null
                    ? null
                    : () {
                      Navigator.pop(context, {
                        'lat': _selectedPosition!.latitude,
                        'lng': _selectedPosition!.longitude,
                      });
                    },
            child: const Text(
              'تأكيد',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: 16,
                    ),
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                    onCameraMove: (position) {
                      // Update selected position as the camera moves
                      _selectedPosition = position.target;
                    },
                    // Removed markers property as we are using a fixed center icon
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                  ),
                  // Center Pin Icon
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 35.0,
                      ), // Adjust to make the tip of the pin point effectively
                      child: Icon(
                        Icons.location_on,
                        size: 45,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
