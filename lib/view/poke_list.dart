import 'package:flutter/material.dart';
import 'package:poke_dex/view/poke_list_item.dart';

class PokeList extends StatefulWidget {
  const PokeList({Key? key}) : super(key: key);

  @override
  State<PokeList> createState() => _PokeListState();
}

class _PokeListState extends State<PokeList> {
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

