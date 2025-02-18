import 'package:auto_route/auto_route.dart';
import 'package:homehero/utils/app_router.gr.dart';
import 'package:homehero/utils/bloc_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:homehero/features/core/d_color.dart';
import 'package:homehero/features/core/d_text_style.dart';
import 'package:homehero/data/models/event_model.dart';
import 'package:homehero/features/main/bloc/main_bloc.dart';

/// Экран, который слушает MainBloc и передаёт список событий в календарь
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if (state.calendarStatus == Status.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == Status.error) {
          // return Center(child: Text('Ошибка: ${state.message}'));
        }
        if (state.calendarStatus == Status.success) {
          // Предположим, что в MainLoadedState у нас есть список событий:
          final events = state.events; // List<EventModel>
          return CustomCalendarWidget(events: events);
        }

        // Если это какое-то другое состояние — вернём пустой виджет
        return const SizedBox.shrink();
      },
    );
  }
}

/// Ваш кастомный календарь, который получает список событий и рисует точки
class CustomCalendarWidget extends StatefulWidget {
  final List<EventModel> events;

  const CustomCalendarWidget({
    Key? key,
    required this.events,
  }) : super(key: key);

  @override
  State<CustomCalendarWidget> createState() => _StyledCalendarState();
}

class _StyledCalendarState extends State<CustomCalendarWidget> {
  DateTime _currentMonth = DateTime.now();

  // Пример «закомментированных» eventRanges — можно оставить, если нужно в будущем
  // final List<_EventRange> eventRanges = [
  //   _EventRange(
  //     start: DateTime(2024, 12, 26),
  //     end: DateTime(2024, 12, 28),
  //     color: Colors.green.shade100,
  //   ),
  //   ...
  // ];

