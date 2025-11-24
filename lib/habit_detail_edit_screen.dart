import 'package:flutter/material.dart';

class HabitDetailEditScreen extends StatefulWidget {
  final String habitName;
  final Map<int, bool> completions;

  const HabitDetailEditScreen({
    super.key,
    required this.habitName,
    required this.completions,
  });

  @override
  State<HabitDetailEditScreen> createState() => _HabitDetailEditScreenState();
}

class _HabitDetailEditScreenState extends State<HabitDetailEditScreen> {
  late Map<int, bool> _completions;

  @override
  void initState() {
    super.initState();
    _completions = Map<int, bool>.from(widget.completions);
  }

  void _toggleCompletion(int day) {
    setState(() {
      _completions[day] = !(_completions[day] ?? false);
    });
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

  void _saveAndExit() {
    Navigator.pop(context, _completions);
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

            // Done Editing button and instruction
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: _saveAndExit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9C27B0),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 12.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Done Editing'),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tap days to toggle completion',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
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
    return GestureDetector(
      onTap: () {
        // Kutuya basınca tamamlanmış yap (hem çarpı hem emoji ekle)
        if (!isCompleted) {
          _toggleCompletion(day);
        }
      },
      child: Container(
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
            // Red X appears on completed days (tamamlanmış günlerde çarpı göster) - sağ üst köşe
            if (isCompleted)
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    // Çarpıya basınca tamamlanmamış yap (hem çarpı hem emoji kaldır)
                    _toggleCompletion(day);
                  },
                  child: const Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.red,
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
      ),
    );
  }
}

