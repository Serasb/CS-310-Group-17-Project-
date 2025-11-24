import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? agreeValue;

  Widget _yesNoBox({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple : Colors.white54,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.deepPurple : Colors.grey,
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E8F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              const Center(
                child: Text(
                  "Create your account",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Registration",
                style: TextStyle(
                  color: Color(0xFF9C27B0),
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 25),

              const Text("Full Name",
                  style: TextStyle(fontSize: 14, color: Colors.black)),
              const SizedBox(height: 8),
              _inputBox(),

              const SizedBox(height: 20),

              const Text("Email Address",
                  style: TextStyle(fontSize: 14, color: Colors.black)),
              const SizedBox(height: 8),
              _inputBox(),

              const SizedBox(height: 20),

              const Text("Password",
                  style: TextStyle(fontSize: 14, color: Colors.black)),
              const SizedBox(height: 8),
              _inputBox(obscure: true),

              const SizedBox(height: 30),

              const Text(
                "I agree to the Terms and Privacy Policy",
                style: TextStyle(color: Color(0xFF9C27B0)),
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _yesNoBox(
                    label: "Yes",
                    isSelected: agreeValue == "yes",
                    onTap: () {
                      setState(() {
                        agreeValue = "yes";
                      });
                    },
                  ),
                  const SizedBox(width: 16),
                  _yesNoBox(
                    label: "No",
                    isSelected: agreeValue == "no",
                    onTap: () {
                      setState(() {
                        agreeValue = "no";
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF9C27B0),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  child: const Text(
                    "Register now",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputBox({bool obscure = false}) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
