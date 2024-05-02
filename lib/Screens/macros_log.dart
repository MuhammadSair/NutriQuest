import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:module_1/Screens/recipes/consent/colors.dart';
import 'package:module_1/Screens/recipes/sidebar.dart';
import 'package:module_1/Screens/search_screen.dart';
import 'package:module_1/ad_helper.dart';
import 'package:module_1/utils/base.dart';
import 'package:module_1/utils/macros_log_donut.dart';

class FoodLog extends StatefulWidget {
  const FoodLog({super.key});

  @override
  State<FoodLog> createState() => _FoodLogState();
}

class _FoodLogState extends State<FoodLog> {
  List texts = [
    "The Section contains other facotrs like(sugar, SaturatedFats and Fiber).",
    "The Section contains other facotrs like(sugar, SaturatedFats and Fibers"
        "The Section contains other facotrs like(sugar, SaturatedFats and Fibers"
        "The Section contains other facotrs like(sugar, SaturatedFats and Fibers"
  ];
  User? currentUser = FirebaseAuth.instance.currentUser;

  CalorieDataProvider calorieDataProvider = CalorieDataProvider();
  late String goal;
  late Map<String, dynamic> prefs;
  late double foodCalorie = 0;
  // late double base = 0;
  late num baseValue = 0.0;
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    _fetchData();
    _fetchCalorieData();
  }

  Future<void> _fetchData() async {
    try {
      await calorieDataProvider.fetchData();

      // Check if the widget is still mounted before calling setState
      if (mounted) {
        setState(() {
          baseValue = calorieDataProvider.getBaseValue();
          // baseValue *= 0.50;
          if (kDebugMode) {
            print("Base value of carbs is $baseValue");
          }
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> _fetchCalorieData() async {
    // Assuming you have a collection named 'Nutrition' in F.0000000000000000irestore
    // and each document contains a 'Calories' field
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Nutrition')
          .where('userId',
              isEqualTo: currentUser!.uid) // Adjust this query accordingly
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Use the first document for simplicity, you may adjust this based on your data model
        var data = querySnapshot.docs.first.data() as Map<String, dynamic>;
        setState(() {
          foodCalorie = data['Calories'] ?? 0;
          if (kDebugMode) {
            print(foodCalorie);
          } // Default to 0 if 'Calories' is null
        });
      } else {
        // Handle case where no data is found
        print('No data found in Calorie Firestore.');
      }
    } catch (error) {
      // Handle any errors that occur during the fetch operation
      print('Error fetching data from Firestore: $error');
    }
  }

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
          children: [
            // SizedBox(
            //   height: 20.0,
            // ),
            // Background with clipper
            Container(
              color: Colors.grey,
              height: 220,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SearchBar(
                      hintText: "Search for food",
                      leading: Icon(Icons.search),
                      // constraints: BoxConstraints(maxHeight: 600.0),
                      onTap: () {
                        Get.to(() => const SearchScreen());
                      },
                    ),
                  ),
                  Card(
                    elevation: 4.0,
                    // margin: EdgeInsets.all(16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Calories Remaining',
                            style: TextStyle(
                              fontSize: 15.0,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: <Widget>[
                              Text(
                                NumberFormat('#,###').format(baseValue.toInt()),
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              const Text(
                                '-',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              const SizedBox(
                                width: 30.0,
                              ),
                              Text(
                                NumberFormat('#,###').format(foodCalorie),
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              const Text(
                                '+',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              SizedBox(
                                width: 40.0,
                              ),
                              Text(
                                NumberFormat('#,###').format(0),
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                '=',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                NumberFormat('#,###')
                                    .format(baseValue - foodCalorie.toInt()),
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const Row(
                            children: <Widget>[
                              Text(
                                '  Goal ',
                                style: TextStyle(fontSize: 12.0),
                              ),
                              SizedBox(
                                width: 62.0,
                              ),
                              Text(
                                'Food',
                                style: TextStyle(fontSize: 10.0),
                              ),
                              SizedBox(
                                width: 49.0,
                              ),
                              Text(
                                'Exercise',
                                style: TextStyle(fontSize: 10.0),
                              ),
                              SizedBox(
                                width: 30.0,
                              ),
                              Text(
                                'Remaining',
                                style: TextStyle(fontSize: 10.0),
                              ),
                            ],
                          ),
                          // Add more rows as needed for additional texts
                        ],
                      ),
                    ),
                  ),
                  // Add more widgets as needed
                ],
              ),
            ),

            SizedBox(
              height: 30.0,
            ),
            Container(
                // width: _bannerAd!.size.width.toDouble(),
                // height: _bannerAd!.size.height.toDouble(),
                // child: AdWidget(ad: _bannerAd!),
                ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              child: CarouselSlider.builder(
                itemCount: texts.length,
                options: CarouselOptions(
                  height: 20,
                  viewportFraction: 6,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(milliseconds: 2000),
                  autoPlayAnimationDuration: Duration(milliseconds: 10000),
                  autoPlayCurve: Curves.easeInCirc,
                  enlargeCenterPage: false,
                  scrollDirection: Axis.horizontal,
                ),
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return Text(texts[index],
                      style: TextStyle(
                        fontSize: 15,
                      ));
                },
              ),
            ),
            LogsDonut()
          ],
        ),
      ),
    );
  }
}

// class MyCustomClipper1 extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.lineTo(0, size.height);
//     final firstCurve = Offset(0, size.height - 20);
//     final lastCurve = Offset(30, size.height - 20);
//     path.quadraticBezierTo(
//         firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy);
//     final secondfirstCurve = Offset(0, size.height - 20);
//     final secondlastCurve = Offset(size.width - 30, size.height - 20);
//     path.quadraticBezierTo(secondfirstCurve.dx, secondfirstCurve.dy,
//         secondlastCurve.dx, secondlastCurve.dy);

//     final thirdfirstCurve = Offset(size.width, size.height - 20);
//     final thirdlastCurve = Offset(size.width, size.height);
//     path.quadraticBezierTo(thirdfirstCurve.dx, thirdfirstCurve.dy,
//         thirdlastCurve.dx, thirdlastCurve.dy);

//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     // TODO: implement shouldReclip
//     return true;
//   }
// }
