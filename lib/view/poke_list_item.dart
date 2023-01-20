import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poke_dex/const/colors.dart';
import 'package:poke_dex/model/pokemon.dart';
import 'package:poke_dex/view/poke_detail_page.dart';

class PokeListItem extends StatelessWidget {
  const PokeListItem({Key? key, required this.poke, required this.isShinyMode}) : super(key: key);
  final Pokemon? poke;
  final bool isShinyMode;

  @override
  Widget build(BuildContext context) {
    if (poke != null) {
      return ListTile(
        leading: Hero(
          tag: poke!.name,
          child: Container(
            width: 80,
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
        title: Text(
          poke!.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(poke!.types.first),
        trailing: const Icon(Icons.navigate_next),
        onTap: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => PokeDetailPage(poke: poke!, isShinyMode: isShinyMode,),
            ),
          ),
        },
      );
    } else {
      return const ListTile(title: Text('...'));
    }
  }
}