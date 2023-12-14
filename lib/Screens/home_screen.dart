import 'package:flutter/material.dart';
import 'package:module_1/utils/doghnut.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today",
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .apply(color: Colors.black),
            ),
            DonutChart(),
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
                SizedBox(width: 300, child: DonutChart()),
                SizedBox(width: 300, child: DonutChart()),
                SizedBox(width: 300, child: DonutChart()),
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
