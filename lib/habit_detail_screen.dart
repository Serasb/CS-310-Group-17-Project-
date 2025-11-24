import 'package:flutter/material.dart';

class HabitDetailScreen extends StatefulWidget {
  final String habitName;

  const HabitDetailScreen({
    super.key,
    required this.habitName,
  });

  @override
  State<HabitDetailScreen> createState() => _HabitDetailScreenState();
}

class _HabitDetailScreenState extends State<HabitDetailScreen> {
  bool _isEditMode = false;
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStreakCard('Current Streak', _calculateCurrentStreak()),
                  _buildStreakCard('Best Streak', _calculateBestStreak()),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSummaryCard('Last 7 Days', _getCompletedCount(7), 7),
                  _buildSummaryCard('Last 30 Days', _getCompletedCount(30), 30),
                ],
              ),
            ),

            // Edit button and instruction
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEditMode = !_isEditMode;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isEditMode
                          ? const Color(0xFF9C27B0)
                          : const Color(0xFF9C27B0).withOpacity(0.7),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 12.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(_isEditMode ? 'Done Editing' : 'Edit'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _isEditMode
                        ? 'Tap days to toggle completion'
                        : 'Tap an item to mark completion',
                    style: const TextStyle(
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

  Widget _buildStreakCard(String label, int value) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF9C27B0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String label, int completed, int total) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$completed/$total',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
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

// Custom painter for incomplete water drop (day 28)
class IncompleteWaterDropPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF64B5F6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path();
    // Top curve (incomplete outline)
    path.moveTo(size.width * 0.5, size.height * 0.05);
    path.quadraticBezierTo(
      size.width * 0.15,
      size.height * 0.25,
      size.width * 0.25,
      size.height * 0.55,
    );
    // Left side line
    path.moveTo(size.width * 0.25, size.height * 0.55);
    path.lineTo(size.width * 0.25, size.height * 0.85);
    // Right side line (incomplete)
    path.moveTo(size.width * 0.75, size.height * 0.55);
    path.lineTo(size.width * 0.75, size.height * 0.85);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

