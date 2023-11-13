import 'package:alef_parents/core/app_theme.dart';
import 'package:flutter/material.dart';

class TimeWidget extends StatefulWidget {
  final List<String> availableTimes;

  TimeWidget({required this.availableTimes});

  @override
  _TimeWidgetState createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  late String selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = ''; // Initially, no time is selected
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Time',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: widget.availableTimes.map((time) {
              return GestureDetector(
                onTap: () {
                  // Handle selection logic here
                  setState(() {
                    selectedTime = time;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color:
                        selectedTime == time ? primaryColor : backgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    time,
                    style: TextStyle(
                      color: selectedTime == time ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
