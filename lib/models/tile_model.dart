import 'package:flutter/material.dart';

class TileModel {
  final Offset position;
  final Offset coOrdinates;
  final List<Offset> branchPoints;
  final double branchWidth;
  final Color branchColor;

  const TileModel({required this.position, required this.coOrdinates, required this.branchPoints,required this.branchColor, required this.branchWidth});
  
}