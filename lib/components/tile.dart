import 'package:grow_plants_puzzle_game/constants.dart';
import 'package:flutter/material.dart';

class PuzzleTile extends StatelessWidget {
  final int number;
  final int x;
  final int y;
  final VoidCallback onClick;
  final bool matching;
  final double screenWidth;
  const PuzzleTile({ Key? key, required this.number, required this.x, required this.y, required this.onClick, required this.matching, required this.screenWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      onHorizontalDragStart: (d){
        onClick();
      },
      onVerticalDragStart: (d){
        onClick();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.bounceOut,
        height: (screenWidth>600)?desktopTileSize:mobileTileSize,
        width: (screenWidth>600)?desktopTileSize:mobileTileSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: (number==0)? Colors.transparent:Colors.black38,
          image: DecorationImage(
            image: (number==0)? const AssetImage('assets/images/tile9.png') : AssetImage('assets/images/tile$number.png'),
            fit: BoxFit.scaleDown,
            opacity: 1
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              (number!=0)?number.toString():'',
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}