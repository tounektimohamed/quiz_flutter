import 'package:flutter/material.dart';
import 'package:quiz_ala/services/score_service.dart'; // Importez ScoreService

class LeaderboardScreen extends StatefulWidget {
  final String category;
  final String difficulty;

  const LeaderboardScreen({
    super.key,
    required this.category,
    required this.difficulty,
  });

  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  late Future<List<int>> _scoresFuture;

  @override
  void initState() {
    super.initState();
    _loadScores();
  }

  void _loadScores() {
    setState(() {
      _scoresFuture = ScoreService.getScores(category: widget.category, difficulty: widget.difficulty);
    });
  }

  Future<void> _resetScores() async {
    await ScoreService.resetScores();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Scores réinitialisés.')),
    );
    _loadScores(); // Recharge les scores après la réinitialisation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classement - ${widget.category} (${widget.difficulty})'),
      ),
      body: FutureBuilder<List<int>>(
        future: _scoresFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun score enregistré.'));
          } else {
            final scores = snapshot.data!;
            scores.sort((a, b) => b.compareTo(a)); // Tri des scores en ordre décroissant

            return ListView.builder(
              itemCount: scores.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text('Score: ${scores[index]}'),
                    subtitle: Text('Catégorie: ${widget.category}, Difficulté: ${widget.difficulty}'),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _resetScores,
        child: const Icon(Icons.delete),
      ),
    );
  }
}