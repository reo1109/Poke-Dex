import 'package:flutter/material.dart';
import 'package:poke_dex/view/poke_detail_page.dart';

class PokeList extends StatelessWidget {
  const PokeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 898,
        itemBuilder: (context, index) => PokeListItem(index: index),
      ),
    );
  }
}

class PokeListItem extends StatelessWidget {
  const PokeListItem({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 80,
        decoration: BoxDecoration(
          color: Colors.yellow.withOpacity(.5),
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            fit: BoxFit.fitWidth,
            image: NetworkImage(
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
            ),
          ),
        ),
      ),
      title: const Text(
        'Pikachu',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: const Text(
        '⚡️electric',
      ),
      trailing: const Icon(Icons.navigate_next),
      onTap: () => {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const PokeDetailPage(),
          ),
        ),
      },
    );
  }
}