 
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

 

class TaskProgress extends StatelessWidget {
  const TaskProgress(    {Key? key}  ) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("aasadf"),
        Expanded(child: _buildProgress()),
      ],
    );
  }

 

  Widget _buildProgress() {
    return LinearPercentIndicator(
      percent: .9,
      progressColor: Colors.blueGrey,
      backgroundColor: Colors.blueGrey[200],
    );
  }
}
