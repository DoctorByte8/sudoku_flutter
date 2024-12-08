import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudoku_dart/sudoku_dart.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Sudoku',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int screen = 0;
  TextEditingController nomeJogador = TextEditingController();
  String? _radio1;

  int? selectedRow;
  int? selectedCol;
  Sudoku numbers = Sudoku.generate(Level.easy);

  final List<int> sudokuGrid = [
    -1, -1, 5,   4, -1, 7,   3, -1, 1,
    4, -1, 7,   3, 1, -1,   6, -1, -1,
    -1, 8, 1,   2, 6, -1,   -1, 9, -1,

    5, -1, -1,   -1, 3, 9,   -1, -1, -1,
    -1, 2, 6,   7, -1, 4,   -1, -1, -1,
    7, -1, 3,   5, -1, -1,   9, -1, -1,

    6, -1, 2,   -1, -1, -1,   8, -1, 9,
    -1, 3, -1,   -1, 7, 2,   4, 5, -1,
    8, 7, 4,   -1, -1, -1,   1, 3, 2
  ];

  void solution() {
    Sudoku sudoku = Sudoku(sudokuGrid);
    print(sudoku.puzzle);
    print(sudoku.solution);
  }

  List<List<TextEditingController>> _controllers = List.generate(
    9,
    (_) => List.generate(9, (_) => TextEditingController()),
  );

  @override
  void dispose() {
    for (var row in _controllers) {
      for (var controller in row) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  void _selectCell(int row, int col) {
    setState(() {
      selectedRow = row;
      selectedCol = col;
    });
  }

  void _updateGrid(int row, int col, String value) {
    setState(() {
      sudokuGrid[row * 9 + col] = int.tryParse(value) ?? -1;
      solution();
    });
  }

  @override
  Widget build(BuildContext context) {
    // ---- TELA INICIAL ----
    if (screen == 0) {
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
                      decoration: InputDecoration(labelText: "Nome do jogador"),
                      enabled: true,
                      maxLength: 20,
                      controller: nomeJogador,
                    ),
                    RadioListTile(
                      value: 'f',
                      groupValue: _radio1,
                      title: Text("Fácil"),
                      onChanged: (String? value) {
                        _radio1 = value;
                        setState(() {});
                      },
                    ),
                    RadioListTile(
                      value: 'm',
                      groupValue: _radio1,
                      title: Text("Médio"),
                      onChanged: (String? value) {
                        _radio1 = value;
                        setState(() {});
                      },
                    ),
                    RadioListTile(
                      value: 'd',
                      groupValue: _radio1,
                      title: Text("Difícil"),
                      onChanged: (String? value) {
                        _radio1 = value;
                        setState(() {});
                      },
                    ),
                    RadioListTile(
                      value: 'e',
                      groupValue: _radio1,
                      title: Text("Expert"),
                      onChanged: (String? value) {
                        _radio1 = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    // ---- TELA DO JOGO ----
    else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Sudoku'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Table(
                          border: TableBorder.symmetric(
                            inside: BorderSide(color: Colors.black38),
                          ),
                          children: List.generate(9, (i) {
                            return TableRow(
                              children: List.generate(9, (j) {
                                bool isSelected = selectedRow == i && selectedCol == j;
                                int value = sudokuGrid[i * 9 + j];
                                return GestureDetector(
                                  onTap: () {
                                    _selectCell(i, j);
                                    solution();
                                  },
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: (j + 1) % 3 == 0 ? Colors.black : Colors.black,
                                          width: (j + 1) % 3 == 0 ? 2 : 1,
                                        ),
                                        bottom: BorderSide(
                                          color: (i + 1) % 3 == 0 ? Colors.black : Colors.black,
                                          width: (i + 1) % 3 == 0 ? 2 : 1,
                                        ),
                                      ),
                                      color: isSelected ? Colors.red.withOpacity(0.2) : Colors.transparent,
                                    ),
                                    child: Center(
                                      child: value >= 0
                                          ? Text(
                                              value.toString(),
                                              style: TextStyle(fontSize: 18, color: Colors.black),
                                            )
                                          : TextField(
                                              controller: _controllers[i][j],
                                              enabled: isSelected,
                                              textAlign: TextAlign.center,
                                              keyboardType: TextInputType.number,
                                              maxLength: 1,
                                              onChanged: (input) {
                                                if (input.isNotEmpty && int.tryParse(input) != null) {
                                                  _updateGrid(i, j, input);
                                                }
                                              },
                                              decoration: InputDecoration(
                                                border: isSelected
                                                    ? OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.red, width: 2),
                                                      )
                                                    : InputBorder.none,
                                                counterText: '',
                                              ),
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: isSelected ? Colors.red : Colors.black,
                                              ),
                                            ),
                                    ),
                                  ),
                                );
                              }),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
