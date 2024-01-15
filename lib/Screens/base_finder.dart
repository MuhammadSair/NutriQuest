import 'package:flutter/material.dart';
import 'package:module_1/Models/base_nutrients_model.dart';
import 'package:module_1/provider/base_nutrients_provider.dart';

class FakeBaseFinder extends StatefulWidget {
  const FakeBaseFinder({super.key});

  @override
  State<FakeBaseFinder> createState() => _FakeBaseFinderState();
}

class _FakeBaseFinderState extends State<FakeBaseFinder> {
  final BaseProvider provider = BaseProvider();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController activityLevelController = TextEditingController();

  List<String> resultData = [];
  @override
  Widget build(BuildContext context) {
    int age = 0;
    String gender = "";
    int height = 0;
    int weight = 0;
    String activityLevel = "";

    return Scaffold(
      body: Column(children: [
        TextField(
            decoration: InputDecoration(
              hintText: "age",
            ),
            controller: ageController,
            // onChanged: (value) {
            //   setState(() {
            //     age = int.parse(value);
            //     // age = value as int;
            //   });
            // },
            onSubmitted: (value) {}),
        TextField(
          decoration: InputDecoration(hintText: "gender"),
          controller: genderController,
          // onChanged: (value) {
          //   setState(() {
          //     gender = value;
          //   });
          // },
          // onSubmitted: (value) {}),
        ),
        TextField(
          decoration: InputDecoration(hintText: "height"),
          controller: heightController,
          // onChanged: (value) {
          //   setState(() {
          //     height = int.parse(value);
          //     // height = value as int;
          //   });
          // },
          // onSubmitted: (value) {}),
        ),
        TextField(
          decoration: InputDecoration(hintText: "weight"),
          controller: weightController,
          // onChanged: (value) {
          //   setState(() {
          //     weight = int.parse(value);
          //     // weight = value as int;
          //   });
          // },
          // onSubmitted: (value) {}),
        ),
        TextField(
          decoration: InputDecoration(hintText: "activitylevel"),
          controller: activityLevelController,
          // onChanged: (value) {
          //   setState(() {
          //     activityLevel = value;
          //   });
          // },
          // onSubmitted: (value) {}),
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                activityLevel = activityLevelController.text;
              });
              setState(() {
                // weight = weightController.text as int;
                weight = int.parse(weightController.text);
              });
              setState(() {
                // height = heightController.text as int;
                height = int.parse(heightController.text);
              });
              setState(() {
                gender = genderController.text;
              });
              setState(() {
                // age = ageController.text as int;
                age = int.parse(ageController.text);
              });
            },
            child: Text("Get the Bmr")),
        Expanded(
          child: FutureBuilder<List<FitnessCalculatorResponse>>(
            future:
                provider.fetchData(age, gender, height, weight, activityLevel),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Show a loading indicator
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.data == null) {
                return const Center(child: Text('No data available.'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    FitnessCalculatorResponse responseData =
                        snapshot.data![index];
                    return ListTile(
                      title: Text('BMR: ${responseData.data.BMR}'),
                      subtitle: Text(
                        'Maintain Weight Calory: ${responseData.data.goals.maintainWeight}',
                      ),
                      // Add more details as needed
                    );
                  },
                );
              }
            },
          ),
        ),

        // child: ListView.builder(
        //     itemCount: resultData.length,
        //     itemBuilder: (context, index) {
        //       provider
        //           .fetchData(
        //               age: age,
        //               gender: gender,
        //               height: height,
        //               weight: weight,
        //               activityLevel: activityLevel)
        //           .then((response) {
        //         resultData = response as List<String>;
        //       });
        //       return ListTile(
        //         title: Text(resultData[index]),
        //       );
        //     }))
      ]),
    );
  }
}
