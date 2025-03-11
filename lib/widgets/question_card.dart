import 'package:flutter/material.dart';
import '../models/question_model.dart';

class QuestionCard extends StatefulWidget {
  final Question question;
  final Function(String) onAnswer;

  const QuestionCard({super.key, required this.question, required this.onAnswer});

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String? selectedAnswer;
  bool? isCorrect;

  void _handleAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      isCorrect = answer == widget.question.answers.firstWhere((a) => a.isCorrect).text;
    });

    // Appeler la fonction onAnswer après un court délai pour permettre l'affichage du feedback
    Future.delayed(const Duration(milliseconds: 500), () {
      widget.onAnswer(answer);
      setState(() {
        selectedAnswer = null; // Réinitialiser pour la prochaine question
        isCorrect = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              widget.question.text,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ...widget.question.answers.map((answer) {
              final isSelected = selectedAnswer == answer.text;
              final color = isSelected
                  ? (isCorrect == true ? Colors.green : Colors.red)
                  : null;

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: color?.withOpacity(0.2),
                  border: isSelected
                      ? Border.all(color: color ?? Colors.transparent, width: 2)
                      : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Text(answer.text),
                  onTap: () => _handleAnswer(answer.text),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}