import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class VibeQuizScreen extends StatefulWidget {
  const VibeQuizScreen({super.key});

  @override
  State<VibeQuizScreen> createState() => _VibeQuizScreenState();
}

class _VibeQuizScreenState extends State<VibeQuizScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> questions = [
    {
      'question': "How do you spend your weekend?",
      'answers': [
        {"text": "🎉 Out with friends", "score": 5},
        {"text": "📺 Binge & chill", "score": 3},
        {"text": "🌿 Alone time", "score": 1}
      ]
    },
    {
      'question': "Your texting style?",
      'answers': [
        {"text": "😄 Fast & emojis", "score": 5},
        {"text": "🙂 Thoughtful replies", "score": 3},
        {"text": "😌 Short & sweet", "score": 1}
      ]
    },
    {
      'question': "How do you decide things?",
      'answers': [
        {"text": "💡 Go with the flow", "score": 5},
        {"text": "🤔 Pros & cons", "score": 3},
        {"text": "😴 Avoid decisions", "score": 1}
      ]
    },
    {
      'question': "People you vibe with?",
      'answers': [
        {"text": "🌈 Energetic & loud", "score": 5},
        {"text": "🍃 Calm & chill", "score": 3},
        {"text": "🌙 Quiet & deep", "score": 1}
      ]
    },
  ];

  int currentIndex = 0;
  int totalScore = 0;

  void answerQuestion(int score) {
    setState(() {
      totalScore += score;
      currentIndex++;
    });

    if (currentIndex == questions.length) {
      Future.delayed(const Duration(milliseconds: 300), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MatchScreen(score: totalScore)),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentIndex >= questions.length) {
      return const Center(child: CircularProgressIndicator());
    }

    final question = questions[currentIndex];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/vibe.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "🎯 Cool Side Vibe Quiz",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 4,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) => SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                  child: Container(
                    key: ValueKey(currentIndex),
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 8),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          question['question'],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        ...(question['answers'] as List<Map<String, dynamic>>)
                            .map((answer) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: ElevatedButton(
                                    onPressed: () => answerQuestion(answer['score']),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurpleAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text(
                                      answer['text'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MatchScreen extends StatelessWidget {
  final int score;

  const MatchScreen({super.key, required this.score});

  String getVibeType() {
    if (score >= 16) return "⚡ Electric Spark";
    if (score >= 10) return "🌊 Flow Rider";
    return "☁️ Dreamy Cloud";
  }

  List<Map<String, String>> getMatches() {
    if (score >= 16) {
      return [
        {'name': 'FlashByte ⚡', 'emoji': '🧑‍💻'},
        {'name': 'NeonNova 💫', 'emoji': '👾'},
        {'name': 'VibeCharger 🔋', 'emoji': '🚀'},
      ];
    } else if (score >= 10) {
      return [
        {'name': 'CalmFlow 🌊', 'emoji': '🧘‍♀️'},
        {'name': 'FocusFox 🦊', 'emoji': '📚'},
        {'name': 'BalanceBot ⚖️', 'emoji': '🤖'},
      ];
    } else {
      return [
        {'name': 'ChillPuff ☁️', 'emoji': '😌'},
        {'name': 'QuietSoul 🌙', 'emoji': '🌸'},
        {'name': 'DreamWalker 💭', 'emoji': '🐚'},
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final vibe = getVibeType();
    final matches = getMatches();

    return Scaffold(
      backgroundColor: const Color(0xFFF3E8FF),
      appBar: AppBar(
        title: const Text("Your Vibe Circle"),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "You're a $vibe",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "Here are some people with your vibe:",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Expanded(
              child: ListView.builder(
                  itemCount: matches.length,
                  itemBuilder: (context, index) {
                    final user = matches[index];
                    return Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 24,
                          child: Text(user['emoji']!),
                        ),
                        title: Text(
                          user['name']!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          onPressed: () {},
                          child: const Text(
                            "Connect",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }))
        ]),
      ),
    );
  }
}
