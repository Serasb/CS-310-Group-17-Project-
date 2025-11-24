import 'package:flutter/material.dart';
import 'streak_calendar_screen.dart';
import 'models/habit.dart';

class PersonalizationScreen extends StatefulWidget {
  final Function(bool)? onThemeChanged;
  
  const PersonalizationScreen({super.key, this.onThemeChanged});

  @override
  State<PersonalizationScreen> createState() => _PersonalizationScreenState();
}

class _PersonalizationScreenState extends State<PersonalizationScreen> {
  bool _notificationsEnabled = false;
  bool _isDarkTheme = false;

  void _navigateToMain() {
    // Örnek habit'ler
    final habits = [
      Habit(id: '1', name: 'Drink Water', icon: HabitIcon.waterDrop),
      Habit(id: '2', name: 'Meditation', icon: HabitIcon.meditation),
      Habit(id: '3', name: 'Reading Book', icon: HabitIcon.readingBook),
      Habit(id: '4', name: 'Learn Code', icon: HabitIcon.learnCode),
    ];

    // Örnek completion'lar (October 2025 için)
    final completions = <DateTime, List<String>>{
      DateTime(2025, 10, 1): ['1', '2', '3'],
      DateTime(2025, 10, 2): ['1', '4'],
      DateTime(2025, 10, 3): ['1', '2', '3', '4'],
      DateTime(2025, 10, 4): ['1', '3'],
      DateTime(2025, 10, 5): ['2', '4'],
      DateTime(2025, 10, 6): ['1', '2'],
      DateTime(2025, 10, 7): ['1', '3', '4'],
      DateTime(2025, 10, 8): ['1', '2', '3'],
      DateTime(2025, 10, 9): ['1', '4'],
      DateTime(2025, 10, 10): ['1', '2', '3', '4'],
      DateTime(2025, 10, 11): ['1', '3'],
      DateTime(2025, 10, 12): ['2', '4'],
      DateTime(2025, 10, 13): ['1', '2'],
      DateTime(2025, 10, 14): ['1', '3', '4'],
      DateTime(2025, 10, 15): ['1', '2', '3'],
      DateTime(2025, 10, 16): ['1', '4'],
      DateTime(2025, 10, 17): ['1', '2', '3', '4'],
      DateTime(2025, 10, 18): ['1', '3'],
      DateTime(2025, 10, 19): ['2', '4'],
      DateTime(2025, 10, 20): ['1', '2'],
      DateTime(2025, 10, 21): ['1', '3', '4'],
      DateTime(2025, 10, 22): ['1', '2', '3'],
      DateTime(2025, 10, 23): ['1', '4'],
      DateTime(2025, 10, 24): ['1', '2', '3', '4'],
      DateTime(2025, 10, 25): ['1', '3'],
      DateTime(2025, 10, 26): ['2', '4'],
      DateTime(2025, 10, 27): ['1', '2'],
      DateTime(2025, 10, 28): ['1', '3', '4'],
    };

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => StreakCalendarScreen(
          habits: habits,
          completions: completions,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E8F5), // Light blue background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              
              // Title
              const Text(
                'Let\'s personalize your experience',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  letterSpacing: 0.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
              
              const SizedBox(height: 60),
              
              // Notifications section
              Row(
                children: [
                  // Toggle switch
                  Transform.scale(
                    scale: 1.2,
                    child: Switch(
                      value: _notificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                      },
                      activeColor: const Color(0xFF9C27B0),
                      inactiveThumbColor: const Color(0xFF8D6E63), // Brown
                      inactiveTrackColor: const Color(0xFFFFF9C4), // Light yellow
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Bell icon
                  const Icon(
                    Icons.notifications,
                    size: 28,
                    color: Color(0xFFFFD700), // Yellow
                  ),
                  const SizedBox(width: 12),
                  // Text
                  const Text(
                    'Allow notifications',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF64B5F6), // Light blue
                      letterSpacing: 0.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 50),
              
              // Theme section
              const Text(
                'Choose Theme',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  letterSpacing: 0.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
              
              const SizedBox(height: 20),
              
              Row(
                children: [
                  // Toggle switch
                  Transform.scale(
                    scale: 1.2,
                    child: Switch(
                      value: _isDarkTheme,
                      onChanged: (value) {
                        setState(() {
                          _isDarkTheme = value;
                        });
                        // Update theme in app
                        if (widget.onThemeChanged != null) {
                          widget.onThemeChanged!(value);
                        }
                      },
                      activeColor: const Color(0xFF9C27B0),
                      inactiveThumbColor: const Color(0xFF8D6E63), // Brown
                      inactiveTrackColor: const Color(0xFFFFF9C4), // Light yellow
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Light theme option
                  const Text(
                    'Light',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF64B5F6), // Light blue
                      letterSpacing: 0.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.wb_sunny,
                    size: 24,
                    color: Color(0xFFFFD700), // Yellow
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'or',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF64B5F6), // Light blue
                      letterSpacing: 0.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Dark',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF64B5F6), // Light blue
                      letterSpacing: 0.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.dark_mode,
                    size: 24,
                    color: Color(0xFFFFD700), // Yellow
                  ),
                ],
              ),
              
              const Spacer(),
              
              // Continue button
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF80CBC4), // Light blue-green
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color(0xFF9C27B0), // Purple border
                    width: 2.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF9C27B0).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _navigateToMain,
                    borderRadius: BorderRadius.circular(30),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            letterSpacing: 1.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

