import 'package:flutter/material.dart';
import 'habit_detail_edit_screen.dart';

class HabitDetailViewScreen extends StatefulWidget {
  final String habitName;

  const HabitDetailViewScreen({
    super.key,
    required this.habitName,
  });

  @override
  State<HabitDetailViewScreen> createState() => _HabitDetailViewScreenState();
}

class _HabitDetailViewScreenState extends State<HabitDetailViewScreen> {
  Map<int, bool> _completions = {}; // Day number -> completion status

  @override
  void initState() {
    super.initState();
    // Initialize with some sample data
    for (int i = 1; i <= 28; i++) {
      if (i != 3 && i != 5 && i != 28) {
        _completions[i] = true; // Most days completed
      } else {
        _completions[i] = false; // Days 3, 5, and 28 not completed
      }
    }
  }

  int _calculateCurrentStreak() {
    int streak = 0;
    for (int i = 28; i >= 1; i--) {
      if (_completions[i] == true) {
        streak++;
      } else {
        break;
      }
    }
    return streak;
  }

  int _calculateBestStreak() {
    int bestStreak = 0;
    int currentStreak = 0;
    for (int i = 1; i <= 28; i++) {
      if (_completions[i] == true) {
        currentStreak++;
        if (currentStreak > bestStreak) {
          bestStreak = currentStreak;
        }
      } else {
        currentStreak = 0;
      }
    }
    return bestStreak;
  }

  int _getCompletedCount(int days) {
    int count = 0;
    int startDay = 29 - days;
    for (int i = startDay; i <= 28; i++) {
      if (_completions[i] == true) {
        count++;
      }
    }
    return count;
  }

  int _getTotalCompletions() {
    int count = 0;
    for (int i = 1; i <= 28; i++) {
      if (_completions[i] == true) {
        count++;
      }
    }
    return count;
  }

  Future<void> _navigateToEditScreen() async {
    final updatedCompletions = await Navigator.push<Map<int, bool>>(
      context,
      MaterialPageRoute(
        builder: (context) => HabitDetailEditScreen(
          habitName: widget.habitName,
          completions: Map<int, bool>.from(_completions),
        ),
      ),
    );

    if (updatedCompletions != null) {
      setState(() {
        _completions = updatedCompletions;
      });
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
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF9C27B0)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.habitName,
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

            // Streaks section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                children: [
                  _buildStreakRow('Current Streak', _calculateCurrentStreak()),
                  const SizedBox(height: 12),
                  _buildStreakRow('Best Streak', _calculateBestStreak()),
                ],
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
                  itemCount: 28,
                  itemBuilder: (context, index) {
                    int day = index + 1;
                    bool isCompleted = _completions[day] ?? false;
                    return _buildCalendarCell(day, isCompleted);
                  },
                ),
              ),
            ),

            // Summary section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                children: [
                  _buildSummaryRow('Last 7 Days', _getCompletedCount(7), 7),
                  const SizedBox(height: 12),
                  _buildSummaryRow('Last 30 Days', _getCompletedCount(30), 30),
                  const SizedBox(height: 12),
                  _buildSummaryRow('Total Completions', _getTotalCompletions(), null),
                ],
              ),
            ),

            // Edit button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _navigateToEditScreen,
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

  Widget _buildStreakRow(String label, int value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        '$label : $value days',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, int completed, int? total) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 0.3,
            ),
          ),
          Text(
            total != null ? '$completed/$total' : '$completed times',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarCell(int day, bool isCompleted) {
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
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          // Water drop icon (sadece tamamlanmış günlerde)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: isCompleted
                  ? const Icon(
                      Icons.water_drop,
                      size: 22,
                      color: Color(0xFF64B5F6), // Light blue
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

