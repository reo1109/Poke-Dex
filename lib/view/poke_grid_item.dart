import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poke_dex/const/colors.dart';
import 'package:poke_dex/model/pokemon.dart';
import 'package:poke_dex/view/poke_detail_page.dart';

class PokeGridItem extends StatelessWidget {
  const PokeGridItem({Key? key, required this.poke, required this.isShinyMode}) : super(key: key);
  final Pokemon? poke;
  final bool isShinyMode;
  @override
  Widget build(BuildContext context) {
    if (poke != null) {
      return Column(
        children: [
          InkWell(
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => PokeDetailPage(poke: poke!, isShinyMode: isShinyMode,),
                ),
              ),
            },
            child: Hero(
              tag: poke!.name,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: (pokeTypeColors[poke!.types.first] ?? Colors.grey[100])
                      ?.withOpacity(.3),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: CachedNetworkImageProvider(
                      isShinyMode ? poke!.shinyImageUrl : poke!.defaultImageUrl,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
            poke!.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      );
    } else {
      return const SizedBox(
        height: 100,
        width: 100,
        child: Center(
          child: Text('...'),
        ),
      );
    }
  }
}