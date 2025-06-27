import 'package:flutter/material.dart';

class SideToggleScreen extends StatefulWidget {
  const SideToggleScreen({super.key});

  @override
  State<SideToggleScreen> createState() => _SideToggleScreenState();
}

class _SideToggleScreenState extends State<SideToggleScreen> {
  bool isCoolSide = true;

  @override
  Widget build(BuildContext context) {
    final String side = isCoolSide ? "Cool Side" : "Nerd Side";
    final String emoji = isCoolSide ? "😎" : "🧠";
    final Color primaryColor = isCoolSide ? Colors.deepPurple : Colors.teal;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isCoolSide
                ? [Colors.purple.shade200, Colors.blue.shade300]
                : [Colors.green.shade300, Colors.blueGrey.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "$emoji $side",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              ToggleButtons(
                borderRadius: BorderRadius.circular(30),
                isSelected: [isCoolSide, !isCoolSide],
                onPressed: (index) {
                  setState(() {
                    isCoolSide = index == 0;
                  });
                },
                selectedColor: Colors.white,
                fillColor: Colors.black.withOpacity(0.2),
                color: Colors.white70,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("😎 Cool Side", style: TextStyle(fontSize: 16)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("🧠 Nerd Side", style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  if (isCoolSide) {
                    Navigator.pushNamed(context, '/signin'); // 👈 go to sign-in
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Nerd Side coming soon!"),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                ),
                child: Text(
                  "Continue to $side",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
