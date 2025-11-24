import 'package:flutter/material.dart';
import 'personalization_screen.dart';

class LoginScreen extends StatefulWidget {
  final Function(bool)? onThemeChanged;
  
  const LoginScreen({super.key, this.onThemeChanged});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoginMode = true; // true for Login, false for Create Account
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _navigateToPersonalization() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PersonalizationScreen(
          onThemeChanged: widget.onThemeChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F2F7), // Light blue background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              
              // PERPETUA Title
              const Text(
                'PERPETUA',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C5F8C), // Dark blue
                  letterSpacing: 2.0,
                  fontStyle: FontStyle.italic,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 50),
              
              // Login / Create Account buttons
              Row(
                children: [
                  Expanded(
                    child: _buildTopButton('Login', _isLoginMode, () {
                      setState(() {
                        _isLoginMode = true;
                      });
                    }),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTopButton('Create an account', !_isLoginMode, () {
                      setState(() {
                        _isLoginMode = false;
                      });
                    }),
                  ),
                ],
              ),
              
              const SizedBox(height: 40),
              
              // Email Address field
              _buildInputField(
                controller: _emailController,
                hintText: 'Email Address',
              ),
              
              const SizedBox(height: 20),
              
              // Password field
              _buildInputField(
                controller: _passwordController,
                hintText: 'Password',
                isPassword: true,
              ),
              
              const Spacer(),
              
              // Login button
              _buildLoginButton(),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF80D8DA), // Light teal
              Color(0xFFA0D8F0), // Light blue
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              letterSpacing: 0.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF80B3FF), // Light blue interior
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF9933FF), // Purple border
          width: 2.0,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontStyle: FontStyle.italic,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFFE0F2F7), // Light blue placeholder
            fontSize: 16,
            fontStyle: FontStyle.italic,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF80D8DA), // Light teal
            Color(0xFFA0D8F0), // Light blue
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF9933FF), // Purple border
          width: 2.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _navigateToPersonalization,
          borderRadius: BorderRadius.circular(12),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 18,
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
    );
  }
}

