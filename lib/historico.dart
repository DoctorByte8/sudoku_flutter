import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'database.dart';


class HistoricoApp extends StatefulWidget {
  @override
  HistoricoAppState createState() => HistoricoAppState();
}

class HistoricoAppState extends State<HistoricoApp> {
  // Simulação da função que buscará os dados do banco SQLite.
  Future<List<Map<String, dynamic>>> fetchGameHistory() async {
    // Aqui você implementará a função que consulta o banco de dados SQLite.
    // Exemplo de retorno simulado:
    return [
      {
        'userName': 'Thiago',
        'difficulty': 'fácil',
        'date': '2024-12-20',
        'won': true,
      },
      {
        'userName': 'Larissa',
        'difficulty': 'médio',
        'date': '2024-12-19',
        'won': false,
      },
    ];
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Histórico de Partidas',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: fetchGameHistory(),
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
                              game['won'] ? Icons.check_circle : Icons.cancel,
                              color: game['won'] ? Colors.green : Colors.red,
                            ),
                            title: Text('Jogador: ${game['userName']}'),
                            subtitle: Text('Dificuldade: ${game['difficulty']}'),
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
      ),
    );
  }
}