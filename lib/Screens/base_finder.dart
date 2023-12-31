import 'package:flutter/material.dart';
import 'package:module_1/Models/base_nutrients_model.dart';
import 'package:module_1/provider/base_nutrients_provider.dart';

class BaseFinder extends StatefulWidget {
  const BaseFinder({super.key});

  @override
  State<BaseFinder> createState() => _BaseFinderState();
}

class _BaseFinderState extends State<BaseFinder> {
  final BaseProvider provider = BaseProvider();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController activityLevelController = TextEditingController();
  List<String> resultData = [];
  @override
  Widget build(BuildContext context) {
    String age = "";
    String gender = "";
    String height = "";
    String weight = "";
    String activityLevel = "";

    return Scaffold(
      body: Column(children: [
        TextField(
            decoration: InputDecoration(
              hintText: "age",
            ),
            controller: ageController,
            onChanged: (value) {
              setState(() {
                // age = int.tryParse(value) ?? 0;
                age = value;
              });
            },
            onSubmitted: (value) {}),
        TextField(
            decoration: InputDecoration(hintText: "gender"),
            controller: genderController,
            onChanged: (value) {
              setState(() {
                gender = value;
              });
            },
            onSubmitted: (value) {}),
        TextField(
            decoration: InputDecoration(hintText: "height"),
            controller: heightController,
            onChanged: (value) {
              setState(() {
                // height = int.tryParse(value) ?? 0;
                height = value;
              });
            },
            onSubmitted: (value) {}),
        TextField(
            decoration: InputDecoration(hintText: "weight"),
            controller: weightController,
            onChanged: (value) {
              setState(() {
                // weight = int.tryParse(value) ?? 0;
                weight = value;
              });
            },
            onSubmitted: (value) {}),
        TextField(
            decoration: InputDecoration(hintText: "activitylevel"),
            controller: activityLevelController,
            onChanged: (value) {
              setState(() {
                activityLevel = value;
              });
            },
            onSubmitted: (value) {}),
        ElevatedButton(
            onPressed: () {
              setState(() {
                activityLevel = activityLevelController.text;
              });
              setState(() {
                // weight = weightController.text as int;
                weight = weightController.text;
              });
              setState(() {
                // height = heightController.text as int;
                height = heightController.text;
              });
              setState(() {
                gender = genderController.text;
              });
              setState(() {
                // age = ageController.text as int;
                age = ageController.text;
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
                // FitnessCalculatorResponse responseData = snapshot.data!;

                // // Access the data within the responseData object
                // int bmr = responseData.data.BMR;
                // int maintainWeightCalory =
                //     responseData.data.goals.maintainWeight;

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
