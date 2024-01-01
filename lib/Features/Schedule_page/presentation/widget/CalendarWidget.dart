import 'package:alef_parents/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../events/domain/entities/events.dart';

class CalendarWidget extends StatefulWidget {
   final Function(String) onDaySelected;
   final List<Events>? events; 

  CalendarWidget({required this.onDaySelected, this.events});
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();

}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _focusedDay,
          headerStyle: const HeaderStyle(
              formatButtonVisible: false, leftChevronVisible: false),
          rowHeight: 43,
          selectedDayPredicate: (day) {
            return isSameDay(day, _selectedDay);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
            final formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay);
              widget.onDaySelected(formattedDate);
          },
          onHeaderTapped: (focusedDay) {
            setState(() {
              _focusedDay = focusedDay;
            });
          },
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
            todayDecoration: const BoxDecoration(
              color: Color.fromARGB(255, 223, 236, 236),
              shape: BoxShape.circle,
            ),
            todayTextStyle: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
 eventLoader: (day) {
  // Return events for the given day if events is not null
  return widget.events?.where((event) {
    final eventDateTime = DateTime.tryParse(event.eventDate ?? "");
    return eventDateTime != null && isSameDay(eventDateTime, day);
  })
  .map((event) => event.eventName)
  .toList() ??
  [];
},



        ),
      ),
    );
  }
  // DateTime get selectedDay => _selectedDay;
}
