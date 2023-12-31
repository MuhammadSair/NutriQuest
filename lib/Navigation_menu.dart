import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:module_1/Screens/food_log.dart';
import 'package:module_1/Screens/home_screen.dart';
import 'package:module_1/Screens/macros_log.dart';
import 'package:module_1/helpers/helper_functions.dart';
import 'package:module_1/utils/constants/colors.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: darkMode ? TColors.black : TColors.white,
          indicatorColor: darkMode
              ? TColors.black.withOpacity(0.1)
              : TColors.white.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.dashboard), label: "Home"),
            NavigationDestination(
                icon: Icon(Icons.done_outline), label: "Macros Log"),
            NavigationDestination(
                icon: Icon(Iconsax.message), label: "Recipes "),
            NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomeScreen(),
    const FoodLog(),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.green,
    )
  ];
}
