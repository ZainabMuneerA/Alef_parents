import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:alef_parents/Features/Schedule_page/domain/entity/appointment_request.dart';
import 'package:alef_parents/Features/Schedule_page/presentation/bloc/appointment/appointment_bloc.dart';
import 'package:alef_parents/Features/Schedule_page/presentation/bloc/time/bloc/time_bloc.dart';
import 'package:alef_parents/core/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:alef_parents/injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widget/dialog_widget.dart';
import '../../../../core/widget/loading_widget.dart';
import '../../../find_preschool/presentation/widgets/message_display.dart';
import '../widget/CalendarWidget.dart';
import '../widget/TimeWidget.dart';

class SchedulePage extends StatefulWidget {
  final int preschoolId;
  final int applicationId;
  final String preschoolName;

  const SchedulePage(
      {super.key,
      required this.preschoolId,
      required this.applicationId,
      required this.preschoolName});
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late String selectedDay;
  late String selectedTime;
  late TimeBloc timeBloc;
  bool _showDialog = false;

  @override
  void initState() {
    super.initState();
    selectedDay = '';
    selectedTime = '';
    timeBloc = di.sl<TimeBloc>();
  }

//!!make sure you need this cuz i dont think so
  void handleDaySelected(String day) {
    setState(() {
      selectedDay = day;
      // Fetch available times when the day is selected
      timeBloc.add(GetAvailableTime(widget.preschoolId, selectedDay));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppointmentBloc>(create: (_) => di.sl<AppointmentBloc>()),
        BlocProvider<TimeBloc>.value(value: timeBloc),
      ],
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBarWidget(
            title: 'Schedule Page',
            showBackButton: true,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                children: [
                  _buildCalendarContainer(),
                  const SizedBox(height: 16),
                  BlocBuilder<TimeBloc, TimeState>(builder: (context, state) {
                    if (state is LoadedTimeState) {
                      return Column(
                        children: [
                          _buildTimeContainer(state.time.availableSlots),
                          const SizedBox(height: 16),
                          _buildBookingButton(),
                        ],
                      );
                    } else if (state is ErrorTimeState) {
                      return DialogFb1(
                        isError: true,
                        subText: state.message,
                        btnText: "Close",
                        onPressed: () {
                          print("hi");
                        },
                      );
                    } else {
                      return Container();
                    }
                  }),
                ],
              ),
              if (_showDialog)
                const Center(
                  child: const LoadingWidget(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarContainer() {
    return Container(
      width: double.infinity,
      height: 360,
      decoration: getContainerDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CalendarWidget(
          onDaySelected: (day) {
            print(day);
            setState(() {
              selectedDay = day;
              timeBloc.add(GetAvailableTime(widget.preschoolId, day));
            });
          },
        ),
      ),
    );
  }

  Widget _buildTimeContainer(List time) {
    return Container(
      width: double.infinity,
      decoration: getContainerDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TimeWidget(
          availableTimes: time,
          onTimeSelected: (String time) {
            selectedTime = time;
            print(time);
          },
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
            color: Colors.white,
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

  //* functionallity *//

  void _handleBookingButtonPressed() {
    _showDialog = true;
    try {
      // Check if widget.applicationId is set
      if (widget.applicationId != null && widget.applicationId != 0) {
        AppointmentRequest request = AppointmentRequest(
          application_id: widget.applicationId,
          date: selectedDay,
          preschool_id: widget.preschoolId,
          time: selectedTime,
        );
        AppointmentBloc appointmentBloc = di.sl<AppointmentBloc>();
        appointmentBloc.add(SetAppointmentEvent(request));

        setState(() {
          _showDialog = false;
        });
        _showSuccessDialog();
      } else {
        // Handle the case where widget.applicationId is not set
        throw Exception("Application ID is not set");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogFb1(
          isError: false,
          subText: 'Appointment Booked successfully',
          btnText: 'Save Appointment',
          onPressed: () {
            _addToCalendar();
            Navigator.pushNamed(context, '/home');
          },
        );
      },
    );
  }

  Future<void> _addToCalendar() async {
    // Specify the event details
    final selectedDateTime = DateTime.parse('$selectedDay $selectedTime');
    final startDate = selectedDateTime;
    final endDate = selectedDateTime.add(const Duration(hours: 2));

    final Event event = Event(
      title: 'Meeting with ${widget.preschoolName}',
      description:
          'Evaluation meeting with ${widget.preschoolName}, please do not forget to bring your child!',
      location: 'at ${widget.preschoolName} main building!',
      startDate: startDate,
      endDate: endDate,
      iosParams: const IOSParams(
        reminder: Duration(hours: 2),
      ),
      androidParams: const AndroidParams(
        emailInvites: [],
      ),
    );

    await Add2Calendar.addEvent2Cal(event);
  }
}
