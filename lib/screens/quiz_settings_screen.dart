import 'package:flutter/material.dart';
import 'quiz_screen.dart'; // Pour naviguer vers l'écran du quiz

class QuizSettingsScreen extends StatefulWidget {
  const QuizSettingsScreen({super.key});

  @override
  _QuizSettingsScreenState createState() => _QuizSettingsScreenState();
}

class _QuizSettingsScreenState extends State<QuizSettingsScreen> {
  String? selectedCategory;
  String? selectedDifficulty;
  int? selectedNumberOfQuestions;

  // Exemple de catégories (à remplacer par les données de l'API OpenTDB)
  final List<String> categories = [
    'Sciences',
    'Histoire',
    'Divertissement',
    'Géographie',
    'Art',
  ];

  final List<String> difficulties = ['Facile', 'Moyen', 'Difficile'];
  final List<int> numberOfQuestions = [5, 10, 15, 20];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres du Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Sélection de la catégorie
            DropdownButtonFormField<String>(
              value: selectedCategory,
              hint: const Text('Choisissez une catégorie'),
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Sélection de la difficulté
            DropdownButtonFormField<String>(
              value: selectedDifficulty,
              hint: const Text('Choisissez la difficulté'),
              items: difficulties.map((difficulty) {
                return DropdownMenuItem(
                  value: difficulty,
                  child: Text(difficulty),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDifficulty = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Sélection du nombre de questions
            DropdownButtonFormField<int>(
              value: selectedNumberOfQuestions,
              hint: const Text('Choisissez le nombre de questions'),
              items: numberOfQuestions.map((number) {
                return DropdownMenuItem(
                  value: number,
                  child: Text('$number questions'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedNumberOfQuestions = value;
                });
              },
            ),
            const SizedBox(height: 40),

            // Bouton pour commencer le quiz
            ElevatedButton(
              onPressed: () {
                if (selectedCategory != null &&
                    selectedDifficulty != null &&
                    selectedNumberOfQuestions != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(
                        category: selectedCategory!,
                        difficulty: selectedDifficulty!,
                        numberOfQuestions: selectedNumberOfQuestions!,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Veuillez sélectionner tous les paramètres.'),
                    ),
                  );
                }
              },
              child: const Text('Commencer le quiz'),
            ),
          ],
        ),
      ),
    );
  }
}