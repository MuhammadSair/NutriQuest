import 'package:flutter/material.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: Container(
          color: Colors.blueGrey, // Set the background color here
          child: AppBar(
            title: const Text(
              "Today",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white), // Set text color if needed
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            toolbarHeight: 20.0,
            backgroundColor: Colors
                .transparent, // Set to transparent to see the Container color
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Results",
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .apply(color: Colors.black),
            ),
            CalorieDonutChart(),
            Text(
              "Macros",
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .apply(color: Colors.black),
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
