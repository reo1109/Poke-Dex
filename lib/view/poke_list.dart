import 'package:flutter/material.dart';
import 'package:poke_dex/api/poke_api.dart';
import 'package:poke_dex/const/const.dart';
import 'package:poke_dex/model/favorite.dart';
import 'package:poke_dex/utils/favorite_notifier.dart';
import 'package:poke_dex/view/poke_grid_item.dart';
import 'package:poke_dex/view/poke_list_item.dart';
import 'package:poke_dex/view/view_mode_bottom_sheet.dart';
import 'package:provider/provider.dart';

class PokeList extends StatefulWidget {
  const PokeList({Key? key}) : super(key: key);

  @override
  State<PokeList> createState() => _PokeListState();
}

class _PokeListState extends State<PokeList> {

  static const pageSize = 30;
  int _currentPage = 1;
  bool isFavoriteMode = false;
  bool isGridMode = true;

  int itemCount(int favsCount, int page) {
    int ret = page * pageSize;
    if(isFavoriteMode && ret > favsCount) {
      ret = favsCount;
    }
    if(ret > pokeMaxId) {
      ret = pokeMaxId;
    }
    return ret;
  }

  int itemId(List<Favorite> favs, int index) {
    int ret = index + 1;
    if (isFavoriteMode && index < favs.length) {
      ret = favs[index].pokeId;
    }
    return ret;
  }

  bool isLastPage(int favsCount, int page) {
    if (isFavoriteMode) {
      if (_currentPage * pageSize < favsCount) {
        return false;
      }
      return true;
    } else {
      if (_currentPage * pageSize < pokeMaxId) {
        return false;
      }
      return true;
    }
  }

  void changeMode(bool currentMode) {
    setState(() => isFavoriteMode = !currentMode);
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteNotifier>(builder: (context, favs, child) => Column(
      children: [
        Container(
          height: 24,
          alignment: Alignment.topRight,
          child: IconButton(
            padding: const EdgeInsets.all(0),
            icon: const Icon(Icons.auto_awesome_outlined),
            onPressed: () async{
              var ret = await showModalBottomSheet(context: context, builder: (BuildContext context){
                return ViewModeBottomSheet(favMode: isFavoriteMode);
              });
              if(ret != null && ret){
                changeMode(isFavoriteMode);
              }
            },
          ),
        ),
        Expanded(
          child: Consumer<PokemonsNotifier>(
              builder: (context, pokes, child) {
                if(itemCount(favs.favs.length, _currentPage) == 0) {
                  return const Text('no data');
                } else if (isGridMode) {
                  return GridView.builder(
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: itemCount(favs.favs.length, _currentPage) + 1,
                    itemBuilder: (context, index) {
                      if (index ==
                          itemCount(favs.favs.length, _currentPage)) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: OutlinedButton(
                            child: const Text('more'),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed:
                            isLastPage(favs.favs.length, _currentPage)
                                ? null
                                : () => {
                              setState(() => _currentPage++),
                            },
                          ),
                        );
                      } else {
                        return PokeGridItem(
                          poke: pokes.byId(itemId(favs.favs, index)),
                        );
                      }
                    },
                  );
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4, horizontal: 16),
                    itemCount: itemCount(favs.favs.length, _currentPage) + 1,
                    itemBuilder: (context, index) {
                      if (index == itemCount(favs.favs.length, _currentPage)) {
                        return OutlinedButton(
                          onPressed: isLastPage(favs.favs.length, _currentPage)
                              ? null
                              : () => {
                            setState(() => _currentPage++),
                          },
                          child: const Text('more'),
                        );
                      } else {
                        return PokeListItem(
                          poke: pokes.byId(itemId(favs.favs, index)),
                        );
                      }
                    },
                  );
                }
              }
          ),
        ),
      ],
    ),
    );
  }
}
