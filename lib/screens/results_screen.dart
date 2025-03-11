import 'package:flutter/material.dart';
import 'package:quiz_ala/services/score_service.dart';

class ResultsScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final List<Map<String, dynamic>> userAnswers;
  final String category;
  final String difficulty;

  const ResultsScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.userAnswers,
    required this.category,
    required this.difficulty,
  });

  @override
  Widget build(BuildContext context) {
    // Enregistrer le score après la fin du quiz
    ScoreService.saveScore(
      category: category,
      difficulty: difficulty,
      score: score,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Résultats'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Votre score: $score / $totalQuestions',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: userAnswers.length,
                itemBuilder: (context, index) {
                  final answer = userAnswers[index];
                  return ListTile(
                    title: Text(answer['question']),
                    subtitle: Text(
                      'Votre réponse: ${answer['userAnswer']}\n'
                      'Réponse correcte: ${answer['correctAnswer']}',
                    ),
                    tileColor: answer['isCorrect'] ? Colors.green[50] : Colors.red[50],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Retour à l'écran précédent
                  },
                  child: const Text('Rejouer'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst); // Retour à l'écran d'accueil
                  },
                  child: const Text('Accueil'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}