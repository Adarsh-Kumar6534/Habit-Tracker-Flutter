import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;

void main() {
  runApp(MiniProjectApp());
}

class MiniProjectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HabitTrackerScreen(),
    );
  }
}

class HabitTrackerScreen extends StatefulWidget {
  @override
  _HabitTrackerScreenState createState() => _HabitTrackerScreenState();
}

class _HabitTrackerScreenState extends State<HabitTrackerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int todayStreak = 0;
  int bestStreak = 12;
  int totalHabits = 3;
  List<Habit> habits = [
    Habit(
        name: "Read 30 Minutes",
        description: "Daily reading to expand knowledge",
        streak: 8,
        progress: 0.3,
        icon: Icons.book),
    Habit(
        name: "Exercise",
        description: "Stay fit and healthy",
        streak: 12,
        progress: 0.5,
        icon: Icons.fitness_center),
    Habit(
        name: "Drink 8 Glasses Water",
        description: "Stay hydrated throughout the day",
        streak: 4,
        progress: 0.2,
        icon: Icons.local_drink),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 15),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addNewHabit() {
    String habitName = "";
    String description = "";
    int streak = 0;
    IconData? selectedIcon = Icons.add;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title:
                  Text("Add New Habit", style: TextStyle(color: Colors.white)),
              content: Container(
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Habit Name",
                        labelStyle: TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) => habitName = value,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Description",
                        labelStyle: TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) => description = value,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Initial Streak",
                        labelStyle: TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) => streak = int.tryParse(value) ?? 0,
                    ),
                    SizedBox(height: 10),
                    Text("Select Icon",
                        style: TextStyle(color: Colors.white70)),
                    GridView.count(
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      children: [
                        _IconButton(
                            icon: Icons.book,
                            selectedIcon: selectedIcon,
                            onTap: () =>
                                setState(() => selectedIcon = Icons.book)),
                        _IconButton(
                            icon: Icons.fitness_center,
                            selectedIcon: selectedIcon,
                            onTap: () => setState(
                                () => selectedIcon = Icons.fitness_center)),
                        _IconButton(
                            icon: Icons.local_drink,
                            selectedIcon: selectedIcon,
                            onTap: () => setState(
                                () => selectedIcon = Icons.local_drink)),
                        _IconButton(
                            icon: Icons.star,
                            selectedIcon: selectedIcon,
                            onTap: () =>
                                setState(() => selectedIcon = Icons.star)),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (habitName.isNotEmpty) {
                      setState(() {
                        habits.add(Habit(
                            name: habitName,
                            description: description,
                            streak: streak,
                            progress: 0.0,
                            icon: selectedIcon ?? Icons.add));
                        totalHabits++;
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Add", style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel", style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFec4899),
              Color(0xFFf472b6),
              Color(0xFF8b5cf6),
              Color(0xFF6366f1)
            ],
            stops: [0.0, 0.4, 0.7, 1.0],
            begin: Alignment(0.707, -0.707),
            end: Alignment(-0.707, 0.707),
          ),
        ),
        child: Stack(
          children: [
            CustomPaint(
              painter: ParticlePainter(0, Color(0xFFec4899), Color(0xFF6366f1)),
              child: Container(),
            ),
            Column(
              children: [
                SizedBox(height: 50),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 0),
                  opacity: 1,
                  child: Text(
                    "Habit Tracker",
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 4)
                      ],
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: 1,
                  child: Text(
                    "Build better habits, one day at a time",
                    style: TextStyle(
                        fontSize: 20, color: Colors.white.withOpacity(0.8)),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 400),
                  opacity: 1,
                  child: Text(
                    "Tuesday, July 01, 2025, 10:15 AM IST",
                    style: TextStyle(
                        fontSize: 14, color: Colors.white.withOpacity(0.6)),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  opacity: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatCard(
                            "Today", "$todayStreak", Color(0xFF8B5CF6), 180),
                        _buildStatCard("Best Streak", "$bestStreak days",
                            Color(0xFF22C55E), 180),
                        _buildStatCard("Total Habits", "$totalHabits",
                            Color(0xFFEC4899), 180),
                      ],
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 600),
                  opacity: 1,
                  child: MouseRegion(
                    onHover: (event) {
                      setState(() {});
                    },
                    child: GestureDetector(
                      onTap: _addNewHabit,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF8B5CF6).withOpacity(0.6),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Text(
                          "+ Add New Habit",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: habits.length,
                    itemBuilder: (context, index) {
                      return AnimatedOpacity(
                        duration: Duration(milliseconds: 500 + (index * 100)),
                        opacity: 1,
                        child: _buildHabitCard(habits[index], index),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrb(
      double width, double height, Color color, double duration, double delay) {
    return AnimatedContainer(
      duration: Duration(milliseconds: (duration * 1000).toInt()),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(width / 2),
      ),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: color, blurRadius: 24)],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color, double width) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: width,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                  color: color.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5))
            ],
          ),
          child: Column(
            children: [
              Icon(Icons.star, size: 20, color: color),
              SizedBox(height: 8),
              Text(label,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w500)),
              SizedBox(height: 4),
              Text(value,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHabitCard(Habit habit, int index) {
    Color cardColor = _getHabitColor(habit);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (habit.progress < 1.0) {
              double newProgress = habit.progress + 0.1;
              habit.progress =
                  newProgress.clamp(0.0, 1.0); // Cap at 100% immediately
            }
            habits[index] = habit;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.only(bottom: 24),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [cardColor.withOpacity(0.2), cardColor.withOpacity(0.1)],
              begin: Alignment(0.707, 0.707),
              end: Alignment(-0.707, -0.707),
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: cardColor.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                  color: cardColor.withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(0, 10)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          cardColor.withOpacity(0.3),
                          cardColor.withOpacity(0.2)
                        ],
                        begin: Alignment(0.707, 0.707),
                        end: Alignment(-0.707, -0.707),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(habit.icon, color: Colors.white70, size: 24),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(habit.name,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                      Text(habit.description,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.7),
                              height: 1.4)),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white.withOpacity(0.3), width: 2),
                      borderRadius: BorderRadius.circular(24),
                      color: habit.progress >= 1.0
                          ? Color(0xFF22C55E)
                          : Colors.transparent, // Green when 100%
                      boxShadow: habit.progress >= 1.0
                          ? [
                              BoxShadow(
                                  color: Color(0xFF22C55E).withOpacity(0.4),
                                  blurRadius: 20)
                            ]
                          : [],
                    ),
                    child: habit.progress >= 1.0
                        ? Lottie.asset('assets/confetti.json',
                            width: 48, height: 48, fit: BoxFit.cover)
                        : null, // Confetti at 100%
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.local_fire_department,
                          size: 16, color: Color(0xFFf97316)),
                      SizedBox(width: 8),
                      Text("Streak: ",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8))),
                      Text("${habit.streak}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  SizedBox(
                    width: 120,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Stack(
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 1000),
                            width: 120 *
                                (habit.progress > 1.0
                                    ? 1.0
                                    : habit.progress), // Cap width at 100%
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF8B5CF6).withOpacity(0.5),
                                    blurRadius: 20)
                              ],
                            ),
                          ),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 2000),
                            width: 120,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.white.withOpacity(0.2),
                                  Colors.transparent
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                      "This Week: ${(habit.progress * 100).toStringAsFixed(0)}%",
                      style: TextStyle(
                          fontSize: 14, color: Colors.white.withOpacity(0.7))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getHabitColor(Habit habit) {
    if (habit.name.contains("Read")) return Color(0xFF3B82F6); // Blue
    if (habit.name.contains("Exercise")) return Color(0xFF22C55E); // Green
    if (habit.name.contains("Drink")) return Color(0xFF06B6D4); // Cyan
    return Color(0xFFf97316); // Default (Orange)
  }
}

