import 'package:flutter/material.dart';
import 'package:poke_dex/view/view_mode_bottom_sheet.dart';

class TopHeadMenu extends StatelessWidget {
  const TopHeadMenu({
    Key? key,
    required this.isFavoriteMode,
    required this.changeFavMode,
    required this.isGridMode,
    required this.changeGridMode,
  }) : super(key: key);

  final bool isFavoriteMode;
  final Function(bool) changeFavMode;
  final bool isGridMode;
  final Function(bool) changeGridMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      alignment: Alignment.topRight,
      child: IconButton(
        padding: const EdgeInsets.all(0),
        icon: const Icon(Icons.auto_awesome_mosaic_outlined),
        onPressed: () async{
          await showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              builder: (BuildContext context) {
                return ViewModeBottomSheet(
                  favMode: isFavoriteMode,
                  changeFavMode: changeFavMode,
                  gridMode: isGridMode,
                  changeGridMode: changeGridMode,
                );
              }
          );
        },
      ),

    );
  }
}
