import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter/material.dart';

class AccuracyMeter extends StatefulWidget {
  final double score;
  AccuracyMeter({Key key, this.score}) : super(key: key);
  @override
  _AccuracyMeterState createState() => _AccuracyMeterState();
}

class _AccuracyMeterState extends State<AccuracyMeter> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SfLinearGauge(
      barPointers: [
        LinearBarPointer(
          value: widget.score,
          animationDuration: 200,
          animationType: LinearAnimationType.linear,
          color: Colors.white,
          thickness: 10.0,
        ),
      ],
      minorTicksPerInterval: 4,
      useRangeColorForAxis: true,
      animateAxis: false,
      axisLabelStyle: TextStyle(
          fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
      axisTrackStyle: LinearAxisTrackStyle(
        thickness: 20.0,
        borderWidth: 5,
      ),
      ranges: <LinearGaugeRange>[
        LinearGaugeRange(
            startWidth: 10.0,
            midWidth: 10.0,
            endWidth: 10.0,
            startValue: 0,
            endValue: 33,
            position: LinearElementPosition.outside,
            color: Color(0xffF45656)),
        LinearGaugeRange(
            startWidth: 10.0,
            midWidth: 10.0,
            endWidth: 10.0,
            startValue: 33,
            endValue: 66,
            position: LinearElementPosition.outside,
            color: Color(0xffFFC93E)),
        LinearGaugeRange(
            startWidth: 10.0,
            midWidth: 10.0,
            endWidth: 10.0,
            startValue: 66,
            endValue: 100,
            position: LinearElementPosition.outside,
            color: Color(0xff0DC9AB)),
      ],
    ));
  }
}
