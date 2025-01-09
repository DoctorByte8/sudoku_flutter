import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Sudoku',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeApp(),
    ),
  );
}