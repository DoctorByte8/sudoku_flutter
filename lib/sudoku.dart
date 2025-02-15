import 'package:flutter/material.dart';
import 'package:sudoku_dart/sudoku_dart.dart';
import 'historico.dart';
import 'database.dart';

class SudokuApp extends StatefulWidget {
  final String? userName;
  final String difficulty;

  SudokuApp({required this.userName, required this.difficulty});

  @override
  SudokuAppState createState() => SudokuAppState();
}

class SudokuAppState extends State<SudokuApp> {
  int? selectedRow;
  int? selectedCol;
  int win = 0;

  /*
    late Sudoku sudokuGrid;

    @override
    void initState() {
      super.initState();
      sudokuGrid = generateSudoku(widget.difficulty);
    }

    Sudoku generateSudoku(String difficulty) {
      switch (difficulty) {
        case "fácil":
          return Sudoku.generate(Level.easy);
        case "médio":
          return Sudoku.generate(Level.medium);
        case "difícil":
          return Sudoku.generate(Level.hard);
        case "expert":
          return Sudoku.generate(Level.expert);
        default:
          return Sudoku.generate(Level.medium);
      }
    }
  */

  List<int> sudokuGrid = [
    -1,-1,8,    9,-1,6,     -1,-1,5,
    -1,4,3,     -1,-1,-1,   -1,2,-1,
    -1,-1,-1,   -1,-1,-1,   -1,-1,-1,

    -1,-1,4,    -1,-1,-1,   9,-1,-1,
    5,-1,-1,    -1,4,-1,    6,8,-1,
    -1,-1,-1,   1,-1,-1,    -1,-1,-1,

    2,-1,-1,    -1,8,-1,    -1,7,-1,
    -1,-1,-1,   -1,3,4,     1,-1,-1,
    -1,6,-1,    -1,-1,9,    -1,-1,-1,
  ];

  void selectCell(int row, int col) {
    setState(() {
      selectedRow = row;
      selectedCol = col;
    });
  }

  void updateGrid(int row, int col, String value) {
    setState(() {
      sudokuGrid[row * 9 + col] = int.tryParse(value) ?? -1;
    });
  }

  /*
    Parte do App2 - banco de dados no Sudoku
  */
  void addRecordExample(win) async {
    int diff = 0;
    switch (widget.difficulty!) {
      case 'fácil':
        diff = 1;
        break;
      case 'médio': 
        diff = 2;
        break;
      case 'difícil': 
        diff = 3;
        break;
      case 'expert': 
        diff = 4;
        break;
    }
    int id = await SudokuDB().insertSudoku(
      widget.userName!, 
      win, 
      DateTime.now().toIso8601String(), 
      diff,
    );
    print('Registro inserido com ID: $id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sudoku - Jogo'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
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
                            selectCell(i, j);
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: (j + 1) % 3 == 0 ? Colors.black : Colors.black38,
                                  width: (j + 1) % 3 == 0 ? 2 : 1,
                                ),
                                bottom: BorderSide(
                                  color: (i + 1) % 3 == 0 ? Colors.black : Colors.black38,
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
                                  : isSelected
                                      ? TextField(
                                          autofocus: true,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          maxLength: 1,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.red, width: 2),
                                            ),
                                            counterText: '',
                                          ),
                                          onSubmitted: (input) {
                                            if (input.isNotEmpty && int.tryParse(input) != null) {
                                              updateGrid(i, j, input);
                                            }
                                          },
                                        )
                                      : Text(''),
                            ),
                          ),
                        );
                      }),
                    );
                  }),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Sudoku sudoku = Sudoku(sudokuGrid);
                    sudoku.debug();
                    print(sudoku.solution);
                    if (sudoku.solution == sudokuGrid){
                      win = 1;
                    }
                    addRecordExample(win);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoricoApp(
                          userName: widget.userName,
                        ),
                      ),
                    );
                  },
                  child: Text('Finalizar jogo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
