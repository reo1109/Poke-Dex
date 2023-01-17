import 'package:flutter/material.dart';
import 'package:poke_dex/const/colors.dart';
import 'package:poke_dex/model/favorite.dart';
import 'package:poke_dex/model/pokemon.dart';
import 'package:poke_dex/utils/favorite_notifier.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PokeDetailPage extends StatelessWidget {
  const PokeDetailPage({Key? key, required this.poke}) : super(key: key);
  final Pokemon poke;

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteNotifier>(
        builder: (context, favs, child) => Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  trailing: IconButton(
                    icon: favs.isExist(poke.id)
                        ? const Icon(Icons.star, color: Colors.orangeAccent)
                        : const Icon(Icons.star_outline),
                    onPressed: () => {
                      favs.toggle(Favorite(pokeId: poke.id)),
                    },
                  ),
                ),
                const Spacer(),
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(32),
                      child: Hero(
                        tag: poke.name,
                        child: CachedNetworkImage(
                          imageUrl: poke.imageUrl,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          height: 200,
                          width: 200,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'No.${poke.id}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  poke.name,
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: poke.types
                      .map(
                        (type) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Chip(
                        backgroundColor: pokeTypeColors[type] ?? Colors.grey,
                        label: Text(
                          type,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: (pokeTypeColors[type] ?? Colors.grey)
                                .computeLuminance() >
                                0.5
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ).toList(),
                ),
                const Spacer(),
              ],
            ),
          ),
        )
    );
  }
}
