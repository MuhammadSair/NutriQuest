import 'package:flutter/material.dart';
// import 'package:module_1/Screens/base_finder.dart';
import 'package:module_1/Screens/base_finder/main.dart';
import 'package:module_1/Screens/recipes/consent/colors.dart';
import 'package:module_1/Screens/recipes/sidebar.dart';
import 'package:module_1/utils/Calorie_donut.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:module_1/utils/carbohydrates_donut.dart';
import 'package:module_1/utils/fats_donut.dart';
import 'package:module_1/utils/protein_donut.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      drawer: Navbar(),
      appBar: AppBar(
        title: Text("Today"),
        centerTitle: true,
        backgroundColor: maincolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text(
                "Calories",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .apply(color: Colors.black),
              ),
            ),
            CalorieDonutChart(),
            Center(
              child: Text(
                "Macros",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .apply(color: Colors.black),
              ),
            ),
            CarouselSlider(
              items: [
                SizedBox(width: 300, child: CarbsDonutChart()),
                SizedBox(width: 300, child: ProteinsDonutChart()),
                SizedBox(width: 300, child: FatsDonutChart()),
              ],
              options: CarouselOptions(
                height: 200, // Adjust the height as needed
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
