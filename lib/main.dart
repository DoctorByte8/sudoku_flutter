import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudoku_flutter/historico.dart';
import 'package:sudoku_flutter/sudoku.dart';
import 'home.dart';
import 'database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Necessário para operações assíncronas antes de rodar o app
  await SudokuDB().database; // Inicializa o banco de dados
  runApp(
    MaterialApp(
      title: 'Sudoku',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeApp(),
      initialRoute: '/',
    ),
  );
}