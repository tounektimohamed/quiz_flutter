import 'package:shared_preferences/shared_preferences.dart';

class ScoreService {
  static const String _scoreKey = 'scores';

  // Enregistrer un score
  static Future<void> saveScore({
    required String category,
    required String difficulty,
    required int score,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${category}_${difficulty}';
    final scores = prefs.getStringList(_scoreKey) ?? [];

    // Ajouter le nouveau score
    scores.add('$key:$score');

    // Trier les scores (du plus élevé au plus bas)
    scores.sort((a, b) {
      final scoreA = int.parse(a.split(':')[1]);
      final scoreB = int.parse(b.split(':')[1]);
      return scoreB.compareTo(scoreA);
    });

    // Garder uniquement les 10 meilleurs scores
    if (scores.length > 10) {
      scores.removeRange(10, scores.length);
    }

    // Enregistrer les scores
    await prefs.setStringList(_scoreKey, scores);
  }

  // Récupérer les scores pour une catégorie et une difficulté
  static Future<List<int>> getScores({
    required String category,
    required String difficulty,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final scores = prefs.getStringList(_scoreKey) ?? [];
    final key = '${category}_${difficulty}';

    // Filtrer les scores pour la catégorie et la difficulté spécifiées
    return scores
        .where((entry) => entry.startsWith(key))
        .map((entry) => int.parse(entry.split(':')[1]))
        .toList();
  }

  // Réinitialiser tous les scores
  static Future<void> resetScores() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_scoreKey);
  }
}