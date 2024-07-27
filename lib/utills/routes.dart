// routes.dart
import 'package:get/get.dart';
import 'package:restaurants_locations/controllers/map_controller.dart';
import 'package:restaurants_locations/views/map_screen.dart';
import 'package:restaurants_locations/views/splash_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/splash',
      page: () => SplashScreen(),
    ),
    GetPage(
      name: '/map',
      page: () => MapScreen(),
      binding: BindingsBuilder(() {
        Get.put(MapController());
      }),
    ),
  ];
}
