import 'package:flutter/material.dart';
import 'models/habit.dart';

class StreakCalendarEditScreen extends StatefulWidget {
  final List<Habit> habits;
  final List<String> selectedHabitIds;

  const StreakCalendarEditScreen({
    super.key,
    required this.habits,
    this.selectedHabitIds = const [],
  });

  @override
  State<StreakCalendarEditScreen> createState() => _StreakCalendarEditScreenState();
}

class _StreakCalendarEditScreenState extends State<StreakCalendarEditScreen> {
  late List<String> _selectedHabitIds;

  @override
  void initState() {
    super.initState();
    _selectedHabitIds = List<String>.from(widget.selectedHabitIds);
  }

  void _toggleHabitSelection(String habitId) {
    setState(() {
      if (_selectedHabitIds.contains(habitId)) {
        _selectedHabitIds.remove(habitId);
      } else {
        _selectedHabitIds.add(habitId);
      }
    });
  }

  Widget _buildHabitIcon(HabitIcon iconType) {
    switch (iconType) {
      case HabitIcon.waterDrop:
        return const Icon(
          Icons.water_drop,
          size: 24,
          color: Color(0xFF64B5F6), // Light blue
        );
      case HabitIcon.meditation:
        return const Icon(
          Icons.self_improvement,
          size: 24,
          color: Colors.black87,
        );
      case HabitIcon.readingBook:
        return const Icon(
          Icons.menu_book,
          size: 24,
          color: Color(0xFF8D6E63), // Brown
        );
      case HabitIcon.learnCode:
        return const Icon(
          Icons.computer,
          size: 24,
          color: Colors.black87,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
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

            // Habits list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                itemCount: widget.habits.length,
                itemBuilder: (context, index) {
                  final habit = widget.habits[index];
                  final isSelected = _selectedHabitIds.contains(habit.id);
                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: GestureDetector(
                      onTap: () => _toggleHabitSelection(habit.id),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          children: [
                            _buildHabitIcon(habit.icon),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: Text(
                                habit.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.check_circle,
                              color: isSelected 
                                  ? const Color(0xFF9C27B0) 
                                  : Colors.transparent,
                              size: 28,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Instruction text
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Tap to view this habit on the Streak Calendar',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  letterSpacing: 0.3,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

