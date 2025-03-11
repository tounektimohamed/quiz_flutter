import 'package:flutter/material.dart';
import 'package:quiz_ala/screens/leaderboard_screen.dart';
import 'package:quiz_ala/services/notification_service.dart';
import 'quiz_settings_screen.dart';
import 'settings_screen.dart'; // Importez l'écran des paramètres

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialiser le service de notifications
    final notificationService = NotificationService();

    // Planifier une notification quotidienne à 10h00
    notificationService.scheduleDailyNotification(
      id: 1,
      title: 'Quiz du jour',
      body: 'Venez jouer à un nouveau quiz !',
      time: const TimeOfDay(
          hour: 10, minute: 0), // Heure de la notification (10h00)
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings), // Icône de paramètres
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Quiz App',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuizSettingsScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Commencer un quiz',
                  style: TextStyle(fontSize: 18, color: Colors.blueAccent),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LeaderboardScreen(
                        category:
                            'Sciences', // Remplacez par la catégorie souhaitée
                        difficulty:
                            'Facile', // Remplacez par la difficulté souhaitée
                      ),
                    ),
                  );
                },
                child: const Text('Voir le classement'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Naviguer vers l'écran "À propos"
                },
                child: const Text(
                  'À propos',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
