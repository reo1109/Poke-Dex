import 'package:flutter/material.dart';
import 'package:poke_dex/utils/theme_mode_selection.dart';
import 'package:poke_dex/view/theme_mode_selection_page.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  ThemeMode _themeMode = ThemeMode.system;
  @override
  void initState() {
    super.initState();
    loadThemeMode().then((val) => setState(() => _themeMode = val));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.lightbulb),
            title: const Text('Dark/Light Mode'),
            trailing: Text((_themeMode == ThemeMode.system)
                ? 'System'
                : (_themeMode == ThemeMode.dark ? 'Dark' : 'Light')),
            onTap: () async {
              final ret = await Navigator.of(context).push<ThemeMode>(
                MaterialPageRoute(builder: (context) => ThemeModeSelectionPage(mode: _themeMode))
              );
              setState(() => _themeMode = ret!);
              await saveThemeMode(_themeMode);
            },
          )
        ],
    );
  }
}
