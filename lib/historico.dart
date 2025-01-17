import 'package:flutter/material.dart';
import 'database.dart';

class HistoricoApp extends StatefulWidget {
  final String? userName;

  HistoricoApp({required this.userName});

  @override
  HistoricoAppState createState() => HistoricoAppState();
}

class HistoricoAppState extends State<HistoricoApp> {
  String selectedDifficulty = "todas";

  Future<List<Map<String, dynamic>>> fetchGameHistory(String difficultyFilter) async {
    final db = await SudokuDB().database;

    final difficultyMap = {
      "todas": null,
      "fácil": 1,
      "médio": 2,
      "difícil": 3,
      "expert": 4,
    };

    int? level = difficultyMap[difficultyFilter];

    final results = await db.query(
      'sudoku',
      where: 'name = ? AND (level = ? OR ? IS NULL)',
      whereArgs: [widget.userName, level, level],
    );

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sudoku - Histórico'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Histórico de Partidas',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            DropdownButton<String>(
              value: selectedDifficulty,
              items: [
                DropdownMenuItem(value: "todas", child: Text("Todas")),
                DropdownMenuItem(value: "fácil", child: Text("Fácil")),
                DropdownMenuItem(value: "médio", child: Text("Médio")),
                DropdownMenuItem(value: "difícil", child: Text("Difícil")),
                DropdownMenuItem(value: "expert", child: Text("Expert")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedDifficulty = value!;
                });
              },
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchGameHistory(selectedDifficulty),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro ao carregar o histórico.'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Nenhum histórico encontrado.'));
                  }

                  final gameHistory = snapshot.data!;
                  return ListView.builder(
                    itemCount: gameHistory.length,
                    itemBuilder: (context, index) {
                      final game = gameHistory[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: Icon(
                            game['result'] == 1 ? Icons.check_circle : Icons.cancel,
                            color: game['result'] == 1 ? Colors.green : Colors.red,
                          ),
                          title: Text('Jogador: ${game['name']}'),
                          subtitle: Text('Dificuldade: ${selectedDifficulty.capitalize()}'),
                          trailing: Text(game['date']),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: Text('Voltar para home'),
            ),
          ],
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}