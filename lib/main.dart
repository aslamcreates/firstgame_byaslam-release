import 'package:grow_plants_puzzle_game/screens/puzzle.dart';
import 'package:flutter/material.dart';
import 'components/functions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    try{
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grow Plants Puzzle',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 184, 180, 224), //greyish Color(0xFFCCD1E4)  // Color(0xFFD9D7F1)
        ),
        routes: {
          '/' :(context) => const Puzzle(),
        },
      );
    }
    catch(e){
      showAlertDialog(context,'Error','Sorry, some error occured');
    }
    return const Text('Loading');
  }
}