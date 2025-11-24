import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// -----------------------------------------------------------------------------
// 1. MyApp:
// -----------------------------------------------------------------------------
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  ThemeMode _themeMode = ThemeMode.dark;


  void _changeTheme(String theme) {
    setState(() {
      if (theme == "Dark") {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.light;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const String customFontFamily = 'Sans-serif';

    // Dark Theme
    final darkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF141F28), //
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF141F28),
        elevation: 0,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(fontFamily: customFontFamily, fontSize: 40, color: Colors.white, fontStyle: FontStyle.italic),
        bodyLarge: TextStyle(fontFamily: customFontFamily, fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300),
        titleLarge: TextStyle(fontFamily: customFontFamily, fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      useMaterial3: true,
    );

    // Light Theme
    final lightTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.grey.shade50,
      textTheme: TextTheme(
        // Light Theme
        displayLarge: TextStyle(fontFamily: customFontFamily, fontSize: 40, color: Colors.black, fontStyle: FontStyle.italic),
        bodyLarge: TextStyle(fontFamily: customFontFamily, fontSize: 18, color: Colors.black, fontWeight: FontWeight.w300),
        titleLarge: TextStyle(fontFamily: customFontFamily, fontSize: 32, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      useMaterial3: true,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perpetua',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,

      home: WelcomePage(onThemeChanged: _changeTheme),
    );
  }
}

// -----------------------------------------------------------------------------
// --- WelcomePage (Page 1) ---
// -----------------------------------------------------------------------------
class WelcomePage extends StatelessWidget {
  final Function(String theme) onThemeChanged;

  const WelcomePage({required this.onThemeChanged, super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;


    const darkGradientStart = Color(0xFFB1ECFF);
    const darkGradientEnd = Color(0xFF6F88FF);
    const lightGradientStart = Color(0xFF87CEEB);
    const lightGradientEnd = Color(0xFF4682B4);

    final gradientStart = isDarkMode ? darkGradientStart : lightGradientStart;
    final gradientEnd = isDarkMode ? darkGradientEnd : lightGradientEnd;
    final primaryTextColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to",
                style: textTheme.displayLarge!.copyWith(
                  fontSize: 48,
                  fontWeight: FontWeight.w100,
                  color: primaryTextColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "PERPETUA",
                style: textTheme.displayLarge!.copyWith(
                  fontSize: 56,
                  color: gradientStart,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),

              // Heart Chain Image (use of ASSET)
              Image.asset(
                'assets/metal_heart_chain.jpg',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 50),

              // Slogan Text
              Text(
                "Build positive habits and keep\nyour streak alive – don’t break\nthe chain!",
                style: textTheme.bodyLarge!.copyWith(
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 50),

              // Get Started Button (with Gradient)
              Container(
                width: 200,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [gradientStart, gradientEnd],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PersonalizePage(
                            onThemeChanged: onThemeChanged,
                          )),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    "Get Started",
                    style: textTheme.bodyLarge!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// --- PersonalizePage (Page 2) ---
// -----------------------------------------------------------------------------
class PersonalizePage extends StatefulWidget {
  final Function(String theme) onThemeChanged;

  const PersonalizePage({required this.onThemeChanged, super.key});

  @override
  State<PersonalizePage> createState() => _PersonalizePageState();
}

class _PersonalizePageState extends State<PersonalizePage> {
  bool notificationsAllowed = false;

  String selectedTheme = ThemeMode.dark == ThemeMode.dark ? "Dark" : "Light";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    selectedTheme = isDarkMode ? "Dark" : "Light";
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor = isDarkMode ? Colors.white : Colors.black;


    const darkGradientStart = Color(0xFFB1ECFF);
    const darkGradientEnd = Color(0xFF6F88FF);
    const lightGradientStart = Color(0xFF87CEEB);
    const lightGradientEnd = Color(0xFF4682B4);

    final gradientStart = isDarkMode ? darkGradientStart : lightGradientStart;
    final gradientEnd = isDarkMode ? darkGradientEnd : lightGradientEnd;

    // Switch inactive color
    final inactiveThumbColor = isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400;
    final inactiveTrackColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300;


    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70),
            Text(
              "Let’s personalize\nyour experience",
              style: textTheme.displayLarge!.copyWith(fontSize: 48, height: 1.2, color: primaryTextColor),
            ),
            const SizedBox(height: 70),

            // Allow Notifications Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                        Icons.notifications_active_outlined,
                        color: isDarkMode ? Colors.amber : Colors.orange.shade700,
                        size: 28
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Allow notifications",
                      style: textTheme.bodyLarge!.copyWith(fontSize: 24, fontWeight: FontWeight.w500, color: primaryTextColor),
                    ),
                  ],
                ),
                // Switch (Material 3 )
                Switch(
                  value: notificationsAllowed,
                  onChanged: (value) {
                    setState(() {
                      notificationsAllowed = value;
                    });
                  },
                  activeThumbColor: gradientStart,
                  activeTrackColor: gradientStart.withOpacity(0.5),
                  inactiveThumbColor: inactiveThumbColor,
                  inactiveTrackColor: inactiveTrackColor,
                ),
              ],
            ),

            const SizedBox(height: 70),

            // Choose Theme Text
            Text(
              "Choose Theme",
              style: textTheme.displayLarge!.copyWith(fontSize: 32, color: primaryTextColor),
            ),

            const SizedBox(height: 20),

            // Theme Switch Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedTheme == "Light"
                      ? "Light ☀️"
                      : "Dark 🌙",
                  style: textTheme.bodyLarge!.copyWith(fontSize: 24, fontWeight: FontWeight.w500, color: primaryTextColor),
                ),
                Switch(
                  value: selectedTheme == "Dark",
                  onChanged: (value) {
                    final newTheme = value ? "Dark" : "Light";
                    setState(() {
                      selectedTheme = newTheme;
                    });
                    widget.onThemeChanged(newTheme);
                  },
                  activeThumbColor: gradientStart,
                  activeTrackColor: gradientStart.withOpacity(0.5),
                  inactiveThumbColor: inactiveThumbColor,
                  inactiveTrackColor: inactiveTrackColor,
                ),
              ],
            ),

            const Spacer(),

            // Continue Button (with Gradient)
            Center(
              child: Container(
                width: 250,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [gradientStart, gradientEnd],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Settings saved. Theme: $selectedTheme, Notifications: $notificationsAllowed'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    "Continue",
                    style: textTheme.bodyLarge!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}