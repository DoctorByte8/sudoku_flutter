import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'sudoku.dart';

class HomeApp extends StatefulWidget {
  @override
  HomeAppState createState() => HomeAppState();
}

class HomeAppState extends State<HomeApp> {

  String? _userName; // Para armazenar o nome do usuário
  String _selectedDifficulty = 'fácil'; // Dificuldade padrão

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sudoku - Escolha sua Configuração'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextField para capturar o nome do usuário
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome do Usuário',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _userName = value;
                });
              },
            ),
            SizedBox(height: 20),

            // Título para a seleção de dificuldade
            Text(
              'Escolha a dificuldade:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // RadioListTile para cada nível de dificuldade
            Expanded(
              child: ListView(
                children: [
                  RadioListTile<String>(
                    title: Text('Fácil'),
                    value: 'fácil',
                    groupValue: _selectedDifficulty,
                    onChanged: (value) {
                      setState(() {
                        _selectedDifficulty = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Médio'),
                    value: 'médio',
                    groupValue: _selectedDifficulty,
                    onChanged: (value) {
                      setState(() {
                        _selectedDifficulty = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Difícil'),
                    value: 'difícil',
                    groupValue: _selectedDifficulty,
                    onChanged: (value) {
                      setState(() {
                        _selectedDifficulty = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Expert'),
                    value: 'expert',
                    groupValue: _selectedDifficulty,
                    onChanged: (value) {
                      setState(() {
                        _selectedDifficulty = value!;
                      });
                    },
                  ),
                ],
              ),
            ),

            // Exemplo de botão para prosseguir (opcional)
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_userName != null && _userName!.isNotEmpty) {
                    // Lógica ao clicar no botão, como navegar para outra tela
                    print('Nome do Usuário: $_userName');
                    print('Dificuldade Selecionada: $_selectedDifficulty');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SudokuApp(
                          userName: _userName!,
                          difficulty: _selectedDifficulty,
                        ),
                      ),
                    );
                  } else {
                    // Mostrar mensagem de erro se o nome não for preenchido
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text('Por favor, insira seu nome antes de continuar.'),
                    ));
                  }
                },
                child: Text('Iniciar Jogo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
