import 'package:alef_parents/Features/Schedule_page/presentation/widget/CalendarWidget.dart';
import 'package:alef_parents/Features/events/domain/entities/events.dart';
import 'package:alef_parents/Features/events/presentation/bloc/events_bloc.dart';
import 'package:alef_parents/Features/find_preschool/presentation/widgets/message_display.dart';
import 'package:alef_parents/core/app_theme.dart';
import 'package:alef_parents/core/widget/app_bar.dart';
import 'package:alef_parents/core/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:alef_parents/injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class StudentCalendarPage extends StatefulWidget {
  final int classId;
  const StudentCalendarPage({
    super.key,
    required this.classId,
  });
  @override
  _StudentCalendarPageState createState() => _StudentCalendarPageState();
}

class _StudentCalendarPageState extends State<StudentCalendarPage> {
  late String selectedDay;
  late String selectedTime;
  bool _showDialog = false;
  List<Events> selectedDayEvents = [];

  @override
  void initState() {
    super.initState();
    selectedDay = '';
    ;
  }

  void onDaySelected(String day, List<Events> events) {
    setState(() {
      selectedDay = day;
      selectedDayEvents = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EventsBloc>(
            create: (_) => di.sl<EventsBloc>()
              ..add(GetEventsByClassEvents(classId: widget.classId))),
      ],
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBarWidget(
            title: 'Events Page',
            showBackButton: true,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              _eventListScreen(),
              if (_showDialog)
                const Center(
                  child: LoadingWidget(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainBody(List<Events> events) {
    return Column(
      children: [
        _buildCalendarContainer(events),
        const SizedBox(height: 16),
        if (selectedDayEvents.isNotEmpty) _buildEventNameContainer(),
      ],
    );
  }

  Widget _buildCalendarContainer(List<Events> events) {
    return Container(
      width: double.infinity,
      height: 360,
      decoration: getContainerDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CalendarWidget(
          onDaySelected: (day) {
            final selectedDayEvents = events
                .where((event) => isSameDay(
                    DateTime.parse(event.eventDate), DateTime.parse(day)))
                .toList();
            onDaySelected(day, selectedDayEvents);
          },
          events: events,
        ),
      ),
    );
  }

  Widget _buildEventNameContainer() {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: 90,
      ),
      decoration: getContainerDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: selectedDayEvents.map((event) {
              final formattedDate = DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(event.eventDate));
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.event,
                      color: primaryColor,
                      size: 50,
                    ), // Add your desired icon
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Event Name: ${event.eventName}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w100),
                        ),
                        
                        Text(
                          'On: $formattedDate',
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w100),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _eventListScreen() {
    return Column(
      children: [
        BlocBuilder<EventsBloc, EventsState>(
          builder: (context, state) {
            print(state);
            if (state is LoadingEvents) {
              return const LoadingWidget();
            } else if (state is LoadedEvents) {
              return _mainBody(state.events);
            } else if (state is ErrorEventsState) {
              return MessageDisplayWidget(message: state.message);
            } else if (state is EventsInitial) {
              return const LoadingWidget();
            }
            return const LoadingWidget();
          },
        ),
      ],
    );
  }
}
