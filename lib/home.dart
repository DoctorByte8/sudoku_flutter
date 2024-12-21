import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'sudoku.dart';

class HomeApp extends StatefulWidget {
  @override
  HomeAppState createState() => HomeAppState();
}

class HomeAppState extends State<HomeApp> {

  String? userName;
  String selectedDifficulty = 'fácil';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sudoku - Home'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nome do usuário',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    userName = value;
                  });
                },
              ),
              Text('Escolha a dificuldade:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView(
                  children: [
                    RadioListTile<String>(
                      title: Text('Fácil'),
                      value: 'fácil',
                      groupValue: selectedDifficulty,
                      onChanged: (value) {
                        setState(() {
                          selectedDifficulty = value!;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text('Médio'),
                      value: 'médio',
                      groupValue: selectedDifficulty,
                      onChanged: (value) {
                        setState(() {
                          selectedDifficulty = value!;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text('Difícil'),
                      value: 'difícil',
                      groupValue: selectedDifficulty,
                      onChanged: (value) {
                        setState(() {
                          selectedDifficulty = value!;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text('Expert'),
                      value: 'expert',
                      groupValue: selectedDifficulty,
                      onChanged: (value) {
                        setState(() {
                          selectedDifficulty = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ElevatedButton(
                onPressed: () {
                  print('Nome do usuário: $userName');
                  print('Dificuldade selecionada: $selectedDifficulty');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SudokuApp(
                        userName: userName,
                        difficulty: selectedDifficulty,
                      ),
                    ),
                  );
                },
                child: Text('Novo jogo'),
            ),
            ],
          ),
        ), 
      ),
    );
  }
}