  @override
  Widget build(BuildContext context) {
    // Рассчитываем дни для отображения
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final daysInMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final firstWeekday = firstDayOfMonth.weekday; // 1 - пн ... 7 - вс
    final leadingBlankDays = (firstWeekday - 1) % 7;

    // Дней в предыдущем месяце
    final prevMonthLastDay = DateTime(_currentMonth.year, _currentMonth.month, 0).day;

    // 1. Даты предыдущего месяца
    final previousMonthDates = List.generate(leadingBlankDays, (i) {
      int day = prevMonthLastDay - leadingBlankDays + (i + 1);
      return DateTime(_currentMonth.year, _currentMonth.month - 1, day);
    });

    // 2. Даты текущего месяца
    final currentMonthDates = List.generate(daysInMonth, (i) {
      return DateTime(_currentMonth.year, _currentMonth.month, i + 1);
    });

    // Вместо динамического подсчета строк зададим фиксированный totalRows = 6
    final totalRows = 6; // всегда 6 строк
    final totalNeededCells = totalRows * 7; // 6 строк * 7 столбцов = 42 ячейки
    final usedCells = previousMonthDates.length + currentMonthDates.length;
    final trailingBlankDaysCount = totalNeededCells - usedCells;

    // 3. Даты следующего месяца
    final nextMonthDates = List.generate(trailingBlankDaysCount, (i) {
      return DateTime(_currentMonth.year, _currentMonth.month + 1, i + 1);
    });

    // Итоговый список дней календаря
    final calendarDays = [
      ...previousMonthDates,
      ...currentMonthDates,
      ...nextMonthDates,
    ];

    // Высота/ширина ячеек
    const cellSize = 36.0;
    const cellSpacing = 8.0;
    final rowCount = totalRows;

    // Генерируем dayDots на основе списка событий (events)
    final dayDots = _buildDayDots(widget.events);

    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 360,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: DColor.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeader(),
            _buildWeekdayRow(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 35),
              height: 2,
              color: DColor.greenColor,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 5, 0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Укажем ширину "сеточки"
                    const totalWidth = (10 * cellSize) + (6 * cellSpacing);
                    final totalHeight = (rowCount * cellSize) + ((rowCount - 1) * cellSpacing);

                    return SingleChildScrollView(
                      child: Center(
                        child: SizedBox(
                          width: totalWidth,
                          height: totalHeight,
                          child: _buildDayGrid(
                            calendarDays,
                            cellSize,
                            cellSpacing,
                            dayDots,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Шапка календаря (переключение месяцев и лет)
  Widget _buildHeader() {
    final monthName = DateFormat('LLLL', 'ru').format(_currentMonth);
    final yearName = DateFormat('y', 'ru').format(_currentMonth);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Переключение месяца (влево/вправо)
          Row(
            children: [
              InkWell(onTap: _prevMonth, child: const Icon(Icons.chevron_left)),
              Text(
                monthName,
                style: DTextStyle.boldBlackText.copyWith(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              InkWell(onTap: _nextMonth, child: const Icon(Icons.chevron_right)),
            ],
          ),
          // Переключение года (влево/вправо)
          Row(
            children: [
              InkWell(onTap: _prevYear, child: const Icon(Icons.chevron_left)),
              Text(
                yearName,
                style: DTextStyle.boldBlackText.copyWith(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              InkWell(onTap: _nextYear, child: const Icon(Icons.chevron_right)),
            ],
          ),
        ],
      ),
    );
  }

  /// Отображение названий дней недели (пн, вт, ср...)
  Widget _buildWeekdayRow() {
    final weekdays = ['пн', 'вт', 'ср', 'чт', 'пт', 'сб', 'вс'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: weekdays.map((w) {
          final isWeekend = (w == 'сб' || w == 'вс');
          return Expanded(
            child: Center(
              child: Text(
                w,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                  fontFamily: 'inter',
                  color: isWeekend ? DColor.redColor : DColor.greyColor,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// Генерация "точек" (dots) на основе списка событий
  Map<DateTime, List<Color>> _buildDayDots(List<EventModel> events) {
    final Map<DateTime, List<Color>> result = {};

    for (final e in events) {
      // Допустим, executionDate хранится в виде "2024-12-29T11:00:00"
      final DateTime dt = e.executionDate;

      // Нам важно учитывать только год/месяц/день
      final dayKey = DateTime(dt.year, dt.month, dt.day);

      // Пример логики окрашивания: одно событие = красная точка
      // Или вы можете варьировать цвет в зависимости от типа события
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

  /// Сетка дней (в виде Wrap)
  Widget _buildDayGrid(
    List<DateTime> days,
    double cellSize,
    double cellSpacing,
    Map<DateTime, List<Color>> dayDots,
  ) {
    return Wrap(
      runSpacing: cellSpacing,
      spacing: cellSpacing,
      children: days.map((date) {
        return InkWell(
          onTap: () => AutoRouter.of(context).push(SecondMainRoute(selectedDate: date)),
          child: Container(
            width: cellSize,
            height: cellSize,
            decoration: BoxDecoration(
              color: _getHighlightColor(date),
              borderRadius: BorderRadius.circular(8),
              border: _isToday(date) ? Border.all(color: DColor.orangeColor, width: 4) : null,
            ),
            child: _buildDayContent(date, dayDots),
          ),
        );
      }).toList(),
    );
  }

  /// Содержимое одной ячейки дня (цифра дня + точки)
  Widget _buildDayContent(DateTime date, Map<DateTime, List<Color>> dayDots) {
    // Получаем список "точек" (цветов)
    final dots = dayDots[DateTime(date.year, date.month, date.day)] ?? [];

    // Дни из текущего месяца рисуем одним цветом, а "чужие" (пред/след. месяц) другим
    final isCurrentMonth = (date.month == _currentMonth.month);
    final textColor = isCurrentMonth ? (_isWeekend(date) ? Colors.red : Colors.black) : Colors.grey;

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Text(
          '${date.day}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),

        // Если есть события (dots) и это именно текущий месяц — рисуем точки
        if (dots.isNotEmpty && isCurrentMonth)
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            top: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: dots
                  .map(
                    (c) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1.0),
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: c,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }

  /// Подсветка для ячейки (можно возвращать `null`, если не нужно красить)
  Color? _getHighlightColor(DateTime date) {
    return null;
  }

  /// Проверка, выходной ли день
  bool _isWeekend(DateTime date) {
    return (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday);
  }

  /// Проверка, является ли эта дата "сегодня"
  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  /// Переключение на предыдущий месяц
  void _prevMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
    BlocUtils.mainBloc.add(SearchByDateEvent(year: _currentMonth.year, mouth: _currentMonth.month));
  }

  /// Переключение на следующий месяц
  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
    BlocUtils.mainBloc.add(SearchByDateEvent(year: _currentMonth.year, mouth: _currentMonth.month));
  }

  /// Переключение на предыдущий год
  void _prevYear() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year - 1, _currentMonth.month);
    });
    BlocUtils.mainBloc.add(SearchByDateEvent(year: _currentMonth.year, mouth: _currentMonth.month));
  }

  /// Переключение на следующий год
  void _nextYear() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year + 1, _currentMonth.month);
    });
    BlocUtils.mainBloc.add(SearchByDateEvent(year: _currentMonth.year, mouth: _currentMonth.month));
  }

  // Ниже класс _EventRange мы пока не используем (на будущее)
  // ignore: unused_element
  bool _isSameOrAfter(DateTime? a, DateTime b) {
    if (a == null) return false;
    return a.isAtSameMomentAs(b) || a.isAfter(b);
  }

  // ignore: unused_element
  bool _isSameOrBefore(DateTime? a, DateTime b) {
    if (a == null) return false;
    return a.isAtSameMomentAs(b) || a.isBefore(b);
  }
}

// Если захотите опять использовать заливки диапазонов (eventRanges),
// оставьте этот класс и его логику.
// Сейчас он просто закомментирован и не используется.
class _EventRange {
  final DateTime start;
  final DateTime end;
  final Color color;
  _EventRange({required this.start, required this.end, required this.color});
}
