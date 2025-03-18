import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

    return Consumer<LocalizationProvider>(
      builder: (context, localizationProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(localizationProvider.locale.languageCode == 'fr'
                ? 'Quiz App'
                : localizationProvider.locale.languageCode == 'en'
                    ? 'Quiz App'
                    : 'تطبيق الاختبارات'),
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
                  Text(
                    localizationProvider.locale.languageCode == 'fr'
                        ? 'Quiz App'
                        : localizationProvider.locale.languageCode == 'en'
                            ? 'Quiz App'
                            : 'تطبيق الاختبارات',
                    style: const TextStyle(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      localizationProvider.locale.languageCode == 'fr'
                          ? 'Commencer un quiz'
                          : localizationProvider.locale.languageCode == 'en'
                              ? 'Start a quiz'
                              : 'بدء اختبار',
                      style: const TextStyle(
                          fontSize: 18, color: Colors.blueAccent),
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
                    child: Text(
                      localizationProvider.locale.languageCode == 'fr'
                          ? 'Voir le classement'
                          : localizationProvider.locale.languageCode == 'en'
                              ? 'View leaderboard'
                              : 'عرض لوحة المتصدرين',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      // Naviguer vers l'écran "À propos"
                    },
                    child: Text(
                      localizationProvider.locale.languageCode == 'fr'
                          ? 'À propos'
                          : localizationProvider.locale.languageCode == 'en'
                              ? 'About'
                              : 'حول',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}