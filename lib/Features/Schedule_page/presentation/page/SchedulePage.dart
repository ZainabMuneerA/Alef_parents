import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../widget/CalendarWidget.dart';
import '../widget/TimeWidget.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  void initState() {
    super.initState();
  }

  void _handleBookingButtonPressed() {
    // Handle the booking button press here
    // Add your logic for what should happen when the button is pressed
    print('Booking button pressed!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCalendarContainer(),
            SizedBox(height: 16),
            _buildTimeContainer(),
            SizedBox(height: 16),
            _buildBookingButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarContainer() {
    return Container(
      width: double.infinity,
      height: 350,
      decoration: getContainerDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CalendarWidget(),
      ),
    );
  }

  Widget _buildTimeContainer() {
    return Container(
      width: double.infinity,
      decoration: getContainerDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TimeWidget(
          availableTimes: ['10:00 AM', '11:30 AM', '2:00 PM', '4:00 PM'],
        ),
      ),
    );
  }

  Widget _buildBookingButton() {
    return SizedBox(
      width: double.infinity,
      height: 61,
      child: ElevatedButton(
        onPressed: _handleBookingButtonPressed,
        child: const Text(
          'Confirm Appointment',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
        ),
      ),
    );
  }


}
