import 'package:auto_route/auto_route.dart';
import 'package:homehero/utils/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:homehero/features/core/d_color.dart';
import 'package:homehero/features/core/d_text_style.dart';
import 'package:homehero/data/models/event_model.dart';
import 'package:homehero/features/main/bloc/main_bloc.dart';

class CalendarSlider extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final List<EventModel> events;

  const CalendarSlider({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.events,
  });

  @override
  _CalendarSliderState createState() => _CalendarSliderState();
}

class _CalendarSliderState extends State<CalendarSlider> {
  late PageController _pageController;
  late DateTime _currentDate;
  bool firstTime = false;

  @override
  void initState() {
    super.initState();
    if (!firstTime) {
      _currentDate = widget.selectedDate;
      _pageController = PageController(initialPage: 500); // Средняя страница
      firstTime = true;
    }
  }

  /// Генерация "точек" (dots) на основе списка событий
  Map<DateTime, List<Color>> _buildDayDots(List<EventModel> events) {
    final Map<DateTime, List<Color>> result = {};

    for (final e in events) {
      final DateTime dt = e.executionDate;
      final dayKey = DateTime(dt.year, dt.month, dt.day);
      final color = e.eventType == "REGULAR" ? DColor.greenColor : DColor.redColor;

      if (!result.containsKey(dayKey)) {
        result[dayKey] = <Color>[];
      }
      if (result[dayKey]!.length < 3) {
        result[dayKey]!.add(color);
      }
    }

    return result;
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  String _getWeekDayInRussian(DateTime date) {
    List<String> weekDays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
    return weekDays[date.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    final dayDots = _buildDayDots(widget.events); // Get event dots

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: PageView.builder(
          controller: _pageController,
          // onPageChanged: (index) {
          //   final offset = index - 500;
          //   setState(() {
          //     _currentDate = widget.selectedDate.add(Duration(days: offset * 7));
          //     widget.onDateSelected(_currentDate);
          //   });
          // },
          itemBuilder: (context, index) {
            final offset = index - 500;
            final startOfWeek = _currentDate.add(Duration(days: offset * 7 - _currentDate.weekday + 1));

            final weekDays = List.generate(7, (i) => startOfWeek.add(Duration(days: i)));

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: weekDays.map((date) {
                final isSelected = _isSameDay(date, _currentDate);
                final dayEvents = dayDots[date] ?? [];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentDate = date;
                      widget.onDateSelected(date);
                    });
                    // Сразу же корректируем страницу после выбора даты
                    final offset = _currentDate.difference(widget.selectedDate).inDays ~/ 7;
                    _pageController.animateToPage(500 + offset, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.transparent : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          DateFormat('d').format(date),
                          style: TextStyle(
                            fontSize: isSelected ? 20 : 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                            color: isSelected ? DColor.boldGreenColor : DColor.blackTextColor,
                          ),
                        ),
                        Text(
                          _getWeekDayInRussian(date),
                          style: TextStyle(
                            fontSize: isSelected ? 15 : 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            color: isSelected ? DColor.boldGreenColor : DColor.blackTextColor,
                          ),
                        ),
                        // Display dots at the bottom
                        const SizedBox(
                          height: 4,
                        ),
                        if (dayEvents.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              dayEvents.length,
                              (index) => Container(
                                margin: const EdgeInsets.symmetric(horizontal: 2),
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: dayEvents[index],
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
