import 'package:grow_plants_puzzle_game/components/flower_painter.dart';
import 'package:grow_plants_puzzle_game/components/functions.dart';
import 'package:grow_plants_puzzle_game/components/tile.dart';
import 'package:grow_plants_puzzle_game/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class Puzzle extends StatefulWidget {
  const Puzzle({ Key? key }) : super(key: key);
  static const route = 'puzzle';
  @override
  _PuzzleState createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> with TickerProviderStateMixin {
  List<int> _initialTiles = [1,2,3,4,5,6,7,8,0];
  final List<int> _finalTiles = [1,2,3,4,5,6,7,8,0];
  List<bool> _matchTileStatus=[false,false,false,false,false,false,false,false,false];
  bool _matched=false;
  int _noOfMoves=0;
  bool _started=false;
  bool _isHardLevel=true;
  bool _solved=false;
  double _screenWidth=0.0;
  double _screenHeight=0.0;
  bool _inCompatible=true; // To check compatibility based on screen width and height

  //Animations
  double t1StartFraction= 0.0,t2StartFraction= 0.0,t3StartFraction= 0.0,t4StartFraction= 0.0,t5StartFraction= 0.0,t6StartFraction= 0.0,t7StartFraction= 0.0,t8StartFraction= 0.0,t9StartFraction = 0.0;
  late Animation<double> t1StartAnimation,t2StartAnimation,t3StartAnimation,t4StartAnimation,t5StartAnimation,t6StartAnimation,t7StartAnimation,t8StartAnimation,t9StartAnimation;
  late AnimationController t1StartController,t2StartController,t3StartController,t4StartController,t5StartController,t6StartController,t7StartController,t8StartController,t9StartController;
  late List<AnimationController> tileStartControllers;

  // Tile, Flower, and Leaf images
  List<ui.Image>? _flowerImages;
  List<ui.Image>? _leafImages;
  late Image _clueImage;


  // To load asset images
  Future loadAssetImages() async {
    List<ui.Image> loadedFlowerImages=[];
    List<ui.Image> loadedLeafImages=[];

    try {
      for (var p=1; p<10;p++){      
        // Flower Images
        var flowerData = await rootBundle.load('assets/images/flower$p.png');
        var flowerBytes = flowerData.buffer.asUint8List();
        var flowerImage = await decodeImageFromList(flowerBytes);
        loadedFlowerImages.add(flowerImage);
      
        // Leaf Images
        var leafData = await rootBundle.load('assets/images/leaf$p.png');
        var leafBytes = leafData.buffer.asUint8List();
        var leafImage = await decodeImageFromList(leafBytes);
        loadedLeafImages.add(leafImage);
      }
      
      if(loadedFlowerImages.length==9 && loadedLeafImages.length==9){
        setState(() {
          _flowerImages = loadedFlowerImages;
          _leafImages = loadedLeafImages;
        });
      }
    } catch (e) {
      showAlertDialog(context,'Error','Sorry, some error occured');
    }
  }


  @override
  void initState() {
    super.initState();

    // Loading Asset images
    loadAssetImages();

    // Loading Clue Image
    _clueImage = Image.asset('assets/images/clue.png');
    
    //Initializing Animations
    t1StartController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    t2StartController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    t3StartController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    t4StartController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    t5StartController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    t6StartController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    t7StartController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    t8StartController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    t9StartController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Tween Details
    t1StartAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    )
    .animate(
      CurvedAnimation(
        parent: t1StartController,
        curve: const Interval(
          0.0,1,
          curve: Curves.linear
        )
      )
    )
    ..addListener(() { 
      setState(() {
        t1StartFraction = t1StartAnimation.value;
      });
    });

    t2StartAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    )
    .animate(
      CurvedAnimation(
        parent: t2StartController,
        curve: const Interval(
          0.0,1,
          curve: Curves.linear
        )
      )
    )
    ..addListener(() { 
      setState(() {
        t2StartFraction = t2StartAnimation.value;
      });
    });

    t3StartAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    )
    .animate(
      CurvedAnimation(
        parent: t3StartController,
        curve: const Interval(
          0.0,1,
          curve: Curves.linear
        )
      )
    )
    ..addListener(() { 
      setState(() {
        t3StartFraction = t3StartAnimation.value;
      });
    });

    t4StartAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    )
    .animate(
      CurvedAnimation(
        parent: t4StartController,
        curve: const Interval(
          0.0,1,
          curve: Curves.linear
        )
      )
    )
    ..addListener(() { 
      setState(() {
        t4StartFraction = t4StartAnimation.value;
      });
    });

    t5StartAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    )
    .animate(
      CurvedAnimation(
        parent: t5StartController,
        curve: const Interval(
          0.0,1,
          curve: Curves.linear
        )
      )
    )
    ..addListener(() { 
      setState(() {
        t5StartFraction = t5StartAnimation.value;
      });
    });

    t6StartAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    )
    .animate(
      CurvedAnimation(
        parent: t6StartController,
        curve: const Interval(
          0.0,1,
          curve: Curves.linear
        )
      )
    )
    ..addListener(() { 
      setState(() {
        t6StartFraction = t6StartAnimation.value;
      });
    });

    t7StartAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    )
    .animate(
      CurvedAnimation(
        parent: t7StartController,
        curve: const Interval(
          0.0,1,
          curve: Curves.linear
        )
      )
    )
    ..addListener(() { 
      setState(() {
        t7StartFraction = t7StartAnimation.value;
      });
    });

    t8StartAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    )
    .animate(
      CurvedAnimation(
        parent: t8StartController,
        curve: const Interval(
          0.0,1,
          curve: Curves.linear
        )
      )
    )
    ..addListener(() { 
      setState(() {
        t8StartFraction = t8StartAnimation.value;
      });
    });

    t9StartAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    )
    .animate(
      CurvedAnimation(
        parent: t9StartController,
        curve: const Interval(
          0.0,1,
          curve: Curves.linear
        )
      )
    )
    ..addListener(() { 
      setState(() {
        t9StartFraction = t9StartAnimation.value;
      });
    });
    
    // All controllers and Fractions
    tileStartControllers=[
      t1StartController,t2StartController,t3StartController,t4StartController,t5StartController,
      t6StartController,t7StartController,t8StartController,t9StartController
    ];
  }

  @override
  void didChangeDependencies() {
    // Precache clue image
    precacheImage(_clueImage.image, context);

    // Precache tile images
    for (var t=1; t<10; t++){
      precacheImage(Image.asset('assets/images/tile$t.png').image, context);
    }
    super.didChangeDependencies();
  }
  
  @override
  Widget build(BuildContext context) {
    try{
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;

    // Incompatible for screen width < 350
    // Incompatible for screen height < 600
    _inCompatible = (_screenWidth<350 || _screenHeight<600 );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Grow Plants Puzzle',
          style: Theme.of(context).textTheme.headline5,
          ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              // Show Rules
              await showAlertDialog(context, 'Game Rules', rules);
            }, 
            child: const Text(
              'Rules',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.bold
              ),
              )
          ),
          const SizedBox(
            width: 25,
          )
        ],
        
      ),
      body: (_inCompatible)?
      const Center(child: Text(
        inCompatibleMsg,
        textAlign: TextAlign.center,
        )
      ) : 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                label: _started? const Text('RESTART') : const Text('START'),
                onPressed: (){
                  setState(() {
                    // Change started to true, 
                    //difficulty to hard, 
                    //play animation to false
                    // solved flag to false
                    _started=true;
                    _isHardLevel=true;
                    _solved = false;
                          
                    // Checking initial match status
                    _matched=listEquals(_initialTiles, _finalTiles);

                    // Shuffle
                    _initialTiles.shuffle();
                    // Reshuffle if the puzzle is unsolvable 
                    // or shuffled tiles matches with final tiles
                    while(!checkPuzzleSolvability(_initialTiles) || _matched){
                      _initialTiles.shuffle();
                      _matched=listEquals(_initialTiles, _finalTiles);
                    }
                    //Reset number of moves
                    _noOfMoves=0;
                    
                    
                    //Update match status list
                    for(var i=0; i<_finalTiles.length;i++){
                      _matchTileStatus[i]=(_finalTiles[i]==_initialTiles[i]);
                      // If a particular tile is at correct position, its flower branch will grow
                      if(_matchTileStatus[i]){
                        tileStartControllers[i].forward();
                      }else{
                        tileStartControllers[i].reset();
                      }
                    }
                  });
                }, 
                icon: _started?const Icon(
                  Icons.restart_alt
                ): const Icon(
                  Icons.play_arrow
                )
              ),
              const SizedBox(width: 30,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Moves'),
                  Text(
                    _noOfMoves.toString(),
                    style: Theme.of(context).textTheme.headline6,
                    ),
                ],
              )
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                child: Text(
                  'Hard',
                  style: TextStyle(
                    decoration: (_isHardLevel)? TextDecoration.underline : TextDecoration.none,
                    fontWeight: (_isHardLevel)? FontWeight.bold : FontWeight.normal,
                    fontSize: 15
                  ),
                ),
                onTap: (){
                  if(!_solved){
                    setState(() {
                      _isHardLevel=!_isHardLevel;
                    });
                  }else{
                    showSnackAlert(context, 'Restart to Play again.');
                  }
                },
              ),
              const SizedBox(
                width: 15,
              ),
              InkWell(
                child: Text(
                  'Easy',
                  style: TextStyle(
                    decoration: (!_isHardLevel)? TextDecoration.underline : TextDecoration.none,
                    fontWeight: (!_isHardLevel)? FontWeight.bold : FontWeight.normal,
                    fontSize: 15
                  ),
                ),
                onTap: (){
                  if(!_solved){
                    setState(() {
                      _isHardLevel=!_isHardLevel;
                    });
                  }else{
                    showSnackAlert(context, 'Restart to Play again.');
                  }
                },
              )
            ]
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Puzzle Board
                loadPuzzle(),
                // Show clue image only for Easy level. Also, remove when the puzzle is solved
                if(!_isHardLevel && !_matched && _screenWidth>1200) Padding(
                  padding: const EdgeInsets.only(right: 100),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: loadClueImage()
                  ),
                ),
              ],
            ),
          ),
          if(!_isHardLevel && !_matched && _screenWidth<1201) Align(
            alignment: Alignment.center,
            child: loadClueImage()
          ),
          if(_matched) loadWinMessage(),      
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text('Developed by Aslam Hameed')
          ),
                     
        ],
      ),
    );
    }
    catch(e){
      showAlertDialog(context,'Error','Sorry, some error occured');
    }
    return const Text('Some Error Occured');
  }
  	
  @override
  void dispose(){
    super.dispose();
    t1StartController.dispose();
    t2StartController.dispose();
    t3StartController.dispose();
    t4StartController.dispose();
    t5StartController.dispose();
    t6StartController.dispose();
    t7StartController.dispose();
    t8StartController.dispose();
    t9StartController.dispose();
  }
  
  // Load Puzzle Board
  Widget loadPuzzle(){
    double puzzleBgWidth = 3 * desktopTileSize;
    double puzzleBgHeight = 3 * desktopTileSize;
    double puzzleBoardWidth = 3 * desktopTileSize;
    double puzzleBoardHeight = 3 * desktopTileSize;
    // For screen width/height less than 650, mobile size
    if(_screenWidth<650 || _screenHeight<650){ 
      puzzleBgWidth = 3 * mobileTileSize;
      puzzleBgHeight = 3 * mobileTileSize;
      puzzleBoardWidth=3 * mobileTileSize;
      puzzleBoardHeight=3 * mobileTileSize;
    }
    try{
      return
        // Wait for asset images to load
        (_flowerImages==null || _leafImages==null || _flowerImages!.length!=9 || _leafImages!.length!=9)? const CircularProgressIndicator() : CustomPaint(
          foregroundPainter: BranchPainter(
            context: context,
            matchTileStatusList: _matchTileStatus,
            startBranchFractions: [
              t1StartFraction,t2StartFraction,t3StartFraction,t4StartFraction,t5StartFraction,
              t6StartFraction,t7StartFraction,t8StartFraction,t9StartFraction
            ],
            flowerImages: _flowerImages!,
            leafImages: _leafImages!,
            // For screen width/height less than 650, mobile scale
            scaleFactor: (_screenWidth<650 || _screenHeight<650)? mobileScaleFactor : desktopScaleFactor,
          ),
          child: SizedBox(
            height: puzzleBgHeight,
            width: puzzleBgWidth,
            child: ClipRRect(
              child: Center(
                child: SizedBox(
                  height: puzzleBoardHeight,
                  width: puzzleBoardWidth,
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                    ), 
                    itemBuilder: (context, index){
                      var _x=tiles[index].position.dx.round();
                      var _y=tiles[index].position.dy.round();
                      return PuzzleTile(
                        number: _initialTiles[index], 
                        x: _x, 
                        y: _y,
                        onClick: () {
                          // Move the tiles only if the game is started 
                          //else alert to start the game
                          if(_started && !_solved){
                            var zeroTileIndex=_initialTiles.indexOf(0);
                            var x1 = tiles[zeroTileIndex].position.dx.round();
                            var y1 = tiles[zeroTileIndex].position.dy.round();

                            // Check the tile position with zero tile and move
                            if((_x==x1 || _y==y1) &&(x1-_x ==1 || y1-_y ==1 || x1-_x ==-1 || y1-_y ==-1)){
                              var temp =_initialTiles[zeroTileIndex];
                              setState(() {
                                // Increase moves
                                _noOfMoves+=1;

                                //Single move
                                _initialTiles[zeroTileIndex]=_initialTiles[index];
                                _initialTiles[index]=temp;
                                

                                //Update match status list
                                for(var i=0; i<_finalTiles.length;i++){
                                  _matchTileStatus[i]=(_finalTiles[i]==_initialTiles[i]);
                                  if(_matchTileStatus[i]){
                                    tileStartControllers[i].forward();
                                  }else{
                                    tileStartControllers[i].reset();
                                  }
                                }

                                // Check all tiles matching
                                _matched=listEquals(_initialTiles, _finalTiles);
                                if(_matched){
                                  // If matched, set solved to true
                                  //playing grow animation for 6 seconds
                                  _solved=true;
                                  for (var controller in tileStartControllers) {
                                    controller.repeat();
                                  }
                                  
                                }
                              });
                            }
                          }
                          else{
                            var alertMsg='Start to Play';
                            if(_solved){
                              alertMsg='Restart to Play again';
                            }
                            showSnackAlert(context, alertMsg);
                          }
                        },
                        matching: (_initialTiles[index]==_finalTiles[index]),
                        screenWidth: _screenWidth,
                      );
                    },
                    itemCount: _initialTiles.length,
                  )
                ),
              ),
            ),
          ),
        );
    }
    catch(e){
      return const Text('Error occured',style: TextStyle(color: Color.fromARGB(255, 187, 170, 22)),);
    }
  }

  // LOAD WIN MESSAGE
  Text loadWinMessage(){
    return 
     Text(
      'Wow!\nYou have solved the puzzle in $_noOfMoves moves.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: (_screenWidth>700)? 22 : 18
        ),
      );
  }

  // LOAD CLUE IMAGE
  ClipRRect loadClueImage(){
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: SizedBox(
        height: (_screenWidth>600)? 125 : 100,
        child: _clueImage,
      ),
    );
  }
}