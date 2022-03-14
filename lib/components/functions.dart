import 'package:flutter/material.dart';

// Function to check solvability using inversion
bool checkPuzzleSolvability(List<int> shuffledList) {
  bool _solvable=false;
  int _noSmaller = 0;
  for (int i = 0; i < shuffledList.length; i++) {
    // Current Element
    var currElement = shuffledList[i];
    
    // Count the number of elements smaller and after than current element
    for (int j = i + 1; j < shuffledList.length; j++) {
      var nxtElement = shuffledList[j];
      if ((nxtElement < currElement) && (nxtElement!=0) && (currElement!=0)) {
        _noSmaller += 1;
      }
    }
  }
  // Check if noSmaller is even or odd
  _solvable=(_noSmaller % 2 == 0);
  return _solvable;
}

// Function to show error dialog
Future showAlertDialog(BuildContext context, String title, String msg){
  return showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text(title),
        content: Text(
          msg,
          textAlign: TextAlign.left,
          textWidthBasis: TextWidthBasis.longestLine,
          softWrap: true,
          ),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
            child: const Text('Okay')
          )
        ],
      );
    }
  );
}

// Function to show snackbar alert
showSnackAlert(BuildContext context, String msg){
    // Show Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: const Color.fromARGB(255, 111, 167, 113),
        )
    );
}