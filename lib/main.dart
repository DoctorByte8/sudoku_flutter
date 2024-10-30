import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Sudoku",
      debugShowCheckedModeBanner: false,
      home: MainApp()
    )
  );
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => MainAppState();
}


class MainAppState extends State<MainApp>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sudoku"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              
            ],
          )
        ),
      ),
    );
  }
}