class ParticlePainter extends CustomPainter {
  final double animationValue;
  final Color startColor;
  final Color endColor;

  ParticlePainter(this.animationValue, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final random = math.Random();

    for (int i = 0; i < 20; i++) {
      double x = (size.width * (i / 20) + animationValue * 50) % size.width;
      double y = (size.height * (0.2 + (i % 5) * 0.15) + animationValue * 30) %
          size.height;
      Color particleColor =
          Color.lerp(startColor, endColor, i / 20) ?? startColor;
      paint.color = particleColor.withOpacity(0.5);
      canvas.drawCircle(Offset(x, y), 4,
          paint..maskFilter = MaskFilter.blur(BlurStyle.normal, 5));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Habit {
  String name;
  String description;
  int streak;
  double progress;
  IconData icon;

  Habit(
      {required this.name,
      required this.description,
      required this.streak,
      required this.progress,
      required this.icon});
}

class _IconButton extends StatefulWidget {
  final IconData icon;
  final IconData? selectedIcon;
  final Function() onTap;

  const _IconButton(
      {required this.icon, required this.selectedIcon, required this.onTap});

  @override
  __IconButtonState createState() => __IconButtonState();
}

class __IconButtonState extends State<_IconButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.selectedIcon == widget.icon;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected || isHovered
                ? Colors.white.withOpacity(0.2)
                : Colors.white.withOpacity(0.05),
            border: Border.all(
              color: isSelected
                  ? Color(0xFF00FF7F)
                      .withOpacity(0.8) // Neon green for selected
                  : isHovered
                      ? Color(0xFF00FF7F)
                          .withOpacity(0.5) // Lighter green for hover
                      : Colors.white.withOpacity(0.2),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected || isHovered
                ? [
                    BoxShadow(
                      color:
                          Color(0xFF00FF7F).withOpacity(isSelected ? 0.4 : 0.2),
                      blurRadius: isSelected ? 10 : 5,
                      spreadRadius: isSelected ? 1 : 0,
                    ),
                  ]
                : [],
          ),
          child: Icon(widget.icon, color: Colors.white70, size: 20),
        ),
      ),
    );
  }
}
