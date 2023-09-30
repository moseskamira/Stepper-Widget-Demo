import 'package:flutter/material.dart';
import 'package:get/get.dart' as myGet;
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'stepper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StepperPage(title: 'Stepper Demo'),
    );
  }
}

class StepperPage extends StatefulWidget {
  const StepperPage({super.key, required this.title});

  final String title;

  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  int currentStepperStep = 0;

  List<Step> buildSteps() {
    return [
      Step(
        title: const Text('Personal'),
        content: Container(
          height: 100,
          color: Colors.red,
        ),
        isActive: currentStepperStep >= 0,
        state: currentStepperStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text('Business'),
        content: Container(
          height: 100,
          color: Colors.green,
        ),
        isActive: currentStepperStep >= 1,
        state: currentStepperStep > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text('Confirm'),
        content: Container(
          height: 100,
          color: Colors.deepPurpleAccent,
        ),
        isActive: currentStepperStep >= 2,
        state: currentStepperStep > 2 ? StepState.complete : StepState.indexed,
      )
    ];
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Stepper(
        type: StepperType.horizontal,
        steps: buildSteps(),
        currentStep: currentStepperStep,
        onStepContinue: () {
          if (currentStepperStep == buildSteps().length - 1) {
            myGet.Get.snackbar(
              'Alert',
              'You Reached Maximum',
              snackPosition: SnackPosition.BOTTOM,
              borderRadius: 0,
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(5),
              backgroundColor: Colors.lightBlue,
              duration: const Duration(seconds: 5),
            );
          } else {
            setState(() {
              currentStepperStep += 1;
            });
          }
        },
        onStepCancel: () {
          if (currentStepperStep == 0) {
            myGet.Get.snackbar('Alert', 'You Reached Minimum',
                snackPosition: SnackPosition.BOTTOM);
          } else {
            setState(() {
              currentStepperStep -= 1;
            });
          }
        },
        onStepTapped: (index) {
          setState(() {
            currentStepperStep = index;
          });
        },
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Container(
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: details.onStepContinue,
                    child: Text(
                      currentStepperStep == buildSteps().length - 1
                          ? 'Submit'
                          : 'Next',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                if (currentStepperStep != 0)
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey),
                      onPressed: details.onStepCancel,
                      child: const Text('Previous'),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
