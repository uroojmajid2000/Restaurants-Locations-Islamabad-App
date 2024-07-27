import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  late GoogleMapController googleMapController;
  var isMapExpanded = false.obs;
  var currentProgress = 1.obs;
  final int totalSpots = 6;
  final RxSet<Marker> markers = <Marker>{}.obs;

  final TextEditingController restaurantNameController =
      TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  Map<int, Restaurant> restaurants = {};

  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  void toggleMapSize() {
    isMapExpanded.value = !isMapExpanded.value;
  }

  void incrementProgress() {
    if (currentProgress.value >= totalSpots) {
      currentProgress.value = 1;
    } else {
      currentProgress.value++;
    }
    updateFormFields();
  }

  double get progressPercentage => currentProgress.value / totalSpots;

  void updateFormFields() {
    final restaurant = restaurants[currentProgress.value];
    if (restaurant != null) {
      restaurantNameController.text = restaurant.name;
      latitudeController.text = restaurant.latitude.toString();
      longitudeController.text = restaurant.longitude.toString();
    } else {
      restaurantNameController.clear();
      latitudeController.clear();
      longitudeController.clear();
    }
  }

  void addOrUpdateLocation() {
    final name = restaurantNameController.text;
    final latitude = double.tryParse(latitudeController.text);
    final longitude = double.tryParse(longitudeController.text);

    if (name.isNotEmpty && latitude != null && longitude != null) {
      if (_isLocationInIslamabad(latitude, longitude)) {
        restaurants[currentProgress.value] = Restaurant(
          name: name,
          latitude: latitude,
          longitude: longitude,
        );
        updateMarkers();
        incrementProgress();
      } else {
        Get.snackbar('Invalid Location',
            'The location is not in Islamabad. Please add a location in Islamabad.',
            snackPosition: SnackPosition.TOP, backgroundColor: Colors.white);
      }
    }
  }

  bool _isLocationInIslamabad(double latitude, double longitude) {
    // Define the bounding box for Islamabad (roughly)
    const double minLat = 33.5;
    const double maxLat = 33.9;
    const double minLng = 72.8;
    const double maxLng = 73.3;

    return latitude >= minLat &&
        latitude <= maxLat &&
        longitude >= minLng &&
        longitude <= maxLng;
  }

  void updateMarkers() {
    markers.clear();
    restaurants.forEach((key, restaurant) {
      markers.add(
        Marker(
          markerId: MarkerId(key.toString()),
          position: LatLng(restaurant.latitude, restaurant.longitude),
          infoWindow: InfoWindow(
            title: restaurant.name,
            snippet: '${restaurant.latitude}, ${restaurant.longitude}',
          ),
        ),
      );
    });
    update();
  }

  @override
  void onClose() {
    googleMapController.dispose();
    restaurantNameController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    super.onClose();
  }
}

class Restaurant {
  final String name;
  final double latitude;
  final double longitude;

  Restaurant({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}
