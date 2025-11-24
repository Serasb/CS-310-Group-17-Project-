import 'package:flutter/material.dart';
import 'models/habit.dart';
import 'streak_calendar_edit_screen.dart';

class StreakCalendarScreen extends StatefulWidget {
  final List<Habit> habits;
  final Map<DateTime, List<String>> completions; // Date -> List of habit IDs

  const StreakCalendarScreen({
    super.key,
    required this.habits,
    this.completions = const {},
  });

  @override
  State<StreakCalendarScreen> createState() => _StreakCalendarScreenState();
}

class _StreakCalendarScreenState extends State<StreakCalendarScreen> {
  DateTime _currentMonth = DateTime(2025, 10, 1); // October 2025

  List<DateTime> _getDaysInMonth() {
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    final daysInMonth = lastDay.day;
    
    List<DateTime> days = [];
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month, i));
    }
    return days;
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
  }

  String _getMonthName() {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[_currentMonth.month - 1];
  }

  List<String> _getCompletionsForDay(DateTime date) {
    final dateKey = DateTime(date.year, date.month, date.day);
    return widget.completions[dateKey] ?? [];
  }

  Widget _buildHabitIcon(HabitIcon iconType, {double size = 20}) {
    switch (iconType) {
      case HabitIcon.waterDrop:
        return Icon(
          Icons.water_drop,
          size: size,
          color: const Color(0xFF64B5F6), // Light blue
        );
      case HabitIcon.meditation:
        return Icon(
          Icons.self_improvement,
          size: size,
          color: Colors.black87,
        );
      case HabitIcon.readingBook:
        return Icon(
          Icons.menu_book,
          size: size,
          color: const Color(0xFF8D6E63), // Brown
        );
      case HabitIcon.learnCode:
        return Icon(
          Icons.computer,
          size: size,
          color: Colors.black87,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final days = _getDaysInMonth();
    final firstDayOfWeek = days.first.weekday; // 1 = Monday, 7 = Sunday
    final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Scaffold(
      backgroundColor: const Color(0xFFE8E8F5), // Light blue/lavender background
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button and title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  // Only show back button if we can pop
                  if (Navigator.canPop(context))
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Color(0xFF9C27B0)),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  else
                    const SizedBox(width: 48), // Balance spacing when no back button
                  Expanded(
                    child: Center(
                      child: Text(
                        'Streak Calendar',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Balance the back button
                ],
              ),
            ),

            // Month navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF9C27B0), size: 18),
                    onPressed: _previousMonth,
                  ),
                  Text(
                    '${_getMonthName()} ${_currentMonth.year}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, color: Color(0xFF9C27B0), size: 18),
                    onPressed: _nextMonth,
                  ),
                ],
              ),
            ),

            // Week days header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: weekDays.map((day) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Calendar grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: firstDayOfWeek - 1 + days.length, // Offset for first day
                  itemBuilder: (context, index) {
                    if (index < firstDayOfWeek - 1) {
                      // Empty cells before first day
                      return const SizedBox.shrink();
                    }
                    
                    final dayIndex = index - (firstDayOfWeek - 1);
                    final day = days[dayIndex];
                    final completions = _getCompletionsForDay(day);
                    
                    return _buildCalendarCell(day.day, completions);
                  },
                ),
              ),
            ),

            // Legend
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 20.0,
                runSpacing: 12.0,
                children: widget.habits.map((habit) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildHabitIcon(habit.icon, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        habit.name,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),

            // Edit button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StreakCalendarEditScreen(
                        habits: widget.habits,
                        selectedHabitIds: widget.habits.map((h) => h.id).toList(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9C27B0).withOpacity(0.7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 12.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color: Color(0xFF9C27B0),
                      width: 1.0,
                    ),
                  ),
                ),
                child: const Text('Edit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarCell(int day, List<String> completedHabitIds) {
    final completedHabits = widget.habits.where((habit) => completedHabitIds.contains(habit.id)).toList();
    
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF9C27B0),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          // Day number
          Positioned(
            top: 2,
            left: 2,
            child: Text(
              '$day',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          // Habit icons
          if (completedHabits.isNotEmpty)
            Positioned(
              bottom: 2,
              left: 2,
              right: 2,
              child: Wrap(
                spacing: 2.0,
                runSpacing: 2.0,
                children: completedHabits.map((habit) {
                  return _buildHabitIcon(habit.icon, size: 22);
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

