import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:event_booking_app_ui/controllers/event_controller.dart';
import 'package:event_booking_app_ui/models/event_model.dart';
import 'package:intl/intl.dart';
import 'package:event_booking_app_ui/screens/eventDetails_screen.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final eventController = Get.put(EventController());

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: eventController.getAllEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No events available'));
          }

          final events = snapshot.data!.docs.map((doc) {
            return EventModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
          }).toList();

          return CalendarContent(events: events);
        },
      ),
    );
  }
}

class CalendarContent extends StatefulWidget {
  final List<EventModel> events;

  const CalendarContent({super.key, required this.events});

  @override
  State<CalendarContent> createState() => _CalendarContentState();
}

class _CalendarContentState extends State<CalendarContent> {
  late DateTime _focusedDay;
  late DateTime? _selectedDay;
  late Map<DateTime, List<EventModel>> _eventsMap;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _eventsMap = _groupEventsByDate(widget.events);
  }

  Map<DateTime, List<EventModel>> _groupEventsByDate(List<EventModel> events) {
    final Map<DateTime, List<EventModel>> eventsMap = {};

    for (var event in events) {
      final date = DateTime(
        event.eventBegDate.year,
        event.eventBegDate.month,
        event.eventBegDate.day,
      );

      eventsMap.putIfAbsent(date, () => []).add(event);
    }

    return eventsMap;
  }

  List<EventModel> _getEventsForDay(DateTime day) {
    return _eventsMap[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final events = _selectedDay != null
      ? _getEventsForDay(_selectedDay!)
      : [];

  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  eventLoader: _getEventsForDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarStyle: const CalendarStyle(
                    markerDecoration: BoxDecoration(
                      color: Color(0xFF74B3CE),
                      shape: BoxShape.circle,
                    ),
                    markerSize: 5,
                    selectedDecoration: BoxDecoration(
                      color: Color(0xFF5669FF),
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Color(0xFF73C2FB),
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    titleTextStyle: TextStyle(color: Color(0xFF5669FF)),
                    leftChevronIcon: Icon(Icons.chevron_left, color: Color(0xFF5669FF)),
                    rightChevronIcon: Icon(Icons.chevron_right, color: Color(0xFF5669FF)),
                    formatButtonVisible: false,
                    headerPadding: EdgeInsets.only(bottom: 8),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: Color(0xFF5669FF)),
                    weekendStyle: TextStyle(color: Color(0xFF5669FF)),
                  ),
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      final events = _getEventsForDay(day);
                      final hasEvents = events.isNotEmpty;
                      if (!hasEvents) return null;

                      final now = DateTime.now();
                      final isPast = day.isBefore(DateTime(now.year, now.month, now.day));

                      return Container(
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isPast
                              ? Colors.red.withOpacity(0.15)
                              : Colors.green.withOpacity(0.15),
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: TextStyle(
                              fontSize: 14,
                              color: isPast ? Colors.red : Colors.green,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                if (events.isNotEmpty)
                  SizedBox(
                    height: 300, // Or use MediaQuery to make this dynamic
                    child: _buildEventList(screenWidth),
                  )
                else
                  const Text(
                    'No events for this day',
                    style: TextStyle(fontSize: 14),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


  Widget _buildEventList(double screenWidth) {
    final events = _selectedDay != null
        ? _getEventsForDay(_selectedDay!)
        : _getEventsForDay(_focusedDay);

    if (events.isEmpty) {
      return const Center(
        child: Text(
          'No events for this day',
          style: TextStyle(fontSize: 14),
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        final isPast = event.eventBegDate.isBefore(DateTime.now());

        return InkWell(
          onTap: () {
            Get.to(() => EventDetails(event: event));
          },
          child: Container(
            width: screenWidth * 0.85,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    event.eventImage,
                    height: screenWidth * 0.35,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: screenWidth * 0.35,
                        color: Colors.grey[200],
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: screenWidth * 0.35,
                        color: Colors.grey[200],
                        child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('MMM dd, yyyy').format(event.eventBegDate),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isPast ? Colors.red : Colors.green,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        event.eventName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 12, color: Colors.grey),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              event.eventLocation,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
