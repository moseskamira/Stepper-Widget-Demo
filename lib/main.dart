import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'stepper widget demo',
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
        title: Text('Personal'),
        content: Container(
          height: 100,
          color: Colors.red,
        ),
        isActive: currentStepperStep >= 0,
        state: currentStepperStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text('Business'),
        content: Container(
          height: 100,
          color: Colors.green,
        ),
        isActive: currentStepperStep >= 1,
        state: currentStepperStep > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text('Confirm'),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        steps: buildSteps(),
        currentStep: currentStepperStep,
        onStepContinue: () {
          if (currentStepperStep == buildSteps().length - 1) {
            print('You Reached Maximum');
          } else {
            setState(() {
              currentStepperStep += 1;
            });
          }
        },
        onStepCancel: () {
          if (currentStepperStep == 0) {
            print('You Reached Minimum');
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
                      child: Text('Previous'),
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
