import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool ohTurn = true;
  var myTextStyle = const TextStyle(color: Colors.white, fontSize: 30);
  int ohScore = 0;
  int exScore = 0;
  int filledBoxes = 0;
  static var myWhiteStyle = GoogleFonts.pressStart2p(
    textStyle: const TextStyle(
      color: Colors.white,
      letterSpacing: 3,
    ),
  );
  List<String> sympol = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Player X',
                        style: myWhiteStyle,
                      ),
                      Text(
                        exScore.toString(),
                        style: myWhiteStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Player O',
                        style: myWhiteStyle,
                      ),
                      Text(
                        ohScore.toString(),
                        style: myWhiteStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _tapped(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        sympol[index],
                        style: myWhiteStyle,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Text(
                    'TIC TAC TOE',
                    style: myWhiteStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (ohTurn && sympol[index] == '') {
        sympol[index] = 'O';
        filledBoxes++;
      } else if (!ohTurn && sympol[index] == '') {
        sympol[index] = 'X';
        filledBoxes++;
      }
      ohTurn = !ohTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (sympol[0] == sympol[1] && sympol[0] == sympol[2] && sympol[0] != '') {
      _showWinDialog(sympol[0]);
    }
    if (sympol[3] == sympol[4] && sympol[3] == sympol[5] && sympol[3] != '') {
      _showWinDialog(sympol[3]);
    }
    if (sympol[6] == sympol[7] && sympol[6] == sympol[8] && sympol[6] != '') {
      _showWinDialog(sympol[6]);
    }
    if (sympol[0] == sympol[3] && sympol[0] == sympol[6] && sympol[0] != '') {
      _showWinDialog(sympol[0]);
    }
    if (sympol[1] == sympol[4] && sympol[1] == sympol[7] && sympol[1] != '') {
      _showWinDialog(sympol[1]);
    }
    if (sympol[2] == sympol[5] && sympol[2] == sympol[8] && sympol[2] != '') {
      _showWinDialog(sympol[2]);
    }
    if (sympol[6] == sympol[4] && sympol[6] == sympol[2] && sympol[6] != '') {
      _showWinDialog(sympol[6]);
    }
    if (sympol[0] == sympol[4] && sympol[0] == sympol[8] && sympol[0] != '') {
      _showWinDialog(sympol[0]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('WINNER IS $winner'),
            actions: [
              TextButton(
                child: const Text('Play Again!'),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
    if (winner == 'O') {
      ohScore++;
    } else if (winner == 'X') {
      exScore++;
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('DRAW'),
            actions: [
              TextButton(
                 child: const Text('Play Again!'),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
               
              )
            ],
          );
        });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        sympol[i] = '';
      }
    });
    filledBoxes = 0;
  }
}
