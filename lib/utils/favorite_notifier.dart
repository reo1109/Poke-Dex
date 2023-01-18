import 'package:flutter/material.dart';
import 'package:poke_dex/db/favorites.dart';
import 'package:poke_dex/model/favorite.dart';

class FavoriteNotifier extends ChangeNotifier {
  final List<Favorite> _favs =[];

  FavoritesNotifier() {
    syncDb();
  }

  List<Favorite> get favs => _favs;

  void toggle(Favorite fav){
    if(isExist(fav.pokeId)) {
      delete(fav.pokeId);
    } else {
      add(fav);
    }
  }

  bool isExist(int id){
    if(_favs.indexWhere((fav) => fav.pokeId == id) < 0) {
      return false;
    }
    return true;
  }

  void syncDb() {
    FavoritesDb.read().then((val) {
      val.sort((a, b) => a.pokeId.compareTo(b.pokeId));
      _favs
        ..clear()
        ..addAll(val);
    });
    notifyListeners();
  }

  void add(Favorite fav) async {
    await FavoritesDb.create(fav);
    syncDb();
  }

  void delete(int id) async{
    await FavoritesDb.delete(id);
    syncDb();
  }
}
