import 'package:flutter/material.dart';
import 'package:gamezy/models/recommeded_tile.dart';

class RootProvider extends ChangeNotifier {
 final List<RecommendedTile> _recommendedTileList = [];
 String? _cursor;

 List<RecommendedTile> get recommendedTileList => _recommendedTileList;
 String? get cursor => _cursor;

 void addTiles(List<RecommendedTile> tiles){
   _recommendedTileList.addAll(tiles);
   notifyListeners();
 }
 void clearTiles(){
   _recommendedTileList.clear();
   notifyListeners();
 }
 void updateCursor(String? cur){
   _cursor = cur;
   notifyListeners();
 }
}