import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../services/api_service.dart';
import '../widgets/question_card.dart';
import '../widgets/timer_widget.dart';
import 'results_screen.dart';

class QuizScreen extends StatefulWidget {
  final String category;
  final String difficulty;
  final int numberOfQuestions;

  const QuizScreen({
    super.key,
    required this.category,
    required this.difficulty,
    required this.numberOfQuestions,
  });

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questions = [];
  int currentQuestionIndex = 0;
  int score = 0;
  List<Map<String, dynamic>> userAnswers = [];

  @override
  void initState() {
    super.initState();
    print('Catégorie: ${widget.category}');
    print('Difficulté: ${widget.difficulty}');
    print('Nombre de questions: ${widget.numberOfQuestions}');
    fetchQuestions();
  }

  void fetchQuestions() async {
    print('Récupération des questions...');
    try {
      final fetchedQuestions = await ApiService.fetchQuestions(
        category: widget.category,
        difficulty: widget.difficulty,
        numberOfQuestions: widget.numberOfQuestions,
      );
      print('Questions récupérées: ${fetchedQuestions.length}');
      setState(() {
        questions = fetchedQuestions;
      });
    } catch (e) {
      print('Erreur lors de la récupération des questions: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Aucune question trouvée pour les paramètres donnés.'),
          duration: Duration(seconds: 3),
        ),
      );

      // Rediriger l'utilisateur vers l'écran précédent après un court délai
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pop(context);
      });
    }
  }

  void answerQuestion(String userAnswer, String correctAnswer) {
    final isCorrect = userAnswer == correctAnswer;
    setState(() {
      if (isCorrect) score++;

      userAnswers.add({
        'question': questions[currentQuestionIndex].text,
        'userAnswer': userAnswer,
        'correctAnswer': correctAnswer,
        'isCorrect': isCorrect,
      });

      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsScreen(
              score: score,
              totalQuestions: questions.length,
              userAnswers: userAnswers,
              category: widget.category, // Passer la catégorie
              difficulty: widget.difficulty, // Passer la difficulté
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: questions.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                TimerWidget(
                  duration: const Duration(seconds: 30),
                  onTimeUp: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultsScreen(
                          score: score,
                          totalQuestions: questions.length,
                          userAnswers: userAnswers,
                          category: widget.category, // Passer la catégorie
                          difficulty: widget.difficulty, // Passer la difficulté
                        ),
                      ),
                    );
                  },
                ),
                QuestionCard(
                  question: questions[currentQuestionIndex],
                  onAnswer: (answer) => answerQuestion(
                    answer,
                    questions[currentQuestionIndex]
                        .answers
                        .firstWhere((a) => a.isCorrect)
                        .text,
                  ),
                ),
              ],
            ),
    );
  }
}
