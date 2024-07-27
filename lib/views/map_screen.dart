import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurants_locations/controllers/map_controller.dart';
import 'package:restaurants_locations/utills/widgets/custom_button.dart';
import 'package:restaurants_locations/utills/widgets/custom_textfeld.dart';
import 'package:restaurants_locations/utills/widgets/customlinearprogress_indicator.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MapController controller = Get.find<MapController>();
    final double iconContainerHeight = 20.0;

    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: controller.isMapExpanded.value
                      ? Get.height * 0.95 - iconContainerHeight
                      : Get.height / 2,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(33.6844, 73.0479),
                      zoom: 12,
                    ),
                    onMapCreated: (GoogleMapController googleMapController) {
                      controller.onMapCreated(googleMapController);
                      controller.updateMarkers();
                    },
                    markers: controller.markers,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.toggleMapSize();
                  },
                  child: Container(
                    height: iconContainerHeight,
                    width: Get.width,
                    color: Colors.black,
                    child: Icon(
                      controller.isMapExpanded.value
                          ? Icons.arrow_drop_up_outlined
                          : Icons.arrow_drop_down_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
                controller.isMapExpanded.value
                    ? SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Text(
                              "Food Tour In Islamabad",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            SizedBox(height: 5),
                            GestureDetector(
                                onTap: () {
                                  controller.incrementProgress();
                                },
                                child: Icon(Icons.arrow_forward)),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                CustomLinearProgressIndicator(
                                  progress: controller.progressPercentage,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '${controller.currentProgress.value}/6 SPOTS visited',
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(child: Text("Restaurant Name")),
                                Expanded(
                                    flex: 2,
                                    child: CustomTextField(
                                      controller:
                                          controller.restaurantNameController,
                                      inputType: TextInputType.text,
                                    )),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(child: Text("Latitude")),
                                Expanded(
                                    flex: 2,
                                    child: CustomTextField(
                                        controller:
                                            controller.latitudeController,
                                        inputType: TextInputType.number)),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(child: Text("Longitude")),
                                Expanded(
                                    flex: 2,
                                    child: CustomTextField(
                                        controller:
                                            controller.longitudeController,
                                        inputType: TextInputType.number)),
                              ],
                            ),
                            SizedBox(height: 20),
                            CustomButton(
                              onTap: () {
                                controller.addOrUpdateLocation();
                              },
                              text: "Add or Update Location",
                            )
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
