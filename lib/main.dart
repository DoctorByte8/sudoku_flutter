import 'package:flutter/material.dart';
//import 'package:sudoku_dart/sudoku_dart.dart';

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
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Nome do jogador: "),
                  TextField(  
                     keyboardType: TextInputType.text,
                     enabled: true,
                  ), 
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}
