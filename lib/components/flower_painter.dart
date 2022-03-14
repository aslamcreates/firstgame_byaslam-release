import 'dart:math';
import 'dart:ui' as ui;
import 'package:grow_plants_puzzle_game/components/functions.dart';
import 'package:grow_plants_puzzle_game/constants.dart';
import 'package:flutter/material.dart';

class BranchPainter extends CustomPainter{
  final BuildContext context;
  final List<bool> matchTileStatusList;
  final List<double> startBranchFractions;
  final List<ui.Image> flowerImages;
  final List<ui.Image> leafImages;
  final double scaleFactor;

  BranchPainter({required this.context, required this.matchTileStatusList, required this.startBranchFractions, required this.flowerImages, required this.leafImages, required this.scaleFactor});
  
  @override
  void paint(Canvas canvas, Size size) {
    Paint flowerPaint = Paint();
    
    for(var i=0; i<matchTileStatusList.length;i++){
      try{
        Paint branchPaint = Paint()
        ..color=tiles[i].branchColor
        ..strokeCap=StrokeCap.round
        ..strokeWidth=tiles[i].branchWidth*scaleFactor;

        // START BRANCH
        drawTileStartBranch(canvas, branchPaint, flowerPaint, tiles[i].branchPoints,startBranchFractions[i],flowerImages[i],leafImages[i]);
      }
      catch(e){
        showAlertDialog(context,'Error','Sorry, some error occured');
      }
    }
  }

  // Function To Start Branch Growth
  void drawTileStartBranch(Canvas canvas, Paint lpaint, Paint fPaint,List<Offset> tileBranchPoints, double tileStartFraction, ui.Image flowerImage, ui.Image leafImage) {
    // Split the points array based on Offset(0.0,0.0)
    // Offset(0.0,0.0) is added in strokes to indicate end of particular branch
    // If Offset(0.0,0.0) not there, then means it's a single branch stroke
    List<List<Offset>> tileStartBranches=[];
    if(!tileBranchPoints.contains(const Offset(0.0,0.0))){
      tileStartBranches.add(tileBranchPoints);
    }else{
      var branchIndex=0;
      tileStartBranches.add([]);
      for(var p=0;p<tileBranchPoints.length-1;p++){
        if(tileBranchPoints[p]==Offset.zero){
          branchIndex+=1;
          tileStartBranches.add([]); //Adding empty array
        }else{
          tileStartBranches[branchIndex].add(tileBranchPoints[p]);
        }
      }
    }

    for (var branch in tileStartBranches) {
      var letterPointsLength = branch.length;
      var lineFractionInt = (tileStartFraction * letterPointsLength).round();

      Paint flowerImagePaint=Paint();
      Paint leafImagePaint=Paint();
      if(lineFractionInt<=branch.length){
        if(lineFractionInt>0 && (lineFractionInt<branch.length-5)){
          var animatePaint1 = Paint()
            ..color=((lineFractionInt%5)==0)?Colors.amber : const ui.Color.fromARGB(52, 152, 68, 248)
            ..strokeCap=StrokeCap.round
            ..strokeWidth=10;
          var animatePaint2 = Paint()
            ..color=((lineFractionInt%5)==0)?const ui.Color.fromARGB(52, 152, 68, 248):const ui.Color.fromARGB(255, 178, 253, 116) 
            ..strokeCap=StrokeCap.round
            ..strokeWidth=6;

          var animate1Offset=Offset((branch[lineFractionInt+3].dx-100)*scaleFactor, (branch[lineFractionInt+3].dy-100)*scaleFactor);
          var animate2Offset=Offset((branch[lineFractionInt+3].dx-110)*scaleFactor,(branch[lineFractionInt+3].dy-110)*scaleFactor);
          var animate3Offset=Offset((branch[lineFractionInt+3].dx+10-100)*scaleFactor,(branch[lineFractionInt+3].dy+10-100)*scaleFactor);
          
          // Growing Animation
          canvas.drawPoints(ui.PointMode.points, [animate1Offset], animatePaint1);
          canvas.drawPoints(ui.PointMode.points, [animate2Offset], animatePaint2);
          canvas.drawPoints(ui.PointMode.points, [animate3Offset], animatePaint2);
        }

        // Drawing branch stroke, leaf and flower at specified gaps.
        for(var p=0;p<lineFractionInt-2;p++){
          if(branch[p]!=Offset.zero && branch[p+1]!=Offset.zero){
            // Correction Values
            // Initially, recorded the branch strokes in the 
            //canvas with ref points started from 100,100
            // So correcting the same
            var correctionValues=Offset((branch[p].dx-100)*scaleFactor, (branch[p].dy-100)*scaleFactor);
            canvas.drawPoints(ui.PointMode.points, [correctionValues], lpaint);
            // Draw leaf at the points divisible by 10
            if(p%10==0){
              Offset leafOffset=Offset((branch[p].dx-110)*scaleFactor,(branch[p].dy-110)*scaleFactor);
              // Find angle and draw image for variations
              var lx1=branch[p].dx;
              var ly1 = branch[p].dy;
              var lx2 = branch[p+1].dx;
              var ly2=branch[p+1].dy;
              var langle = atan((ly2-ly1)/(lx2-lx1)) * (180/pi);
              canvas.save();
              canvas.translate(leafOffset.dx+7, leafOffset.dy+7);
              canvas.rotate(langle);
              canvas.translate(-leafOffset.dx-7, -leafOffset.dy-7);
              canvas.drawImage(leafImage, leafOffset, leafImagePaint);
              canvas.restore();
            }
          }
        }    

        // Draw Flowers at the points divisible by 30 and at end
        for(var p=0;p<lineFractionInt-2;p++){
          if(branch[p]!=Offset.zero && branch[p+1]!=Offset.zero){
            if(p%30==0){
              // Draw Flower
              var imageOffset = Offset((branch[p].dx-115)*scaleFactor, (branch[p].dy-115)*scaleFactor);
              // Find angle and draw image for variations
              var x1=branch[p].dx;
              var y1 = branch[p].dy;
              var x2 = branch[p+1].dx;
              var y2=branch[p+1].dy;
              var angle = atan((y2-y1)/(x2-x1)) * (180/pi);
              canvas.save();
              canvas.translate(imageOffset.dx+15, imageOffset.dy+15);
              canvas.rotate(angle);
              canvas.translate(-imageOffset.dx-15, -imageOffset.dy-15);
              canvas.drawImage(flowerImage, imageOffset, flowerImagePaint);
              canvas.restore();
            }
          }
        }   
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}