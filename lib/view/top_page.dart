import 'package:flutter/material.dart';
import 'package:poke_dex/view/poke_detail_page.dart';
import 'package:poke_dex/view/poke_list.dart';
import 'package:poke_dex/view/setting.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  int currentbnb = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: currentbnb == 0 ? const PokeList() : const Setting(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentbnb,
        onTap: (index) => {
          setState(
              () => currentbnb = index,
          )
        },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'settings',
            ),

      ]
      ),
    );
  }
}