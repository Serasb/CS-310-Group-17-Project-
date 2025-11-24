import 'package:flutter/material.dart';

List<String> habitNames = ["HABIT 1", "HABIT 2", "HABIT 3", "HABIT 4"];
List<String> habitStreaks = ["5D", "3D", "5D", "4D"];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<bool> habitDone = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E8F5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 20),

            // TOP TEXTS ---------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  // PROFILE
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    child: const Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  // TODAY'S DATE
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/date');
                    },
                    child: const Text(
                      "Today's Date",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  // KEEP THE CHAIN ALIVE
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/streaks');
                    },
                    child: const Text(
                      "Keep the chain alive",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // YOUR HABITS TITLE --------------------------------------------------
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Your habits",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // HABIT LIST ---------------------------------------------------------
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: habitNames.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        habitNames.removeAt(index);
                        habitStreaks.removeAt(index);
                        habitDone.removeAt(index);
                      });
                    },
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      color: Colors.red,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/habitDetail'),
                      child: habitTile(habitNames[index], habitStreaks[index], index),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // SWIPE + CLICK INFO -------------------------------------------------
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/habitDetail'),
              child: const Center(
                child: Text(
                  "Swipe left to delete",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),

            const SizedBox(height: 4),

            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/habitDetail'),
              child: const Center(
                child: Text(
                  "Click on the habit to see details",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ADD BUTTON ---------------------------------------------------------
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/addHabit');
                },
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(Icons.add, size: 30),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      // BOTTOM NAV BAR ----------------------------------------------------------
      bottomNavigationBar: Container(
        height: 65,
        color: const Color(0xFFE8EFF3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/reminders'),
              child: const Text("REMINDERS"),
            ),

            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/stats'),
              child: const Text("STATS"),
            ),

            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/streaks'),
              child: const Text("STREAKS"),
            ),

            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/settings'),
              child: const Text("SETTINGS"),
            ),
          ],
        ),
      ),
    );
  }

  // HABIT TILE WITH TOGGLE ---------------------------------------------------
  Widget habitTile(String name, String streak, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xFFE8EFF3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),

          // TOGGLE BUTTON
          GestureDetector(
            onTap: () {
              setState(() {
                habitDone[index] = !habitDone[index];
              });
            },
            child: Icon(
              habitDone[index] ? Icons.toggle_on : Icons.toggle_off,
              size: 38,
              color: habitDone[index]
                  ? const Color(0xFF9C27B0)
                  : Colors.grey,
            ),
          ),

          const SizedBox(width: 12),

          // HABIT NAME
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: habitDone[index]
                    ? const Color(0xFF9C27B0)
                    : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // FLAME
          const Icon(Icons.local_fire_department, color: Colors.orange),

          const SizedBox(width: 4),

          // STREAK
          Text(
            streak,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
