import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  late GoogleMapController googleMapController;

  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  var isMapExpanded = false.obs;

  void toggleMapSize() {
    isMapExpanded.value = !isMapExpanded.value;
  }

  // Variables to keep track of progress
  var currentProgress = 0.obs;
  final int totalSpots = 6;

  void incrementProgress() {
    if (currentProgress.value >= totalSpots) {
      currentProgress.value = 1; // Reset to 1 if it reaches 6
    } else {
      currentProgress.value++;
    }
  }

  double get progressPercentage => currentProgress.value / totalSpots;


   final TextEditingController restaurantNameController = TextEditingController();
   final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  @override
  void onClose() {
    googleMapController.dispose();
    super.onClose();
  }
}
