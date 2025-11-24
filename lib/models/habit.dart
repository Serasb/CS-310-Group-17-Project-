class Habit {
  final String id;
  final String name;
  final HabitIcon icon;

  Habit({
    required this.id,
    required this.name,
    required this.icon,
  });
}

enum HabitIcon {
  waterDrop,      // Drink Water - mavi su damlası
  meditation,     // Meditation - siyah meditasyon figürü
  readingBook,    // Reading Book - kahverengi kitap yığını
  learnCode,      // Learn Code - masaüstü bilgisayar
}

extension HabitIconExtension on HabitIcon {
  String get displayName {
    switch (this) {
      case HabitIcon.waterDrop:
        return 'Drink Water';
      case HabitIcon.meditation:
        return 'Meditation';
      case HabitIcon.readingBook:
        return 'Reading Book';
      case HabitIcon.learnCode:
        return 'Learn Code';
    }
  }
}

