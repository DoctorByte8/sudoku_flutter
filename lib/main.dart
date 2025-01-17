import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudoku_flutter/historico.dart';
import 'package:sudoku_flutter/sudoku.dart';
import 'home.dart';
import 'database.dart';

void main() /*{*/async {
  WidgetsFlutterBinding.ensureInitialized();
  await SudokuDB().database; /**/
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