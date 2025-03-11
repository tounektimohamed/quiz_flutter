import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question_model.dart';

class ApiService {
  // Récupérer les questions depuis l'API OpenTDB
  static Future<List<Question>> fetchQuestions({
    required String category,
    required String difficulty,
    required int numberOfQuestions,
  }) async {
    // Convertir la catégorie en ID
    final categoryId = _getCategoryId(category);

    // Convertir la difficulté en valeurs attendues par l'API
    final difficultyLevel = _getDifficultyLevel(difficulty);

    // Construire l'URL de l'API
    final url =
        'https://opentdb.com/api.php?amount=$numberOfQuestions&category=$categoryId&difficulty=$difficultyLevel&type=multiple';

    print('URL de l\'API: $url'); // Log pour vérifier l'URL

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Vérifier si des questions sont retournées
        if (data['results'] != null && data['results'].isNotEmpty) {
          return (data['results'] as List).map((question) {
            return Question(
              text: question['question'],
              answers: [
                Answer(text: question['correct_answer'], isCorrect: true),
                ...(question['incorrect_answers'] as List).map((incorrectAnswer) {
                  return Answer(text: incorrectAnswer, isCorrect: false);
                }).toList(),
              ]..shuffle(),
            );
          }).toList();
        } else {
          throw Exception('Aucune question trouvée pour les paramètres donnés.');
        }
      } else {
        throw Exception('Échec du chargement des questions. Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur lors de la récupération des questions: $e');
    }
  }

  // Convertir la catégorie en ID pour l'API
  static int _getCategoryId(String category) {
    switch (category) {
      case 'Sciences':
        return 17;
      case 'Histoire':
        return 23;
      case 'Divertissement':
        return 11;
      case 'Géographie':
        return 22;
      case 'Art':
        return 25;
      default:
        return 9; // Catégorie par défaut (Général)
    }
  }

  // Convertir la difficulté en valeurs attendues par l'API
  static String _getDifficultyLevel(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'facile':
        return 'easy';
      case 'moyen':
        return 'medium';
      case 'difficile':
        return 'hard';
      default:
        return 'easy'; // Valeur par défaut
    }
  }

  // Récupérer la liste des catégories disponibles
  static Future<List<Map<String, dynamic>>> fetchCategories() async {
    final url = 'https://opentdb.com/api_category.php';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['trivia_categories'] != null) {
          return (data['trivia_categories'] as List).map((category) {
            return {
              'id': category['id'],
              'name': category['name'],
            };
          }).toList();
        } else {
          throw Exception('Aucune catégorie trouvée.');
        }
      } else {
        throw Exception('Échec du chargement des catégories. Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur lors de la récupération des catégories: $e');
    }
  }
}