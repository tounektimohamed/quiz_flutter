import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_ala/screens/settings_screen.dart';
import 'quiz_screen.dart'; // Pour naviguer vers l'écran du quiz

class QuizSettingsScreen extends StatefulWidget {
  const QuizSettingsScreen({super.key});

  @override
  _QuizSettingsScreenState createState() => _QuizSettingsScreenState();
}

class _QuizSettingsScreenState extends State<QuizSettingsScreen> {
  Map<String, dynamic>? selectedCategory;
  Map<String, dynamic>? selectedDifficulty;
  int? selectedNumberOfQuestions;

  // Catégories avec traductions et IDs pour l'API
  final List<Map<String, dynamic>> categories = [
    {'id': 17, 'name': 'Sciences', 'en': 'Science', 'ar': 'العلوم'},
    {'id': 23, 'name': 'Histoire', 'en': 'History', 'ar': 'التاريخ'},
    {'id': 11, 'name': 'Divertissement', 'en': 'Entertainment', 'ar': 'الترفيه'},
    {'id': 22, 'name': 'Géographie', 'en': 'Geography', 'ar': 'الجغرافيا'},
    {'id': 25, 'name': 'Art', 'en': 'Art', 'ar': 'الفن'},
  ];

  // Difficultés avec traductions et valeurs pour l'API
  final List<Map<String, dynamic>> difficulties = [
    {'name': 'Facile', 'apiValue': 'easy', 'en': 'Easy', 'ar': 'سهل'},
    {'name': 'Moyen', 'apiValue': 'medium', 'en': 'Medium', 'ar': 'متوسط'},
    {'name': 'Difficile', 'apiValue': 'hard', 'en': 'Hard', 'ar': 'صعب'},
  ];

  // Nombre de questions
  final List<int> numberOfQuestions = [5, 10, 15, 20];

  @override
  Widget build(BuildContext context) {
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    final locale = localizationProvider.locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(locale == 'fr'
            ? 'Paramètres du Quiz'
            : locale == 'en'
                ? 'Quiz Settings'
                : 'إعدادات الاختبار'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Sélection de la catégorie
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locale == 'fr'
                          ? 'Catégorie'
                          : locale == 'en'
                              ? 'Category'
                              : 'الفئة',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<Map<String, dynamic>>(
                      value: selectedCategory,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      hint: Text(locale == 'fr'
                          ? 'Choisissez une catégorie'
                          : locale == 'en'
                              ? 'Choose a category'
                              : 'اختر فئة'),
                      items: categories.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category[locale] ?? category['name']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Sélection de la difficulté
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locale == 'fr'
                          ? 'Difficulté'
                          : locale == 'en'
                              ? 'Difficulty'
                              : 'الصعوبة',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<Map<String, dynamic>>(
                      value: selectedDifficulty,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      hint: Text(locale == 'fr'
                          ? 'Choisissez la difficulté'
                          : locale == 'en'
                              ? 'Choose the difficulty'
                              : 'اختر الصعوبة'),
                      items: difficulties.map((difficulty) {
                        return DropdownMenuItem(
                          value: difficulty,
                          child: Text(difficulty[locale] ?? difficulty['name']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDifficulty = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Sélection du nombre de questions
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locale == 'fr'
                          ? 'Nombre de questions'
                          : locale == 'en'
                              ? 'Number of questions'
                              : 'عدد الأسئلة',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                      value: selectedNumberOfQuestions,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      hint: Text(locale == 'fr'
                          ? 'Choisissez le nombre de questions'
                          : locale == 'en'
                              ? 'Choose the number of questions'
                              : 'اختر عدد الأسئلة'),
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
                  ],
                ),
              ),
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
                        category: selectedCategory!['id'].toString(),
                        difficulty: selectedDifficulty!['apiValue'],
                        numberOfQuestions: selectedNumberOfQuestions!,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(locale == 'fr'
                          ? 'Veuillez sélectionner tous les paramètres.'
                          : locale == 'en'
                              ? 'Please select all settings.'
                              : 'الرجاء تحديد جميع الإعدادات.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                locale == 'fr'
                    ? 'Commencer le quiz'
                    : locale == 'en'
                        ? 'Start the quiz'
                        : 'بدء الاختبار',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}