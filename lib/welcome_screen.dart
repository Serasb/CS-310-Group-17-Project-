import 'package:flutter/material.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final Function(bool)? onThemeChanged;
  
  const WelcomeScreen({super.key, this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E8F5), // Light blue background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              
              // Welcome to text
              const Text(
                'Welcome to',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  color: Colors.black87,
                  letterSpacing: 1.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // PERPETUA title
              const Text(
                'PERPETUA',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF64B5F6), // Blue
                  letterSpacing: 2.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Heart-shaped chain icon
              CustomPaint(
                size: const Size(120, 120),
                painter: HeartChainPainter(),
              ),
              
              const SizedBox(height: 40),
              
              // Motivational message
              const Text(
                'Build positive habits and keep your streak alive – don\'t break the chain!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  letterSpacing: 0.5,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
              ),
              
              const Spacer(flex: 3),
              
              // Get Started button
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF64B5F6), // Light blue
                      Color(0xFFBA68C8), // Light purple
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color(0xFF9C27B0), // Purple border
                    width: 2.0,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(
                            onThemeChanged: onThemeChanged,
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: Text(
                          'Get Started',
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

// Custom painter for heart-shaped chain
class HeartChainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFC0C0C0) // Silver color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final heartSize = size.width * 0.4;

    final path = Path();
    
    // Draw heart shape
    // Left curve
    path.moveTo(centerX, centerY + heartSize * 0.3);
    path.cubicTo(
      centerX - heartSize * 0.5,
      centerY - heartSize * 0.2,
      centerX - heartSize * 0.7,
      centerY - heartSize * 0.5,
      centerX - heartSize * 0.3,
      centerY - heartSize * 0.5,
    );
    path.cubicTo(
      centerX - heartSize * 0.1,
      centerY - heartSize * 0.5,
      centerX,
      centerY - heartSize * 0.2,
      centerX,
      centerY,
    );
    
    // Right curve
    path.cubicTo(
      centerX,
      centerY - heartSize * 0.2,
      centerX + heartSize * 0.1,
      centerY - heartSize * 0.5,
      centerX + heartSize * 0.3,
      centerY - heartSize * 0.5,
    );
    path.cubicTo(
      centerX + heartSize * 0.7,
      centerY - heartSize * 0.5,
      centerX + heartSize * 0.5,
      centerY - heartSize * 0.2,
      centerX,
      centerY + heartSize * 0.3,
    );

    canvas.drawPath(path, paint);

    // Draw chain links (circles along the heart path)
    final linkPaint = Paint()
      ..color = const Color(0xFFC0C0C0)
      ..style = PaintingStyle.fill;

    // Draw multiple chain links
    for (int i = 0; i < 8; i++) {
      final t = i / 7.0;
      double x, y;
      
      if (t < 0.5) {
        // Left side of heart
        x = centerX - heartSize * 0.5 * (1 - t * 2);
        y = centerY - heartSize * 0.3 * (1 - t * 2);
      } else {
        // Right side of heart
        x = centerX + heartSize * 0.5 * ((t - 0.5) * 2);
        y = centerY - heartSize * 0.3 * ((t - 0.5) * 2);
      }
      
      canvas.drawCircle(Offset(x, y), 6, linkPaint);
      canvas.drawCircle(Offset(x, y), 6, paint); // Outline
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

